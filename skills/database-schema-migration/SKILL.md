---
name: lele-database-schema-migration
description: Use for Prisma/schema/SQL migrations, seeds, backfills, indexes, relations, constraints, and production-data changes.
---
# Database Schema Migration
## Trigger
The task changes persisted schema or data behavior.
## Scope
Framework-neutral database change safety; detect the repository ORM and migration convention first.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Inventory affected tables/models, reads/writes, constraints, indexes, generated clients, and API contracts.
2. Classify compatibility: additive, expand/contract, destructive, data rewrite, or access-scope change.
3. Define ordered migration, backfill, verification query, rollback/containment, and deployment sequencing before editing.
4. Keep migration logic deterministic and scoped; never run production mutation without explicit approval.
5. Regenerate ORM artifacts and validate consuming contracts after schema changes.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Run schema validation, migration dry-run or isolated database test when available, generated-client checks, focused integration tests, and rollback review.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Never assume empty production data, perform destructive migration, fabricate rollback, or expose tenant/PII data in logs or fixtures.
