---
name: lele-performance-optimizer
description: Use for measured frontend/backend performance regressions, slow interactions, excessive requests, or resource bottlenecks.
---
# Performance Optimizer
## Trigger
There is user-reported or measured latency, rendering, query, or resource evidence.
## Scope
Measure before optimizing; frontend and backend performance are both in scope.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Establish a baseline and identify the slow path.
2. Trace render, network, cache, server, and database contributors.
3. Apply the smallest evidence-backed remediation and compare before/after.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Record baseline, focused measurement, regression check, and remaining bottleneck.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not add memoization, dynamic import, CDN/edge infrastructure, or cache layers without measured evidence.
