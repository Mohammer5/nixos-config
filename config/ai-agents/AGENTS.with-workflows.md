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
