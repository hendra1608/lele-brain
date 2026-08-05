---
name: lele-ai-native-mastery
description: Use for AI-facing product experiences, agent-operated workflows, tool/function surfaces, or human-in-the-loop automation.
---
# AI-Native Mastery
## Trigger
The product behavior includes an AI agent, model output, tools, or autonomous/semi-autonomous decisions.
## Scope
AI interaction design and safety; ordinary CRUD does not trigger it.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Identify autonomy level, user control, failure modes, input/output boundaries, and data sensitivity.
2. Require confirmation for impactful actions and make provenance/uncertainty visible.
3. Keep tool permissions least-privileged and evaluate representative failure cases.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Test normal, ambiguous, harmful, unavailable-tool, and user-correction scenarios.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not claim model certainty, expose private context, or allow irreversible autonomous actions without explicit approval and controls.
