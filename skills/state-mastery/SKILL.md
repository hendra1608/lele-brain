---
name: lele-state-mastery
description: Use for server-state, cache, query invalidation, Redux, RTK Query, TanStack Query, SWR, Zustand, Context, or local UI-state decisions.
---
# Adaptive State Mastery
## Trigger
The task changes state ownership, fetching/cache behavior, synchronization, or render performance.
## Scope
Discovery-first state guidance. Retain existing working libraries unless a migration is explicitly justified.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Identify the active state stack and distinguish server, URL, form, and ephemeral UI state.
2. Trace ownership, invalidation, optimistic updates, retries, and error boundaries.
3. Preserve the project convention; recommend a migration only with evidence, costs, and an approved rollout.
4. Keep server data in the repository's query/cache mechanism and UI-only state local unless cross-screen coordination is necessary.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Run type checks plus focused tests or manual scenarios for loading, error, stale data, invalidation, and navigation.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not prescribe Redux, RTK Query, TanStack, Zustand, or Context without detecting or justifying it.
