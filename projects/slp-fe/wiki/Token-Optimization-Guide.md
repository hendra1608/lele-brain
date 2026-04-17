# Token Optimization Guide

Saving tokens is critical for maintaining high velocity and reducing costs in long-running AI development sessions. Here are the core strategies used in the SLP project.

## 1. The "Brain" as Compressed Context
Instead of forcing the agent to read 3000+ line files (like `role.ts`) or scanning every directory, the **Wiki** acts as a high-density summary.
- **Strategy**: Ask the agent to read specific wiki nodes at the start of a session instead of the whole codebase.
- **Saving**: Reduces input tokens by 70-90% per research phase.

## 2. Granular Reading
Avoid `view_file` on massive files unless absolutely necessary.
- **Strategy**: Use `grep_search` to find specific code blocks or use `view_file` with `StartLine` and `EndLine` to only see the relevant function.
- **Saving**: Prevents context bloating from irrelevant lines.

## 3. Clear & Structured Prompts
Vague prompts lead to "exploratory" tool calls that consume tokens through trial and error.
- **Strategy**: Be specific about the file path and the goal. Example: *"Fix the status mapping in src/app/(pages)/survey/page.tsx to match role.ts"* instead of *"Fix the survey page"*.

## 4. Task Batching
The overhead of "starting" a task (system prompts, history buildup) happens for every new message.
- **Strategy**: Group 2-3 related small tasks into one message.
- **Saving**: Reduces the frequency of full conversation history re-processing.

## 5. Artifact Updating vs Re-creating
Updating an existing `walkthrough.md` is more token-efficient than creating a new one for every tiny change.
- **Strategy**: Keep the `task.md` and `implementation_plan.md` updated in-place.

## Related
- [[Wiki-Update-Protocol]]
- [[Development-Standards]]
