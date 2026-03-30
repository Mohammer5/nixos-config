#!/usr/bin/env node

const crypto = require("node:crypto");
const fs = require("node:fs");
const path = require("node:path");

const PLACEHOLDER_BLOCK = "```\n[CODE OR DIFF]\n```";
const FENCED_BLOCK_RE = /```[\s\S]*?```/g;
const PATCH_BLOCK_RE = /^\*\*\* Begin Patch[\s\S]*?^\*\*\* End Patch\s*$/gm;
const TRANSCRIPT_ARRAY_KEYS = [
  "messages",
  "transcript",
  "conversation",
  "events",
  "items",
  "entries",
  "turn",
  "turns",
  "output-messages",
  "all-messages",
];
const HIDDEN_ROLES = new Set(["system", "developer", "tool"]);
const VISIBLE_ASSISTANT_CHANNELS = new Set(["commentary", "final"]);

function eprint(message) {
  process.stderr.write(`${message}\n`);
}

function readStdin() {
  return new Promise((resolve, reject) => {
    const chunks = [];

    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => chunks.push(chunk));
    process.stdin.on("end", () => resolve(chunks.join("")));
    process.stdin.on("error", reject);
  });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function normalizeMessage(message) {
  let text = "";
  if (message === null || message === undefined) {
    text = "";
  } else if (typeof message === "string") {
    text = message;
  } else {
    text = JSON.stringify(message, null, 2);
  }

  return text
    .replace(/\r\n/g, "\n")
    .replace(/\r/g, "\n")
    .replace(FENCED_BLOCK_RE, PLACEHOLDER_BLOCK)
    .replace(PATCH_BLOCK_RE, PLACEHOLDER_BLOCK)
    .trim();
}

function joinMessages(messages) {
  if (Array.isArray(messages)) {
    return messages.map(normalizeMessage).join("\n\n").trim();
  }
  return normalizeMessage(messages);
}

function normalizeWhitespace(value) {
  return value.replace(/\r\n/g, "\n").replace(/\r/g, "\n");
}

function contentBlocks(value) {
  if (Array.isArray(value)) {
    return value;
  }

  if (value && typeof value === "object") {
    if (Array.isArray(value.content)) {
      return value.content;
    }
    if (Array.isArray(value.parts)) {
      return value.parts;
    }
    if (Array.isArray(value.items)) {
      return value.items;
    }
  }

  return null;
}

function extractText(value) {
  if (value === null || value === undefined) {
    return "";
  }

  if (typeof value === "string") {
    return normalizeWhitespace(value);
  }

  if (Array.isArray(value)) {
    return value.map(extractText).filter(Boolean).join("\n\n");
  }

  if (typeof value !== "object") {
    return normalizeWhitespace(String(value));
  }

  const blocks = contentBlocks(value);
  if (blocks) {
    const parts = blocks
      .map((block) => {
        if (typeof block === "string") {
          return block;
        }
        if (!block || typeof block !== "object") {
          return "";
        }

        const type = typeof block.type === "string" ? block.type : "";
        if (type.startsWith("tool")) {
          return "";
        }
        if (type === "text" || type === "input_text" || type === "output_text") {
          return extractText(block.text ?? block.value ?? block.content);
        }
        if ("text" in block || "value" in block || "content" in block) {
          return extractText(block.text ?? block.value ?? block.content);
        }
        return "";
      })
      .filter(Boolean);

    if (parts.length > 0) {
      return parts.join("\n\n");
    }
  }

  if ("text" in value || "message" in value || "content" in value || "value" in value) {
    return extractText(value.text ?? value.message ?? value.content ?? value.value);
  }

  return "";
}

function messageRole(node) {
  if (!node || typeof node !== "object") {
    return null;
  }

  const role =
    typeof node.role === "string"
      ? node.role
      : typeof node.author === "string"
        ? node.author
        : typeof node.sender === "string"
          ? node.sender
          : typeof node.speaker === "string"
            ? node.speaker
            : null;

  return role ? role.toLowerCase() : null;
}

function messageChannel(node) {
  if (!node || typeof node !== "object") {
    return null;
  }

  const channel =
    typeof node.channel === "string"
      ? node.channel
      : typeof node.stream === "string"
        ? node.stream
        : typeof node.kind === "string"
          ? node.kind
          : null;

  return channel ? channel.toLowerCase() : null;
}

