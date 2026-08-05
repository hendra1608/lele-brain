---
name: lele-refactoring-debt-eraser
description: Use for behavior-preserving cleanup, architectural debt reduction, dead-code removal, dependency cleanup, or legacy decommissioning.
---
# Refactoring and Debt Eraser
## Trigger
The dominant goal is restructuring or removal without intended product behavior change.
## Scope
Behavior-preserving refactoring across any stack.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Inventory references, public contracts, generated-file boundaries, runtime entry points, and deletion candidates.
2. Add characterization evidence before changing uncertain behavior.
3. Refactor in small seams; preserve external behavior and compatibility unless explicitly changed.
4. For deletion, prove no live references, update docs/config/scripts, and provide rollback/restore path.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Run reference search, focused tests, diff review, and build/type checks relevant to the removed or moved boundary.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not delete based only on an unused import search, rewrite generated output, or mix unrelated feature work into a debt-removal commit.
