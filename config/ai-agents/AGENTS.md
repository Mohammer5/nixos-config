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
- To persist the current working state, add a `.board/tasks/<branch-name>/WORKING_STATE.md` into the project's root.
  - Keep `.board/tasks/<branch-name>/WORKING_STATE.md` updated as the compact execution memory for the current phase.
  - `.board/tasks/<branch-name>/WORKING_STATE.md` synchronization is mandatory during execution, not only at task end:
    - Update it whenever progress meaningfully changes (task start, scope shift, blocker discovered/cleared, verification milestone, task completion).
    - Keep `Current Objective`, `In Progress`, and `Next Up` aligned with actual state after each meaningful step.
    - Remove or rewrite stale entries immediately when architecture/runtime direction changes.
    - Before recommending the next task, ensure `.board/tasks/<branch-name>/WORKING_STATE.md` reflects the latest verified state.

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
- Backlog tickets do not need `**Artifacts:**` file lists yet.
- Before moving any ticket from `Backlog` to `In Progress`, `**Artifacts:**` must be defined with concrete expected files to be created/modified (paths and/or narrowly scoped globs).
- A ticket cannot be moved to `In Progress` if `**Artifacts:**` is missing, unless `**Artifacts:** None (no files produced)` is explicitly stated.
- When moving a ticket to `Done`, update `**Artifacts:**` so it reflects the actual touched/created files.
- Before moving any ticket from `Backlog` to `In Progress`, add Acceptance Criteria with explicit docs targets:
  - `docs/technical/` impact (required for architectural or infra changes)
  - `docs/features/` impact (required for implemented behavior changes)
  - `docs/user/` impact (required once the app has user-facing interaction surfaces)
- Backlog ordering rule:
  - Put the next tickets we plan to execute at the top of `Backlog`.
  - If tickets can be executed in parallel, keep them co-located; order between those co-located parallel tickets is not important.
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
- When finishing any work item, always check whether the Kanban board should be updated to reflect status/progress/notes.

#### Example ticket

```
- **Type:** task
  **Title:** Normalized macro/market observation schema
  **Epic:** Business-cycle assessment framework + evidence model
  **Description:** Define the canonical observation schema for raw external series, provenance, release timestamps, revisions, seasonal-adjustment status, and derived-feature input references so connectors and downstream inference use one stable contract.
  **Blocked by:** Required data series + source registry
  **Includes:** None
  **Artifacts:**
  - `schemas/observations/market-observation.schema.json`
  - `src/runtime/contracts/market_observation.js`
  - `src/runtime/contracts/index.js`
  - `src/runtime/index.js`
  - `docs/technical/normalized-observation-schema.md`
  - `docs/features/normalized-observation-schema.md`
  - `tests/js/market_observation_schema.test.js`
  - `.board/tasks/<branch-name>/WORKING_STATE.md`
  - `AGENTS.md`
  **Acceptance Criteria:**
  - **Command(s):**
    - `test -f schemas/observations/market-observation.schema.json`
    - `node --test tests/js/market_observation_schema.test.js`
    - `rg -n "^## (Purpose|Observation Identity|Temporal Fields|Publisher and Access Provenance|Revision and Adjustment Fields|Value Encoding|Derived Feature Input Rules|Open Questions)" docs/technical/normalized-observation-schema.md`
    - `rg -n "^## (What This Schema Does|Why Raw Observations Need Normalization|What Metadata Operators Can Trust|Current Limitations)" docs/features/normalized-observation-schema.md`
  - **Artifacts:**
    - every source-registry series can map into one canonical raw-observation object without family-specific schema forks
    - the schema distinguishes authoritative publisher from access path or fallback mirror
    - the schema distinguishes observation date, reference-period end, and release timestamp
    - revision behavior and seasonal-adjustment status are explicit fields rather than implicit assumptions
    - derived features are represented as references to raw observations, not mixed into raw observation values
  - **Docs:**
    - `docs/technical/` defines the raw-observation contract in implementation-ready detail
    - `docs/features/` explains what operators can trust about normalized observations and why the metadata exists
    - `docs/user/` no changes required in this phase
  - **Tests:**
    - add one contract test proving a valid observation payload passes and representative invalid payloads fail for missing temporal or provenance fields
  - **Invariants:**
    - this schema is the raw-observation boundary, not the feature-store schema
    - the same contract must support business-daily, weekly, monthly, and event-driven series
    - no connector-specific implementation details are allowed into the schema
    - the output must be specific enough to drive real connector contracts next
  **Stop condition:**
    - the repository contains a schema, docs, and contract test sufficient to constrain connector output normalization and derived-feature input design
  **Comments:**
  - Started on 2026-03-10 after completing `Required data series + source registry`.
  - 2026-03-10: This ticket defined the raw evidence contract only; it did not implement connectors or feature calculations.
  - Completed on 2026-03-10 after adding the market-observation schema, validator, contract test, and technical plus feature documentation.
```