function isToolLike(node) {
  if (!node || typeof node !== "object") {
    return false;
  }

  if (
    (typeof node.recipient_name === "string" && node.recipient_name.length > 0) ||
    (typeof node.recipient === "string" && node.recipient.length > 0)
  ) {
    return true;
  }

  const values = [
    node.type,
    node.kind,
    node.event,
    node.event_type,
    node.recipient_name,
    node.recipient,
  ]
    .filter((value) => typeof value === "string")
    .map((value) => value.toLowerCase());

  return values.some((value) => value.includes("tool"));
}

function visibleMessage(node) {
  const role = messageRole(node);
  if (!role || HIDDEN_ROLES.has(role) || isToolLike(node)) {
    return null;
  }

  if (role === "assistant") {
    const channel = messageChannel(node);
    if (channel && !VISIBLE_ASSISTANT_CHANNELS.has(channel)) {
      return null;
    }
  }

  if (role !== "user" && role !== "assistant") {
    return null;
  }

  const text = normalizeMessage(extractText(node));
  if (!text) {
    return null;
  }

  return { role, text };
}

function scoreTranscriptArray(items) {
  return items.map(visibleMessage).filter(Boolean);
}

function findTranscriptArrayMessages(root) {
  const visited = new WeakSet();
  const collected = [];

  function visit(node) {
    if (!node || typeof node !== "object") {
      return;
    }

    if (visited.has(node)) {
      return;
    }
    visited.add(node);

    if (Array.isArray(node)) {
      collected.push(...scoreTranscriptArray(node));
      for (const item of node) {
        visit(item);
      }
      return;
    }

    for (const key of TRANSCRIPT_ARRAY_KEYS) {
      if (Array.isArray(node[key])) {
        collected.push(...scoreTranscriptArray(node[key]));
      }
    }

    for (const value of Object.values(node)) {
      visit(value);
    }
  }

  visit(root);
  return collected;
}

function directTextFragments(node) {
  const fragments = [];
  const consumedKeys = new Set();

  for (const key of ["text", "message", "value", "content"]) {
    if (typeof node[key] === "string") {
      fragments.push(node[key]);
      consumedKeys.add(key);
    }
  }

  for (const key of ["content", "parts", "items"]) {
    if (Array.isArray(node[key])) {
      const text = extractText(node[key]);
      if (text) {
        fragments.push(text);
        consumedKeys.add(key);
      }
    }
  }

  return { fragments, consumedKeys };
}

function isVisibleRole(role, channel) {
  if (role === "assistant") {
    return !channel || VISIBLE_ASSISTANT_CHANNELS.has(channel);
  }

  return role === "user";
}

function collectVisibleMessages(root, seedContext = {}) {
  const messages = [];
  const visited = new WeakSet();

  function visit(node, context) {
    if (node === null || node === undefined) {
      return;
    }

    if (typeof node !== "object") {
      return;
    }

    if (visited.has(node)) {
      return;
    }
    visited.add(node);

    if (Array.isArray(node)) {
      for (const item of node) {
        visit(item, context);
      }
      return;
    }

    const role = messageRole(node) ?? context.role ?? null;
    const channel = messageChannel(node) ?? context.channel ?? null;
    const hidden =
      context.hidden === true ||
      (role ? HIDDEN_ROLES.has(role) : false) ||
      isToolLike(node);

    if (!hidden && role && isVisibleRole(role, channel)) {
      const { fragments, consumedKeys } = directTextFragments(node);
      for (const fragment of fragments) {
        const text = normalizeMessage(fragment);
        if (text) {
          messages.push({ role, text });
        }
      }

      for (const [key, value] of Object.entries(node)) {
        if (consumedKeys.has(key)) {
          continue;
        }
        visit(value, { role, channel, hidden });
      }
      return;
    }

    for (const value of Object.values(node)) {
      visit(value, { role, channel, hidden });
    }
  }

  visit(root, seedContext);
  return messages;
}

function dedupeMessages(messages) {
  const deduped = [];
  const seen = new Set();

  for (const entry of messages) {
    const key = `${entry.role}\u0000${entry.text}`;
    if (seen.has(key)) {
      continue;
    }
    seen.add(key);

    const last = deduped[deduped.length - 1];
    if (last && last.role === entry.role && last.text === entry.text) {
      continue;
    }
    deduped.push(entry);
  }

  return deduped;
}

function extractTranscript(payload) {
  const messages = dedupeMessages([
    ...findTranscriptArrayMessages(payload),
    ...collectVisibleMessages(payload),
    ...collectVisibleMessages(payload["input-messages"], { role: "user" }),
    ...collectVisibleMessages(payload["last-assistant-message"], {
      role: "assistant",
      channel: "final",
    }),
  ]);

  if (messages.length > 0) {
    return {
      userText: messages
        .filter((entry) => entry.role === "user")
        .map((entry) => entry.text)
        .join("\n\n")
        .trim(),
      assistantText: messages
        .filter((entry) => entry.role === "assistant")
        .map((entry) => entry.text)
        .join("\n\n")
        .trim(),
    };
  }

  return {
    userText: joinMessages(payload["input-messages"]),
    assistantText: normalizeMessage(payload["last-assistant-message"]),
  };
}

