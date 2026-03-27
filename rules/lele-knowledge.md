# 🧠 LELE'S GLOBAL KNOWLEDGE (GIGA-BRAIN EDITION)

## General Coding Standards
- **Strict Typing**: No `any` allowed. Use detailed TypeScript interfaces/types for every data structure.
- **Modular Components**: Atomic decomposition of the UI is mandatory. Keep components small, focused, and reusable.
- **Error Handling**: Centralized logic utilizing the `UniversalUseCase` pattern for consistent behavior across modules.

## Universal Solutions & Patterns
- **Anti-Spam Search & Stable Fetch**: Use `debouncedValue` for search inputs. Separate reset and fetch logic. Always reset the page count when a search query changes.
- **State Management Matrix**:
    - **Redux (Persisted)**: Reserved for global sessions, authentication, and cross-module shared settings (e.g., `companySlice`).
    - **Zustand**: Preferred for ephemeral UI states like sidebar toggles, modal visibility, and local UI flags.
    - **TanStack Query (v5)**: The mandatory standard for ALL server-side data fetching, caching, and mutations.
- **Error Resilience Protocols**:
    - **Circuit Breaker**: Halt requests if an external API fails repeatedly to prevent system-wide degradation.
    - **Exponential Backoff**: Implement increasing wait times (1s, 2s, 4s, 8s) for retries to avoid overloading the server.
    - **Graceful Degradation**: If a non-critical feature (e.g., user avatars) fails, display a placeholder instead of crashing the entire page.
- **Accessibility (a11y) as a Premium Standard**:
    - **ARIA Roles**: Mandatory use of screen-reader-friendly labels and roles.
    - **Keyboard Navigation**: Any premium UI must be 100% navigable via `Tab` and `Enter`.
    - **Contrast Ratios**: Strictly follow WCAG AA standards (minimum 4.5:1) for professional legibility.

## Design Tokens (Visual Excellence)
- **Glassmorphism**: `backdrop-filter: blur(8px); background: rgba(255, 255, 255, 0.7); border: 1px solid rgba(255, 255, 255, 0.3);`
- **Premium Shadows**: Layered soft shadows for depth (`0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)`).
- **Harmonious HSL**: Prioritize HSL for granular color control (e.g., `hsl(var(--primary) / 0.9)`).

## SLP Project-Specific Context

### Role-Based Access Architecture
- **3-Layer Role Validation**: 
    1. **FE Page Guard**: Checks `localStorage("roles")` for `ModuleName@rule` (e.g., `InventoryMovements@index`).
    2. **FE API Call**: Generates an encrypted rule header using the `roleAPI` configuration.
    3. **BE Controller**: Uses `@Role` decorator + `validateTokenRoleApi` to verify against the `groups.role_permissions` JSON in the database.
- **Root Cause Pattern**: A 401 "role is not valid" error often indicates a mismatch in the **BE `@Role` decorator** or missing **data configuration in the DB**, rather than a code bug.
- **Diagnosis Shortcut**: Compare working vs. broken endpoints. Verify if the `@Role` decorator exists and if the module name is assigned to the user's group.

### DynamicSelect `initialData` Pattern
- **UUID Flicker Fix**: If a `DynamicSelect` component displays a UUID instead of a name, pass `initialData={{ id: uuid, name: label }}` from the nested response object.
- **Fallback Chain**: `name: record.relation?.field_name ?? record.foreign_key_id`. Fallback to the UUID if the relation object is null to enable auto-fetching by ID.

### Cross-Tab State Pollution (Data Bleed)
- **The Problem**: Multiple components using `HandleFindData` within a `<Tabs>` layout can mutate the global `unionSlice.list` simultaneously, leading to mixed data.
- **The Fix**: Override the default reduder in `HandleFindData`. Use the `onSuccess` callback to store data and meta locally in `useState` instead of the global slice.
- **Pro-Tip**: Always prefer local state (`useState`) for API results within Modals or Tabs to prevent global state pollution.

### Multi-Level Approval Workflow
- **Issue**: Transactions prematurely switching to "Approved" (2) due to loose level checks.
- **Fix**: Count the remaining pending details (`status_approve === null`).
- **Condition**: Only send status `2` if `waitingDetails.length === 1` and the current level is the final stage of the workflow.

### Self-Sufficient Approval Actions
- **ModuleEnum Naming**: Must match the **Exact Case** and **Plurality** of the Prisma model name on the backend (e.g., `Adjustments`, `Scraps`).
- **Sequential Priority**: Prioritize `minWaitingLevel`. If a user occupies multiple levels, allow them to approve sequentially without rigid `alreadyApproved` blocks if those blocks prevent logical flow.

### Requisition Optional Source Pattern
- **Logic**: When a transaction can be standalone or linked (e.g., Requisition without WO), use a `sourceType` of `"none"` or `"Request"`.
- **Payload Discipline**: Bos's rule: do not send `source_trn` at all in the payload if no source is selected. Omit the key rather than sending `null` to avoid backend validation friction.
- **Manual Dependency**: If source selection usually provides a `city_id`, ensure a manual `DynamicSelect` for City is presented in `"none"` mode to maintain the cascading Site filtering.

### Enum Validation (BE vs FE)
- **Lesson**: Kalo mau nge-update status di frontend, jangan cuma main tebak string (contoh: "close"). Harus selalu ngecek exact Enum di Backend (kayak `jo_closed` di DTO Prisma) biar nggak kena 400 Validation Error.

### Local NestJS Endpoint Sync (Swagger Ghosting)
- **Symptom**: Endpoint baru (kayak `@Patch`) udah narik via `git pull` dari branch BE, tapi kok ga nongol di *Swagger Local* dan kena 404/401 di FE FE.
- **Fix**: HMR NestJS (`start:dev`) suka nyangkut kalau ada controller route baru ditambahin by Git mergin/pulling. Matikan proses `start:dev`, bersihin `dist` atau `yarn build`, trus jalankan ulang. Otomatis endpoints langsung *fresh* ter-load di Swagger.

## Antigravity System Evolution (v2026.03.10+)
- **AGENTS.md Implementation**: Use `AGENTS.md` at the workspace root for global project rule enforcement. This avoids committing rules to project-specific repositories while maintaining strict standards.
- **Auto-continue Protocol**: Long-running tasks now utilize default auto-continue for smoother execution cycles.
- **Token Optimization**: Fixed premature token limit accounting; long-running sessions are now stable.
- **Tooling Patches**: Legacy `Command` support has been removed in favor of more specialized tools.

## Working Principles (Lele's Laws)
1. **Investigate Before Coding**: Trace the full flow (FE -> API -> BE) before touching code, especially for access issues.
2. **Surgical Precision**: Verify `TargetPath` always. Never leak internal documentation into project source code.
3. **Atomic Commit Strategy**: Keep Git operations granular. Use descriptive multi-line commit messages.
4. **Proactive Documentation**: UPDATE THIS FILE IMMEDIATELY after every successful `git commit`. Being reminded by the "Bos" is a personal failure. **STRICT ENFORCEMENT**.

---
*Last Updated: 2026-03-10 - Translated to English, Integrated AGENTS.md Workspace Pattern.*
