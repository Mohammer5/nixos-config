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

# Workflows

- Every workflow is optional and opt-in only.
  - They are not enforced by default.
  - Developers must explicitly choose to use this task-based system.
  - Exception for Kanban workflow activation:
    - If a `.board` folder exists in the project root, the Kanban workflow is automatically active.
    - If no `.board` folder exists, Kanban is active only when explicitly requested by the user.

## Workflow: Kanban board

### Progress tracking

- Progress is tracked by organizing files in a `.board` folder in the project's root
  - Ensure that the `.board` folder is in the `.gitignore`
- To be able to differentiate between different tasks, use the following folder structure / organization: `.board/tasks/<branch-name>/tasks.md`
- Keep `.board/tasks/<branch-name>/tasks.md` as a lightweight index to reduce context usage:
  - Prefer concise ticket summaries in `tasks.md` (title, type, status, blockers, short acceptance summary).
  - Store full ticket details in per-ticket files under `.board/tasks/<branch-name>/tickets/` and reference them from `tasks.md`.
- To persist the current working state, add a `.board/tasks/<branch-name>/WORKING_STATE.md` into the project's root.
  - Keep `.board/tasks/<branch-name>/WORKING_STATE.md` updated as the compact execution memory for the current phase.
  - `.board/tasks/<branch-name>/WORKING_STATE.md` synchronization is mandatory during execution, not only at task end:
    - Update it whenever progress meaningfully changes (task start, scope shift, blocker discovered/cleared, verification milestone, task completion).
    - Keep `Current Objective`, `In Progress`, and `Next Up` aligned with actual state after each meaningful step.
    - Remove or rewrite stale entries immediately when architecture/runtime direction changes.
    - Before recommending the next task, ensure `.board/tasks/<branch-name>/WORKING_STATE.md` reflects the latest verified state.
  - Read policy: `WORKING_STATE.md` is the primary file to load first for execution context.

### General rules

- In "Progress", multiple `task` tickets are allowed when parallel work is sensible.
- In "Progress", there must never be more than one `epic` ticket at the same time.
- When plans/architecture assumptions change, propose Kanban updates as an explicit diff first and ask for confirmation.
- Only after explicit user confirmation, apply Kanban edits to `.board/tasks/<branch-name>/tasks.md`.
- Kanban must always have exactly these sections, in this order:
  - `## Backlog`
  - `## In Progress`
  - `## Done`
- Every ticket must exist in exactly one section (`Backlog`, `In Progress`, or `Done`).
- Ticket lifecycle automation:
  - When work starts on a ticket, move it `Backlog -> In Progress`.
  - When work is completed, move it `In Progress -> Done`.
  - If work is blocked/paused, keep it in `In Progress` and add/update blocker notes in `**Comments:**`.
- Done archive rule:
  - Keep only recently completed tickets in `## Done` within `tasks.md`.
  - Move older completed tickets to `.board/tasks/<branch-name>/archives/` (for example `done-YYYY-MM.md`) and leave a short pointer in `tasks.md` when useful.
- Git workflow on completion:
  - When moving a ticket from `In Progress` to `Done`, commit the related changes.
  - Use as few commits as possible while preserving conceptual clarity (one conceptual change per commit where practical).
  - Use Conventional Commits for commit messages.
- Next-task authority:
  - The assistant is responsible for proposing the next ticket whenever `In Progress` is empty.
  - After completing work and updating Kanban state, the assistant must explicitly recommend the next ticket to start.
- State-transition autonomy:
  - Ticket moves between `Backlog`, `In Progress`, and `Done` are pre-authorized and do not require separate confirmation.
  - Non-state Kanban edits (scope/description/acceptance-criteria changes) still require diff proposal + confirmation.
  - Precedence: these state-transition autonomy rules override the general confirmation rule for pure state moves.
- Traceability on moves:
  - Add dated `**Comments:**` note when moved to `In Progress` (start date).
  - Add dated `**Comments:**` note when moved to `Done` (completion summary).
- Acceptance Criteria are required for tickets in `In Progress` and `Done`.
- Stop conditions are required for tickets in `In Progress` and `Done`.
- Backlog tickets do not need `**Artifacts:**` yet.
- Before moving any ticket from `Backlog` to `In Progress`, `**Artifacts:**` must be defined as a compact scope summary.
- `**Artifacts:**` should prefer directory-level paths, narrowly scoped globs, or a short sentence describing the affected area.
- Do not enumerate every produced or touched file unless the user explicitly asks for that level of detail.
- A ticket cannot be moved to `In Progress` if `**Artifacts:**` is missing, unless `**Artifacts:** None (no files produced)` is explicitly stated.
- Before moving any ticket from `Backlog` to `In Progress`, add Acceptance Criteria with explicit docs targets:
  - `docs/technical/` impact (required for architectural or infra changes)
  - `docs/features/` impact (required for implemented behavior changes)
  - `docs/user/` impact (required once the app has user-facing interaction surfaces)
