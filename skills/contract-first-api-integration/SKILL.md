---
name: lele-contract-first-api-integration
description: Use for OpenAPI, Swagger, DTO, generated clients, API payload/response changes, operation identifiers, GraphQL, or gRPC contracts.
---
# Contract-First API Integration
## Trigger
The task changes or diagnoses an API boundary, generated type, endpoint, request, response, or codegen workflow.
## Scope
Framework-neutral contract governance. Supports REST/OpenAPI, GraphQL, and gRPC without requiring a particular generator.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Discover the authoritative contract, generator configuration, generated-output policy, and consumer wrappers.
2. Trace producer to consumer: schema/model -> transport contract -> generated artifacts -> client operation -> UI/service use.
3. Preserve stable operation identity and compatibility unless the user explicitly approves a breaking version.
4. Generate artifacts through the repository command; never hand-edit generated output.
5. Use generated transport request/response types. Introduce manual types only for genuinely different domain or view models.
6. Verify cache/query identity and invalidation derive from the operation contract where the client architecture supports it.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Run generator, stale-artifact/contract check, typecheck, and focused producer/consumer tests. Report any runtime contract check not performed.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not infer undocumented payload fields, silently coerce unknown API data, or replace a project client architecture without approval.
