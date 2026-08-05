---
name: lele-cloud-edge-orchestra
description: Use for deployment, CDN, edge, runtime, regional latency, or caching topology decisions backed by measured infrastructure evidence.
---
# Cloud Edge Orchestra
## Trigger
Measured delivery/runtime infrastructure is the dominant bottleneck.
## Scope
Infrastructure remediation after application-level evidence; provider-neutral.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Establish latency/error/cache baseline and deployment constraints.
2. Identify whether edge/CDN/runtime placement solves the observed bottleneck.
3. Plan observability, rollback, cache invalidation, and cost/security impact.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Verify configuration in a non-production environment and compare measured metrics.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not prescribe a cloud provider, edge runtime, or CDN merely because a project uses Next.js.
