---
name: Strategic Feature Planner
description: High-level architectural analysis and implementation strategy for complex features.
---

# Strategic Feature Planner Skill

This skill is invoked when Bos gives a complex feature request that spans multiple layers (DB, BE, FE) or requires significant design decisions.

## Phase 1: Impact Analysis (English Reasoning)
Before proposing any code, analyze the following:
1.  **Multi-Repo Synchronization**: Identify if changes are needed in `slp-be-nest-slp` (Prisma/Controllers) to support the `slp-fe-next-slp` request.
2.  **Data Layer Impact**: Does this require migrations?
3.  **API Surface**: What new endpoints or changes to `UniversalUseCase` are needed?
4.  **UI/UX Mapping**: How does this fit into the permission structure?
5.  **Security/Roles**: Which `ModuleEnum` and `roleAPI` entries need updating?

## Phase 2: Design Patterns
- **Atomic Components**: Favor `_components` subfolders for feature-specific logic.
- **Data Adapters**: Always use adapters to transform raw API responses into clean UI-compatible objects.
    - Avoid direct usage of `any` from API responses.
    - Define interfaces in `_types/index.ts`.
- **Visual Polish**: 
    - Use AntD `App` context for notifications.
    - Implement Skeleton loading states for data-heavy sections.
    - Use Framer Motion for cross-page transitions.

## Phase 3: The "Surgical" Implementation Strategy
- Implement dependencies first (DB schema → BE Controller → FE Types → FE Components → FE Page).
- Verify build status at each atomic step.
- Update `task.md` concurrently.

## Execution Rules
- **Language**: Core logic and reasoning should be documented in English for maximum precision.
- **Validation**: Never mark a task as done without verifying the build and lint status.
- **Reporting**: Report progress to Bos using Indonesian (Professional & Relaxed).
