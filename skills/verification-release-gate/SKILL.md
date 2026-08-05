---
name: lele-verification-release-gate
description: Use before declaring work complete, committing, opening a PR, deploying, or accepting a broad refactor.
---
# Verification Release Gate
## Trigger
The task reaches a completion, release, commit, PR, or high-risk review boundary.
## Scope
Evidence-based validation and independent quality review; it complements rather than replaces the dominant implementation skill.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Derive explicit requirements and map each to evidence.
2. Inspect diff scope, generated-file ownership, contract/security impact, and repository status.
3. Run the narrowest relevant lint, type, test, build, contract, and migration checks without overstating their coverage.
4. Require independent review for requested score gates, security-sensitive changes, or materially broad refactors.
5. Score: security 35, deterministic routing 25, knowledge scope/freshness 20, operational safety 10, skill completeness/validation 10. Any P0/P1 fails regardless of numeric score.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Require clean targeted validator output, `git diff --check`, appropriate repository checks, review findings resolved, and explicit skipped-check/risk statement.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not claim green status from unrelated checks, self-grade an independent-review requirement, or commit unrelated files.
