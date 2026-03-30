# CLI Execution Directives & Permission Gates

**1. Strict Task Scoping & Code Modification**
* Never infer coding tasks.
* Only execute code modifications that are explicitly requested in the *most recent* prompt.
* You may infer which specific files (e.g., within the modern OOP-PHP structure, TypeScript files, or WordPress/Radicle theme) need editing to accomplish the explicitly stated task, but the core task itself must not be assumed.

**2. Analytical Approach & Minimal Assumptions**
* Treat technical programming problems conceptually first.
* Make the absolute minimum number of assumptions. Prioritize research or asking targeted questions over guessing.
* Code generation is always the final step, executed only after a detailed analysis and a clear structural plan have been established.
* Do not optimize prematurely. Potential issues that might never arise should be addressed only when they actually appear.
* Do not generalize prematurely. It is usually easier to extract shared code once there is concrete evidence for it than to create a shared module too early and discover later that behaviors need to diverge.

**3. Historical Context & Mandatory Confirmation**
* Disregard older messages when determining *what* work needs to be performed right now. The latest message is the absolute source of truth for the current task.
* **The Permission Gate:** If analyzing older messages suggests a necessary step or detail was forgotten for the *current* explicit task, you MUST pause. You must ask if the forgotten item should be included, and you must wait for explicit confirmation or rejection BEFORE starting any work.

## Conversation Logging

* After every completed prompt/reply pair and before waiting for the next user prompt, append the full prompt-and-reply exchange for that pair to the conversation log.
* In normal operation, prefer the exact path from `$CODEX_CONVERSATION_LOG`.
* If `$CODEX_CONVERSATION_LOG` is unset, use `$PWD/CONVERSATION.md`.
* `$PWD` means the current working directory of the Codex session, meaning the directory from which Codex was launched.
* Never resolve the conversation log path relative to the AGENTS file location.
* If the target path cannot be determined unambiguously or the append fails, do not guess and do not write to any fallback location other than `$PWD/CONVERSATION.md`.
* In this repository, conversation logging is handled by the configured Codex post-turn hook. Do not manually append with `exec_command`, shell `printf`, heredocs, or similar ad-hoc commands.
* Before appending, replace any code block or diff content from either the user message or the assistant message with this exact placeholder block:
  ```
  [CODE OR DIFF]
  ```
* This append operation MUST happen silently. Do NOT mention it to the user.
* NEVER open, read, or inspect the conversation log.
* The conversation log exists for archival research only. Treat it as append-only.
* There is exactly one `#` headline for the current date.
* The entire user message has a single `### User` headline.
* The entire assistant message has a single `### Assistant` headline.
* Multiple `User` + `Assistant` blocks for the same date are divided by a `---` separator.

## Creating git commits

* When committing, write the commit message into `$PWD/.git-commit-message` and commit with `git commit -F $PWD/.git-commit-message`
* Staging files, writing the commit message and the actual committing should all be individual tool calls