- Backlog ordering rule:
  - Put the next tickets we plan to execute at the top of `Backlog`.
  - If tickets can be executed in parallel, keep them co-located; order between those co-located parallel tickets is not important.
- Backlog size rule:
  - Keep `Backlog` in `tasks.md` focused on near-term work.
  - Move far-future or parked items to `.board/tasks/<branch-name>/archives/backlog-later.md`.
- Epic linkage rule:
  - Every `task` ticket must include an `**Epic:** <epic title>` field.
  - A task cannot be moved to `In Progress` without an `Epic` link.
- Epic dependency rule:
  - Every `epic` except the first must be blocked by another `epic` so execution order is explicit.
- "comments" should be added as sub points, e.g.:
  ```
  **Comments:**
  - First comment
    with multiple lines
  - Second comment in one line
  ```
- While we're working on the app, we track the progress in this kanban board.
  - We use it to determine the next tasks
  - We use it to store context that's only understood/explore while working on tasks as comments on the ticket
- Context-efficiency rule:
  - Prefer reading only `WORKING_STATE.md`, the `In Progress` section, and the ticket files referenced by active work.
  - Avoid loading full archives unless required for a concrete decision.
- Aggressive context budget rules:
  - Hard board limits in `.board/tasks/<branch-name>/tasks.md`:
    - `In Progress`: maximum 1 `epic` and maximum 3 `task` tickets.
    - `Backlog`: maximum 10 near-term tickets.
    - `Done`: maximum 20 most-recent completed tickets.
  - Externalize ticket details by default:
    - Keep `tasks.md` entries minimal and index-style: `ID`, `Type`, `Title`, `Status`, `Epic`, `Blocked by`, and pointer to ticket file.
    - Store full `Description`, detailed `Acceptance Criteria`, compact `Artifacts` scope, and long `Comments` in `.board/tasks/<branch-name>/tickets/<ticket-id>.md`.
  - Rolling working-state compaction:
    - Rewrite `.board/tasks/<branch-name>/WORKING_STATE.md` into a compact snapshot at least once every 5 meaningful updates.
    - Keep `WORKING_STATE.md` to a maximum of 25 lines.
  - Read budget:
    - Default reads are limited to `.board/tasks/<branch-name>/WORKING_STATE.md`, active ticket file(s), and top-priority backlog slice.
    - Archives and historical tickets are read only when required for a concrete decision or explicitly requested.
  - Structured, low-token ticket format:
    - Prefer short key-value fields over long prose.
    - Keep each `**Comments:**` entry to a maximum of 3 lines unless explicitly requested.
  - Evidence placement:
    - Store verbose logs, test outputs, and long diffs under `.board/tasks/<branch-name>/evidence/`.
    - In task files, reference evidence paths and summarize outcomes in 1-2 lines.
  - Ticket IDs:
    - Every ticket must have a stable short ID (for example `T-123`).
    - Cross-references should use ticket IDs instead of repeating long titles/descriptions.
  - Phase partitioning:
    - For large initiatives, use phase-scoped board files under `.board/tasks/<branch-name>/archives/` and keep only the current phase active in `tasks.md`.
  - Response brevity default:
    - Unless the user asks for detail, keep status/progress responses concise and avoid restating full requirements.
- When finishing any work item, always check whether the Kanban board should be updated to reflect status/progress/notes.

#### Example ticket format

```
# `tasks.md` index entry (lightweight)
- **ID:** T-123
  **Type:** task
  **Title:** Normalized macro/market observation schema
  **Status:** In Progress
  **Epic:** Business-cycle assessment framework + evidence model
  **Blocked by:** Required data series + source registry
  **Ticket File:** `.board/tasks/<branch-name>/tickets/T-123.md`
  **Comments:**
  - Started on 2026-03-10.

# `.board/tasks/<branch-name>/tickets/T-123.md` detail entry
- **ID:** T-123
  **Description:** Define the canonical observation schema for raw external series, provenance, release timestamps, revisions, seasonal-adjustment status, and derived-feature input references so connectors and downstream inference use one stable contract.
  **Artifacts:**
  - `schemas/observations/`
  - `src/runtime/contracts/`
  - `docs/technical/`
  - `docs/features/`
  - `tests/js/`
  **Acceptance Criteria:**
  - **Command(s):**
    - `test -f schemas/observations/market-observation.schema.json`
    - `node --test tests/js/market_observation_schema.test.js`
  **Stop condition:**
    - repository contains schema, docs, and contract tests sufficient to constrain connector output normalization.
  **Comments:**
  - 2026-03-10: Defined raw evidence contract only; connectors/feature calculations are out of scope.
```
