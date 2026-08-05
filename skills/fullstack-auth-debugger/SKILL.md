---
name: lele-fullstack-auth-debugger
description: Use for authentication, authorization, RBAC, 401/403, session, cookie, permission, and protected-navigation incidents.
---
# Fullstack Auth Debugger
## Trigger
A user cannot authenticate, access a route/action, or receives an authorization failure.
## Scope
Universal four-layer diagnosis with discovered stack adapters. SLP legacy behavior is available only when the active project is explicitly SLP legacy.
## Required Context
Read applicable AGENTS.md, project wiki, repository conventions, and only the source files needed to establish current behavior.
## Inputs
The user goal, affected repositories/modules, constraints, and available validation commands.
## Workflow
1. Discover the active auth transport and trust boundaries before assuming headers, local storage, cookies, or decorators.
2. Trace presentation access behavior, request construction, server authentication/authorization guard, and permission persistence/configuration.
3. Compare a working and failing flow; verify exact action/resource/tenant identity.
4. For BFF/session-cookie designs, verify HttpOnly/Secure/SameSite/CSRF applicability and ensure browser state is presentation-only.
5. For explicitly active SLP legacy work, consult its scoped role documentation and label that adapter legacy.
## Outputs
State the decision, evidence, changes, validation results, and unresolved risks. Do not claim completion without evidence.
## Validation
Use a non-privileged user scenario, server guard evidence, and a focused route/API smoke test when safe.
## Stop Conditions
Stop and ask for clarification when a required contract, security decision, production-data policy, or destructive action is ambiguous. Do not expand scope merely because a related pattern exists.
## Safety Boundaries
Do not move reusable tokens or authorization material into browser-readable storage, bypass server authorization, or expose credentials in diagnostics.