function resolveLogPath(payload) {
  const envPath = process.env.CODEX_CONVERSATION_LOG;
  if (envPath && path.isAbsolute(envPath)) {
    return envPath;
  }

  const cwd =
    typeof payload.cwd === "string" && payload.cwd.trim().length > 0
      ? payload.cwd
      : process.cwd();

  return path.join(cwd, "CONVERSATION.md");
}

function currentDateString() {
  return new Date().toLocaleDateString("en-CA");
}

function statePaths(logPath) {
  const stateRoot = path.join(
    path.dirname(logPath),
    ".codex-post-turn-hook",
  );
  fs.mkdirSync(stateRoot, { recursive: true });
  const key = crypto.createHash("sha256").update(path.basename(logPath)).digest("hex");
  return {
    statePath: path.join(stateRoot, `${key}.json`),
    lockPath: path.join(stateRoot, `${key}.lock`),
  };
}

function loadLastDate(statePath, logPath) {
  if (fs.existsSync(statePath)) {
    try {
      const data = JSON.parse(fs.readFileSync(statePath, "utf8"));
      return data.last_date || null;
    } catch {
      return null;
    }
  }

  if (fs.existsSync(logPath)) {
    const stats = fs.statSync(logPath);
    return new Date(stats.mtimeMs).toLocaleDateString("en-CA");
  }

  return null;
}

function writeState(statePath, lastDate) {
  const tempPath = `${statePath}.tmp`;
  fs.writeFileSync(tempPath, `${JSON.stringify({ last_date: lastDate })}\n`, "utf8");
  fs.renameSync(tempPath, statePath);
}

async function withLock(lockPath, fn) {
  const attempts = 200;
  for (let i = 0; i < attempts; i += 1) {
    try {
      fs.mkdirSync(lockPath);
      try {
        return await fn();
      } finally {
        fs.rmSync(lockPath, { recursive: true, force: true });
      }
    } catch (error) {
      if (error.code !== "EEXIST") {
        throw error;
      }
      await sleep(50);
    }
  }

  throw new Error(`timed out acquiring lock ${lockPath}`);
}

async function appendExchange(logPath, userText, assistantText) {
  const { statePath, lockPath } = statePaths(logPath);
  const today = currentDateString();

  fs.mkdirSync(path.dirname(logPath), { recursive: true });

  await withLock(lockPath, async () => {
    const logExists = fs.existsSync(logPath) && fs.statSync(logPath).size > 0;
    const lastDate = loadLastDate(statePath, logPath);

    let prefix = "";
    if (!logExists) {
      prefix = `# ${today}\n\n`;
    } else if (lastDate === today) {
      prefix = "\n\n---\n\n";
    } else {
      prefix = `\n\n# ${today}\n\n`;
    }

    const body = `### User\n${userText}\n\n### Assistant\n${assistantText}\n`;
    fs.appendFileSync(logPath, prefix + body, "utf8");
    writeState(statePath, today);
  });
}

async function main() {
  let rawPayload = "";
  if (process.argv.length === 3) {
    rawPayload = process.argv[2];
  } else if (process.argv.length === 2) {
    rawPayload = await readStdin();
  } else {
    eprint("codex-post-turn-hook: expected one JSON payload argument or JSON on stdin");
    process.exitCode = 1;
    return;
  }

  const trimmedPayload = rawPayload.trim();
  if (!trimmedPayload) {
    eprint("codex-post-turn-hook: empty payload");
    process.exitCode = 1;
    return;
  }

  let payload;
  try {
    payload = JSON.parse(trimmedPayload);
  } catch (error) {
    eprint(`codex-post-turn-hook: invalid JSON payload: ${error.message}`);
    process.exitCode = 1;
    return;
  }

  if (payload.type !== "agent-turn-complete") {
    return;
  }

  const logPath = resolveLogPath(payload);
  const transcript = extractTranscript(payload);
  const userText = transcript.userText || "(empty)";
  const assistantText = transcript.assistantText || "(empty)";

  try {
    await appendExchange(logPath, userText, assistantText);
  } catch (error) {
    eprint(`codex-post-turn-hook: failed to append ${logPath}: ${error.message}`);
    process.exitCode = 1;
  }
}

main();
