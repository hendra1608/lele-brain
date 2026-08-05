---
name: lele-librarian-compiler
description: Use to distill verified architecture, recurring patterns, decisions, or incidents into maintainable project documentation.
---
# Librarian Compiler
## Trigger
The user asks for wiki/docs/onboarding, or a reusable lesson must be recorded after verified work.
## Scope
Documentation governance. Repository wiki is preferred for repository-owned facts; Lele Brain stores only cross-project, reusable knowledge.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Identify audience, scope, source evidence, ownership, and sensitivity.
2. Write concise documentation that links to the authoritative local decision or contract.
3. Separate global practice from project-specific facts and mark freshness/status.
4. Avoid secrets, copied large source blocks, stale generated snapshots, and unverified claims.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Check links, file scope, factual source references, duplicate entries, and repository documentation conventions.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not create a wiki automatically when not requested, move private project facts into global knowledge, or claim source facts not verified.
