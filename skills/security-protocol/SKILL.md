---
name: lele-security-protocol
description: Use for threat modeling, secrets, auth/session design, RBAC, PII, tenant isolation, file upload, external input, or security-sensitive changes.
---
# Security Protocol
## Trigger
The task handles a trust boundary, confidential data, authorization, or externally controlled input.
## Scope
Preventive, framework-neutral security review.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Identify assets, actors, trust boundaries, entry points, and irreversible actions.
2. Check authentication, authorization/IDOR/tenant scope, input handling, secret handling, logging, CSRF applicability, and dependency/supply-chain exposure.
3. Recommend the smallest control compatible with the existing stack; add libraries only when evidence justifies them.
4. Record residual risk and tests that cannot be executed locally.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Run relevant static checks, secret scan, authorization tests, and focused abuse-case review.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not mandate Zod, a specific use-case layer, CSRF middleware, or other dependency without stack evidence. Never place secrets in source, docs, logs, or generated fixtures.
