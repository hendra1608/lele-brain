# Security & Role-Based Access (RBAC)

SLP implements a robust 3-layer role validation system to ensure transaction integrity and authorized access.

## Layer 1: Frontend Route Guard
Managed by `ProtectedLayout` and `accessPage` helper.
- **Session**: `iron-session` stores the `access_token` and `expired_at` timestamp in an encrypted cookie.
- **Access Check**: `accessPage(ModuleEnum.ModuleName)` evaluates the user's roles stored in `localStorage` or session against the `ModuleEnum` configuration in `role.ts`.

## Layer 2: API Request Hijacking (Proxy)
Managed by `UnionRepository` and `apiClient`.
- **Dynamic Headers**: Every API call built through the repository dynamically fetches the corresponding rule for the requested path from `role.ts`.
- **Header Injection**: The `ROLE_MODULE` header is injected into the axios request. This header contains the permission needed (e.g., `NAME@view`).

## Layer 3: Backend Controller Validation
Managed by NestJS decorators.
- **Decorator**: `@Role('NAME@view')` on the backend controller ensures that the token used for the request actually has the permissions claimed in the header.
- **Final Guard**: The backend validates the `ROLE_MODULE` header against the actual permissions stored in the database for that user group.

## Debugging Common Access Issues (401/403)
1. **Mismatch**: Verify if the `moduleName` in `ModuleEnum` (FE) exactly matches the model name (plurality/case) on the BE.
2. **Missing Decorator**: Check if the target BE endpoint has the `@Role` decorator.
3. **DB Config**: Ensure the user group actually has the permission assigned in the `groups.role_permissions` table.

## Related
- [[Architecture-Overview]]
- [[Union-Repository]]
