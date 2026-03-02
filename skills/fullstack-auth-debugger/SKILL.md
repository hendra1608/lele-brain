---
name: Fullstack Auth Debugger
description: Universal methodology for debugging authentication & authorization (RBAC) flows across any fullstack stack (Next.js, NestJS, Express, etc.)
---

# 🔐 Fullstack Auth Debugger

## Purpose
Systematic approach to diagnose and fix 401/403 errors in fullstack applications with Role-Based Access Control (RBAC).

## The 4-Layer Trace Method

When a user reports "can't access page" or API returns 401/403, trace through these layers **in order**:

### Layer 1: Frontend Page Guard
**What to check**: Does the page even render before making API calls?
- Look for `accessPage()`, `useAuth()`, or similar guards in the page component.
- Check if the module name matches what's stored in the user's session/localStorage.
- **Common bug**: Module name mismatch (singular vs plural, typo, wrong enum value).

```
Symptom: Page shows "Not Found" or blank — never makes API call.
Fix: Correct the module name in the page guard to match stored roles.
```

### Layer 2: Frontend API Layer (Request Construction)
**What to check**: How does the FE construct the API request with auth headers?
- Trace `findRoleModule(moduleName, pathKey)` → does it find a match in the role config?
- Check if `getRolePermission()` generates a valid encrypted rule.
- Verify `parentPath` + `pathKey` constructs the correct URL.
- **Common bug**: `pathKey` not registered in the role config array.

```
Symptom: API call goes out but with empty/null permission header.
Fix: Add the pathKey entry to the module's role config.
```

### Layer 3: Backend Controller Guard
**What to check**: What role does the BE expect for this endpoint?
- Find the `@Role` decorator (or equivalent guard) on the controller method.
- Note the **exact model name** and **permission** (e.g., `Adjustments@index`).
- Compare with endpoints that DO work — do they have the same decorator pattern?
- **Common bug**: Decorator uses a different model name than what user's group has.

```
Symptom: API returns 401 "role is not valid".
Fix: Either add the role to user's group in DB, or adjust the decorator.
```

### Layer 4: Database Role Configuration
**What to check**: Does the user's group actually have the required permission?
- Query the group/role table for the user's group ID.
- Check if `role_permissions` JSON (or equivalent) contains `ModelName@rule`.
- For superadmin: permissions are auto-generated from `permissions` table.
- For regular users: permissions come from `role_permissions` field in `groups` table.
- **Common bug**: New module added to code but never seeded/configured in DB.

```
Symptom: Everything in code is correct, but still 401.
Fix: Add the permission entry to the user's group in the database.
```

## Diagnosis Shortcuts

### Compare Working vs Broken
The fastest debug method: find a **similar endpoint that works** and diff everything:
- Controller decorator
- Role config entry
- DB permissions
- FE module name

### The Plural/Singular Trap
Backend ORMs (Prisma, TypeORM) often pluralize model names. Always verify:
- `Prisma.ModelName.Adjustments` (plural) vs frontend `ModuleEnum = "Adjustment"` (singular)
- Check the **exact** string, not what you think it should be.

### Superadmin Bypass Check
If superadmin works but regular user doesn't → 100% a DB permissions issue, not code.

## Prevention Checklist

When adding a new module:
- [ ] Add model to DB schema / migration
- [ ] Add `ModuleEnum` entry (match exact model name)
- [ ] Add `roleAPI` entries (both page paths and API paths)
- [ ] Seed permissions in DB for all relevant groups
- [ ] Add `@Role` decorator on BE controller (or skip if inheriting from parent)
- [ ] Verify by logging in as a non-superadmin user

## Stack-Specific Notes

### NestJS + Prisma
- `@Role` decorator sets metadata, guard reads it via `Reflector`
- `Prisma.ModelName.X` is the canonical source of truth for model names
- `validateTokenRoleApi` reads route metadata and compares with `findRoleGroup` result

### Next.js (App Router)
- Middleware (`middleware.ts`) handles route-level auth (session check)
- Page-level guards use client-side `accessPage()` from localStorage
- API calls attach encrypted role permission in request headers
