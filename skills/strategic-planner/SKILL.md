---
name: lele-strategic-planner
description: Use for multi-layer features, architectural changes, cross-repository work, or decisions with meaningful compatibility or rollout risk.
---
# Strategic Feature Planner
## Trigger
The task spans multiple boundaries or needs a decision-complete implementation plan.
## Scope
Architecture and delivery planning, independent of framework, UI library, state library, or use-case naming convention.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Discover repository instructions, current architecture, contracts, data implications, authorization, and rollout constraints.
2. Define goal, acceptance criteria, public interfaces, affected layers, compatibility strategy, and verification.
3. Select child skills from the registry only for distinct risks.
4. Prefer incremental seams and backward-compatible delivery over broad rewrites.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Ensure the plan names evidence, tests, failure modes, and rollback/containment where relevant.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not require a particular UI library, animation library, use-case abstraction, role configuration, task file, or manual type pattern unless the repository already requires it.
