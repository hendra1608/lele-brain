---
scope: global
status: active
last-verified: 2026-08-05
---
# Lele Skill Registry
| Intent / evidence | Primary skill | Add only when distinct risk exists | Do not select when |
|---|---|---|---|
| Multi-layer feature, architecture decision, or cross-repo change | `$lele-strategic-planner` | contract, database, security, release gate | a focused one-file fix has no architecture decision |
| OpenAPI, Swagger, DTO, payload/response, generated client, GraphQL, gRPC | `$lele-contract-first-api-integration` | verification release gate | no external contract boundary exists |
| Schema, Prisma, SQL migration, seed, backfill, index, relation | `$lele-database-schema-migration` | security, release gate | only a query/UI change is requested |
| Completion claim, commit, PR, deployment, broad refactor | `$lele-verification-release-gate` | dominant-risk skill | exploratory discussion only |
| Auth, RBAC, 401/403, session, permission menu | `$lele-fullstack-auth-debugger` | security protocol | a generic endpoint failure has no auth signal |
| Threat model, secrets, tenant scope, sensitive data | `$lele-security-protocol` | auth debugger for an incident | ordinary styling work |
| Server cache, query invalidation, global/local state | `$lele-state-mastery` | contract skill for API changes | no state/data-flow behavior changes |
| Behavior-preserving cleanup, delete legacy, dependency removal | `$lele-refactoring-debt-eraser` | release gate | a new feature is the dominant task |
| Performance regression or measured latency | `$lele-performance-optimizer` | cloud-edge only with infrastructure evidence | no performance evidence exists |
| Operational/high-visibility UI | `$lele-ui-premium-vault` | state/accessibility review as applicable | a backend-only task |
| Deployment/edge/runtime latency with measured evidence | `$lele-cloud-edge-orchestra` | performance optimizer | generic frontend work |
| AI-facing product/tool workflow | `$lele-ai-native-mastery` | security protocol for impactful actions | ordinary CRUD without AI interaction |
| Wiki, reusable documentation, knowledge distillation | `$lele-librarian-compiler` | strategic planner for architecture decision | transient task notes only |

Select one primary skill by dominant risk. `$lele` is the dispatcher; child skills are explicitly callable with the `$lele-*` name shown above and are also available for implicit routing. The orchestrator loads only the primary skill and justified companions; it never activates every skill by default.
