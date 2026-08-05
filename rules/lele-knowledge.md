# ðŸ§  LELE'S GLOBAL KNOWLEDGE (GIGA-BRAIN EDITION)

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

### Numeric Discount Payload Pattern (FE -> BE)
- **Problem**: Selecting a config option (e.g., Discount) often returns a string or an ID, but the backend requires the actual percentage value (numeric).
- **Solution**:
    1.  Use `fieldMapping={{ label: "value", value: "value" }}` in `DynamicSelect` to pick the numeric value from the config.
    2.  Explicitly cast to `Number(values.discount)` in the submission/modal handler (`onOk`) to ensure the payload is typed as a number.
    3.  Always provide a fallback (e.g., `discount: item.discount || 0`) in the final payload mapping to avoid `null`/`undefined` friction.

---
*Last Updated: 2026-03-30 - Added Numeric Discount & Draft vs Submit Patterns.*

### Draft vs Submit Action Pattern (Transaction Consistency)
- **Problem**: Users want to save progress without triggering approval workflows prematurely.
- **Solution**:
    1.  **Backend Pattern**: Use `status_approve: 0` for Draft and `status_approve: 1` for Waiting Approval.
    2.  **Frontend Logic**: Pass a `status` parameter to the submit handler (e.g., `handleSubmit(status: number)`).
    3.  **UI Styling**:
        - **Draft**: Use a standard button with secondary visual weight (minWidth 150px, rounded).
        - **Submit**: Use `type="primary"`, brand color (e.g., `#FDB913`), and bold text with a subtle shadow (minWidth 200px, rounded).
    4.  **User Feedback**: Differentiate success messages based on the status (e.g., "Saved as Draft" vs "Submitted for Approval").

### Agreement Module Refactor Patterns (2026-03-31)
- **Survey Template Level**: `survey_id` for Agreement header is a separate concern from per-vehicle survey templates. Header-level `survey_id` is appended to `FormData` on submit.
- **Tax `initialData` Dual Mapping**: API responses can return tax data under either `TaxVats` or `Taxes` nested keys depending on the query. Always resolve with `header.TaxVats || header.Taxes`.
- **Customer Label on Disabled Select**: When a `DynamicSelect` is `disabled` (e.g., auto-populated from a Quotation), always pass `initialData` so the label renders immediately without a UUID flash.
- **`customRender` for Multi-Field Labels**: Use `customRender` to combine multiple fields into one readable dropdown option (e.g., `${item.survey_code} - ${item.template_name}`).
- **DynamicSelect `fieldMapping` Fallback**: `fieldMapping.label` only affects internal search & value resolution. `customRender` overrides what the user *sees* in the dropdown list.

---
# ðŸ§  LELE'S GLOBAL KNOWLEDGE (GIGA-BRAIN EDITION)

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

## Antigravity System Evolution (v2026.04.15 - v4.0 Elite)
- **Giga-Brain v4.0 Upgrade**: Officially synchronized with the "Bos".
- **Jasper Global Hook**: Centralized `useJasper` hook implementation to unify all reporting modules.
- **DNA Evolution**: Added "Elite Protocol" for zero-friction development and total architectural enforcement.
- **AGENTS.md Implementation**: Use `AGENTS.md` at the workspace root for global project rule enforcement. This avoids committing rules to project-specific repositories while maintaining strict standards.
- **Auto-continue Protocol**: Long-running tasks now utilize default auto-continue for smoother execution cycles.
- **Token Optimization**: Fixed premature token limit accounting; long-running sessions are now stable.
- **Tooling Patches**: Legacy `Command` support has been removed in favor of more specialized tools.

## Working Principles (Lele's Laws)
1. **Investigate Before Coding**: Trace the full flow (FE -> API -> BE) before touching code, especially for access issues.
2. **Surgical Precision**: Verify `TargetPath` always. Never leak internal documentation into project source code.
3. **Atomic Commit Strategy**: Keep Git operations granular. Use descriptive multi-line commit messages.
4. **Proactive Documentation**: UPDATE THIS FILE IMMEDIATELY after every successful `git commit`. Being reminded by the "Bos" is a personal failure. **STRICT ENFORCEMENT**.

### Numeric Discount Payload Pattern (FE -> BE)
- **Problem**: Selecting a config option (e.g., Discount) often returns a string or an ID, but the backend requires the actual percentage value (numeric).
- **Solution**:
    1.  Use `fieldMapping={{ label: "value", value: "value" }}` in `DynamicSelect` to pick the numeric value from the config.
    2.  Explicitly cast to `Number(values.discount)` in the submission/modal handler (`onOk`) to ensure the payload is typed as a number.
    3.  Always provide a fallback (e.g., `discount: item.discount || 0`) in the final payload mapping to avoid `null`/`undefined` friction.

---
*Last Updated: 2026-04-17 - Version 4.0 (Architectural Governance & Agentic Protocols)*

### The Lele Brain v4 (v2026.04.17)
- **Architectural Governance**: Every module must follow the nested `(pages)` pattern with `_components`, `_hooks`, and `_types`.
- **Security Mapping**: Formalization of the 3-layer RBAC (FE -> Header -> BE).
- **Agentic Reliability**: Mandatory "Brain-First" and "PKS" (Proactive Knowledge Synchronization) protocols to prevent AI drift.
- **Token Efficiency**: Strategies for granular reading and wiki-based context compression.

### Draft vs Submit Action Pattern (Transaction Consistency)
- **Problem**: Users want to save progress without triggering approval workflows prematurely.
- **Solution**:
    1.  **Backend Pattern**: Use `status_approve: 0` for Draft and `status_approve: 1` for Waiting Approval.
    2.  **Frontend Logic**: Pass a `status` parameter to the submit handler (e.g., `handleSubmit(status: number)`).
    3.  **UI Styling**:
        - **Draft**: Use a standard button with secondary visual weight (minWidth 150px, rounded).
        - **Submit**: Use `type="primary"`, brand color (e.g., `#FDB913`), and bold text with a subtle shadow (minWidth 200px, rounded).
    4.  **User Feedback**: Differentiate success messages based on the status (e.g., "Saved as Draft" vs "Submitted for Approval").

### Agreement Module Refactor Patterns (2026-03-31)
- **Survey Template Level**: `survey_id` for Agreement header is a separate concern from per-vehicle survey templates. Header-level `survey_id` is appended to `FormData` on submit.
- **Tax `initialData` Dual Mapping**: API responses can return tax data under either `TaxVats` or `Taxes` nested keys depending on the query. Always resolve with `header.TaxVats || header.Taxes`.
- **Customer Label on Disabled Select**: When a `DynamicSelect` is `disabled` (e.g., auto-populated from a Quotation), always pass `initialData` so the label renders immediately without a UUID flash.
- **`customRender` for Multi-Field Labels**: Use `customRender` to combine multiple fields into one readable dropdown option (e.g., `${item.survey_code} - ${item.template_name}`).
- **DynamicSelect `fieldMapping` Fallback**: `fieldMapping.label` only affects internal search & value resolution. `customRender` overrides what the user *sees* in the dropdown list.

---
*Last Updated: 2026-04-01 - Added Agreement Module Refactor Patterns.*

### Nested Relation Mapping for Job Order Display
- **Problem**: Key fields like `police_no` can "disappear" in UI views if they are deeply nested in transaction source relations (e.g., `Quotations.Inquiries.Vehicles` or `Agreements.Vehicles`) and not explicitly mapped into frontend state.
- **Solution**: Always track the exact JSON response structure from the backend. Explicitly extract and map deeply nested relations into a flat, predictable UI state (like `sourceInfo`) when fetching details. Make sure conditionals correctly account for structural differences between source document types (like Quotations vs Agreements).

---
*Last Updated: 2026-04-06 - Added Nested Relation Mapping for Job Order.*

### React Re-mounts on Inner Component Declarations
- **Problem**: Declaring a component (e.g. `const MobileView = () => ...`) inside a parent component's render function causes the inner component to unmount and remount dynamically every time the parent re-renders. This destroys the inner component's state, such as input focus in a search box.
- **Solution**: Refactor these inner components into standard render functions (e.g. `const renderMobileView = () => ...`) or extract them outside the parent component entirely to ensure element stability across re-renders.

---
*Last Updated: 2026-04-06 - Added React Re-mount rule for Search Focus issues.*

### DTO Payload Synchronization (FE vs BE)
- **Problem**: Data submitted from the frontend is successfully sent but silently dropped or missing in the backend database (and consequently empty on read). This typically happens when the FE sends a payload key that differs from the exact property name defined in the BE's Swagger/Joi DTOs (e.g., sending `tarif_unit_rate` when the BE expects `unit_rate`).
- **Solution**: Always audit the exact properties expected by the Backend controller/service when adding or modifying fields. Do not invent arbitrary field names on the frontend. If the database uses `unit_rate`, the frontend's inner API state mapping and components should be tightly coupled to match it exactly.

---
*Last Updated: 2026-04-06 - Added DTO Payload Synchronization.*

### UoM Fallback and Fetch for Dynamic Pricing
- **Lesson**: When manually adding items (e.g. Spare Parts) in Edit mode that rely on a dynamic pricing API (`getPriceStock`), the selected `DynamicSelect` object might not have complete nested relations like UoM.
- **Fix**: Always prioritize `direct uom_id > GroupSpareParts.uom_id > UnitOfMeasurements.id`. If a direct UoM object is still missing, trigger a manual `UniversalUseCase.HandleOptionData` fetch to populate `UnitOfMeasurements` before pushing to the table array.

---
*Last Updated: 2026-04-13 - Added UoM Fallback and Fetch strategy.*

### Flexible Quantity Override on Document Creation
- **Lesson**: When pulling item details from a source document (like Quotation to Job Order), fields like `Qty` should remain editable (`disabled={false}`) during the "Create" flow to accommodate real-world manual overrides.
- **Fix**: Remove rigid `disabled={isSourceDocument}` bindings on specific columns (like `qty`) if the workflow inherently demands flexibility at the point of creation.

---
*Last Updated: 2026-04-13 - Added Flexible Quantity Override.*

### Feature Flagging & Action Restoration
- **Lesson**: When restoring a previously commented-out feature like `Delete`, ensure the underlying state and modal integration (such as `ModalDelete`) are intact before exposing the UI to users, to avoid dead buttons.
- **Fix**: Re-link `onClick` handlers precisely to existing action functions rather than re-inventing the delete cycle.

---
*Last Updated: 2026-04-13 - Added Feature Flagging & Action Restoration.*

### Synchronized Payload Mapping (Source to Target)
- **Problem**: In modules where we create a target document from a source (e.g., Advance to Settlement), mapping logic often differs between "Create" (via `onSelect`) and "Edit" (loading from DB). This leads to inconsistent UI states like missing names or unchangeable items.
- **Solution**: 
    1.  **Unified Mapping**: Create a shared mapping helper or strictly synchronize the logic between the `onSelect` handler and the `fetchDetail` function. 
    2.  **Type-Aware Mapping**: If the source uses a generic `item_id` and a `type` field, map it immediately to the target's specific ID fields (e.g., `spare_part_id`) for better component initialization.
    3.  **Flexible Redundancy**: Remove redundant generic fields (like `item_id`) from the final submit payload if the backend uses specific property-based IDs.
    4.  **Implicit Validation**: Add a final check before submission to ensure all detail rows have the minimum required IDs to prevent database corruption.

---
*Last Updated: 2026-04-15 - Added Synchronized Payload Mapping.*

### FE-Only Fallback Image vs Backend Persistence
- **Lesson**: Default image di frontend harus dibedakan antara display fallback dan data yang benar-benar dipersist ke backend. Jika backend multipart hanya membaca `file` dari interceptor dan mengabaikan `body.image`, FE tidak bisa memaksa persist URL default tanpa perubahan kontrak backend.
- **Fix**: Centralize fallback di helper frontend (contoh: `getSparePartImageSrc` dan `setSparePartImageFallback`) supaya semua list/detail/modal konsisten. Jangan upload ulang gambar default dari FE. Jika bisnis butuh default tersimpan di DB, update DTO/service backend agar menerima URL atau set default di backend storage/service layer.

---
*Last Updated: 2026-06-02 - Added FE-only fallback image vs backend persistence pattern.*

### FE Auth Token Precheck Is Defense-In-Depth
- **Lesson**: Frontend token validation can prevent corrupted browser sessions from hitting the backend, but it is not a final security boundary. Compare decoded JWT identity fields with current FE auth state and key-token cookies before sending requests, then clear the client session on mismatch.
- **Fix**: Centralize the check in a shared request helper and call it from axios interceptors, RBAC permission generation, TanStack request hooks, and direct upload/fetch paths. Still require backend session validation, revocation, and HttpOnly/BFF hardening for stolen bearer-token scenarios.

---
*Last Updated: 2026-06-03 - Added FE auth token precheck defense-in-depth pattern.*

### Redux-Only State And Auth Mismatch Logout
- **Lesson**: In SLP FE, keep Redux Toolkit as the single global state layer and avoid generic API response data in global stores when the data is modal/table scoped. If auth token/cookie precheck detects a mismatch, the FE should invalidate the client session and redirect to login, not only show an error.
- **Fix**: Remove unused state libraries only after all imports/providers are gone, keep transient CRUD table/detail data local, and centralize auth mismatch handling in the shared access-token guard so axios, RBAC, uploads, and direct fetch paths fail closed consistently.

---
*Last Updated: 2026-06-04 - Added Redux-only state and auth mismatch logout pattern.*

### Client API Gateway Endpoint Masking
- **Lesson**: For SLP FE endpoint masking, route browser-facing backend calls through a single Next.js API route such as `/api/gateway`. Put the backend target and method in encrypted headers, keep JSON payloads limited to params/body, and let multipart requests send only form data plus encrypted gateway metadata.
- **Fix**: Centralize gateway header creation in a shared client helper and route axios interceptors, direct fetch helpers, auth utility calls, and upload flows through it. Treat this as Network-tab obfuscation only; backend RBAC and token validation remain the real security boundary.

---
*Last Updated: 2026-06-04 - Added client API gateway endpoint masking pattern.*

### No-DB MVP With DB-Ready Boundary
- **Lesson**: For early personal-product validation, a Next.js + NestJS app can ship faster without a database if generated outputs are kept in UI/localStorage and all provider secrets remain backend-only.
- **Fix**: Keep clean service/provider boundaries and shared DTOs from day one so SaaS features like auth, PostgreSQL/Prisma persistence, usage quotas, and audit logs can be added later without rewriting the generator flow.

---
*Last Updated: 2026-06-05 - Added no-DB MVP with DB-ready boundary pattern.*

### Local Agent/Wiki Artifact Hygiene (2026-06-25)
- Lesson: Repo-local AGENTS/wiki files used for LLM orchestration should stay out of product commits unless explicitly intended as durable project docs.
- Fix: Keep local agent/wiki artifacts ignored so security/auth changes do not accidentally include operational instructions or local-only knowledge.


### SLP Browser Crypto Boundary (2026-06-25)
- Lesson: Client-side AES with a bundled passphrase fails pentest even on VPN because the browser must be treated as public.
- Fix: Keep backend-compatible AES in Next.js server-only code using CRYPTO_SECRET, and use browser-to-BFF public-key hybrid transport for sensitive payloads.


### Digest-Bound Auth Bootstrap For Large Menus (2026-06-25)
- Lesson: Storing decrypted or huge roles/list_menu in iron-session cookies can exceed browser cookie limits or leak too much auth state.
- Fix: Store only token plus SHA-256 digests in HttpOnly session, keep encrypted browser blobs, and bootstrap sanitized permissions through an authenticated BFF endpoint bound to those digests.


### BFF-Owned Gateway Crypto And Tokens (2026-06-25)
- Lesson: Browser cookies should not hold bearer tokens, refresh tokens, or reusable ROLE_MODULE material after moving SLP auth behind a Next.js BFF.
- Fix: Browser calls /api/gateway with public-key encrypted route/role intent; the BFF injects HttpOnly session tokens and backend-compatible AES ROLE_MODULE server-side.


### Dynamic Route Legacy Disable Risk (2026-06-25)
- Lesson: Do not disable a dynamic route file such as [id]/page.tsx just because one mode (for example create) became legacy; the same file may still serve detail/edit routes.
- Fix: Split mode-specific legacy behavior or guard only the create branch, while keeping detail route rendering intact and build-validated.


### RBAC Index/View Permission Exclusivity (2026-06-25)
- Lesson: In SLP module access UI, index and view can be configured as distinct alternatives and must not be auto-paired by checkbox state unless backend contract explicitly requires it.
- Fix: When selecting index or view, remove the sibling permission before adding the selected one; unchecking should only remove the selected permission.


### RBAC Index/View Independent Selection (2026-06-25)
- Lesson: In SLP module access configuration, index and view permissions must be independently selectable; do not auto-pair or make them mutually exclusive in UI state.
- Fix: Permission checkbox changes should add/remove only the selected permission unless a backend contract explicitly defines dependency behavior.


### Stock Adjustment Header Type Payload (2026-06-26)
- Lesson: Stock Adjustment now requires adj_type at both header and detail level; detail rows must inherit the selected header type to keep DTO payload consistent.
- Fix: Add required header dropdown for ADJ_PLUS/ADJ_MINUS and map the same adj_type into every adjustment_detail item for create/update/close flows.


### DynamicSelect Option Dedupe And Pagination Guard (2026-07-02)
- Lesson: DynamicSelect infinite scroll can loop or show duplicate rows when overlapping fetches or cached pages return repeated option IDs.
- Fix: Guard option fetches with a ref, dedupe by the configured value key, and stop pagination when appended results add no unique options.

### UniversalUseCase Option Loading Boundary (2026-07-02)
- Lesson: Shared option-fetch helpers should not toggle global page content loading because dropdown searches and infinite scroll are local UI concerns.
- Fix: Keep HandleOptionData loading ownership in the caller component and reserve global content loading for page-level data flows.

### Finance List Debounced Search (2026-07-02)
- Lesson: Finance list pages can spam backend fetches when search state is used directly as a fetch dependency.
- Fix: Use the shared useDebounce search value in finance list request payloads and dependencies while keeping pagination and limit changes immediate.

### Master List Debounced Search Consistency (2026-07-02)
- Lesson: Debounced search is only effective when the debounced value is used both in the fetch dependency list and in the actual request payload.
- Fix: For master management lists, wire callbacks and local filters to the debounced search value consistently, including pagination reset where stale page offsets matter.

### Transaction List Debounced Search (2026-07-02)
- Lesson: Transaction and approval lists need debounced search to reduce request spam, but non-search filters like date ranges, status, site, and pagination should remain immediate dependencies.
- Fix: Send debounced search values in transaction list payloads while keeping existing operational filters reactive.

### Admin Utility Debounced Search (2026-07-02)
- Lesson: Utility and numbering administration pages have the same request-spam risk as transaction lists when raw search state is bound to fetch effects.
- Fix: Use shared debounced search values in admin list fetch calls while preserving access guards and pagination dependencies.

### Shared Code Label Wording (2026-07-02)
- Lesson: When several tables/forms refer to code fields, concise generic labels can be committed separately from behavior changes to keep git history readable.
- Fix: Isolate wording-only changes into their own commit instead of mixing them with search or data-fetch behavior commits.

### Smart Tax Calculation Boundary (2026-07-07)
- Lesson: Finance tax calculations must use full tax configuration, not only `tax_rate`; `tax_base_rate` and `ie_flag` control DPP and include/exclude behavior.
- Fix: Centralize transaction tax math in `calculateSmartTax`, keep old `calculateTax` helpers as compatibility wrappers, pass full selected tax option from `DynamicSelect`, and disable cache for AR tax selection so edited master tax data is refetched.

### Stock Adjustment Close Customer Visibility (2026-07-07)
- Lesson: Sending `customer_id` in a close/update payload is not enough when users validate the close context visually; the close screen must also render the customer identifier from the same source.
- Fix: In stock adjustment close forms, display `customer_id` with `Customers.id` fallback and keep it aligned with the payload resolver.

### Scrap Close Endpoint And Status Display (2026-07-07)
- Lesson: Scrap has two independent statuses: `status_approve` for approval and `status` for open vs confirmed/closed. UI must show both and gate close by approved plus open state.
- Fix: Add Close Scrap action from detail data to `PATCH /inventories/close-scrap/{id}`, map `close-scrap` through inventory parent path, and display Scrap Status on detail and index pages.

### Stock Adjustment Count Variance Creation (2026-07-07)
- Lesson: Create Stock Adjustment should derive adjustment quantity and type from stock count variance, not from manual quantity entry or a header-level type choice.
- Fix: Use `qty_soh` as stock on hand, show `stock_count` in add-item/create tables, calculate `qty = abs(stock_count - qty_soh)`, set detail `adj_type` to addition when count is higher and deduction when lower, and keep close/detail pages focused on existing SOH/detail values.

### Stock Adjustment Pagination & Stock Count Pattern (2026-07-07)
- Outstanding-list pagination must resolve backend meta defensively (`total_data`, `totalData`, `total_count`, `total`, or page-derived fallback) because endpoint response shapes can differ; otherwise AntD pagination shows `0-0` while rows exist.
- Stock adjustment create/detail must consistently use `qty_soh` as Stock on Hand and derive Stock Count from header adjustment direction plus adjustment qty when backend detail does not return a direct count field.

### Advance Settlement Attachment Upload Boundary (2026-07-09)
- Lesson: Do not store selected AntD Upload files only in disabled Form fields; form-level disabled can also disable preview actions inside the same form section.
- Fix: Mirror Agreement's `fileList` upload pattern, append `originFileObj` to FormData, hydrate existing attachments into `fileList`, and disable individual input controls instead of disabling the whole form when preview actions must remain clickable.

### Bridging Coda Adjustment Source Options (2026-07-09)
- Lesson: Finance Coda bridging source selectors must include stock adjustment source types separately for addition and deduction when backend finance staging uses `ADJ_PLUS` / `ADJ_MINUS` as source_type.
- Fix: Add explicit Bridging Coda options for Adjustment Addition (`ADJ_PLUS`) and Adjustment Deduction (`ADJ_MINUS`) rather than reusing a generic Adjustment label.

### Inventory Transaction Attachments (2026-07-09)
- Lesson: Inventory transaction create flows (Adjustment, Scrap, Transfer Stock) need multipart FormData when adding file uploads, while detail pages must render preview from backend URL fields.
- Fix: Use AntD `Upload` with `fileList`, validate attachment type/size, append the binary as `file`, stringify detail arrays inside FormData, and resolve preview URLs defensively from `file_upload`, `reference_file`, or `attachment_url`.

### Delivery Detail Route Pattern (2026-07-14)
- The DeliveryItems role configuration already maps pathKey: "detail" with GET and view under parentPath: "delivery-items"; HandleFindDataById therefore calls /delivery-items/detail/{id}. Add the read-only route at delivery/list/[id] and navigate from the DI code without duplicating the role entry.

### Delivery Item Detail Response Mapping (2026-07-14)
- `/delivery-items/detail/{id}` returns a DeliveryItem header with `Requisitions`, `Branches`, `Customers`, and `DeliveryItemDetails`; do not treat it as the requisition-detail endpoint. Render item rows from `DeliveryItemDetails`, show branch/customer names only, and reuse `RequestStatusTag` for user-facing requisition status labels.

### WMS Biome Migration And Windows Hooks (2026-07-31)
- Lesson: On Windows, direct Node invocation of `lint-staged` in Husky avoids Git-Bash non-TTY/signal issues. Biome should replace ESLint/Prettier while preserving framework builds and generated OpenAPI/Prisma exclusions.
- Fix: Keep `yarn lint`, `yarn format:check`, and `yarn build` as separate gates; enable Nest parameter decorators and disable `useImportType` where emitted decorator metadata needs runtime imports.
### WMS Commit Scope Hygiene (2026-07-31)
- Lesson: WMS frontend and backend are independent Git repositories; commit tooling migrations separately and keep unrelated untracked backend work out of the tooling commit.
- Fix: Stage each repository independently, verify staged diffs, and leave user-owned untracked source files untouched for their dedicated commit.
### WMS Auth Vertical Slice (2026-07-31)
- Lesson: A security-sensitive legacy module can be structurally migrated without changing authentication behavior when the Nest module stays as composition root and public routes, JWT claims, guard identity, and OpenAPI IDs are retained.
- Fix: Place use cases in `application`, ports/types in `domain`, adapters in `infrastructure`, and controllers/DTOs/decorators in `presentation`; atomically repoint every principal, guard, and decorator consumer.
### WMS Generated City Contract (2026-08-03)
- Lesson: OpenAPI codegen cannot provide payload safety when a shared Swagger DTO has no explicit properties; a vertical module needs presentation DTOs and response DTOs with explicit Swagger metadata.
- Fix: City now exposes create/update/list/create-response DTO contracts and stable `master.city.*` operation IDs; regenerate BE OpenAPI before FE codegen after any contract change.

### WMS Route Colocation And Generated Operations (2026-08-03)
- Lesson: Route-colocated UI modules stay easier to navigate when cross-route auth/navigation remains shared, while generated API descriptors centralize transport and TanStack cache identity without raw endpoint strings in consumers.
- Fix: Generate operation descriptors beside OpenAPI schema, verify both in `api:check`, and make mutation invalidation resource-prefix based with additive cross-resource descriptors.

## 2026-08-03 - Generated WMS query-wrapper migration
- FE commit `4a4eff0` migrates master data, employees, utilities, and group permissions to generated `operations` descriptors through `useWmsQuery`/`useWmsMutation`.
- Query keys derive from operation resource keys. Successful mutations always invalidate their own resource and append configured cross-resource descriptors through `invalidate`; the latter is additive, never a replacement.
- Retired per-feature `/api/wms` request helpers and the unused typed client. `wmsApi` is the sole transport, preserves BFF HTTP-only-cookie semantics, returns backend validation errors, and handles no-content responses.
- `api:check` now verifies both generated OpenAPI schema and operation registry; Biome scripts invoke the local binary through Node for Windows reliability.
- Validation: `yarn lint` passes with one pre-existing CSS specificity warning; `yarn api:check` and `tsc --noEmit` pass. Next production build compiles but fails afterward with environment-level `spawn EPERM`.

### WMS End-to-End Generated DTO Contract (2026-08-03)
- Lesson: Migrating query wrappers alone does not provide contract safety; Swagger must explicitly describe every request and runtime response, including primitive nullable fields under the Prisma 7 ESM metadata limitation.
- Fix: Commit `eacfca1` adds Master, Employee, and Utilities request/query/response DTOs, regenerates OpenAPI, and lets FE consume `components["schemas"]` directly. Keep list/detail response shapes distinct (Employee list has `user`; detail has `users` and access contexts). Public Utility User responses must never select or expose password hashes.

### WMS FE Generated Contract Consumption (2026-08-03)
- Lesson: Feature UI can keep aliases for rendering ergonomics, but aliases must be direct `components["schemas"]` references; `useWmsQuery`/`useWmsMutation` must declare generated payload and response types, never hand-copied transport interfaces.
- Fix: FE commit `a227f1a` updates Master, Employee, Utilities, and Permissions hooks to use generated schemas. Convert `null` to `undefined` only at AntD form hydration boundaries; do not weaken the generated API contract.

### WMS Descriptor-Driven Type Inference (2026-08-03)
- Lesson: A generated operation registry only removes feature-level type duplication when descriptor IDs remain literal generic types instead of widening to `string`/a broad `WmsOperation` union.
- Fix: FE commit `a3e96b7` makes `defineOperation<TId>` retain the Swagger operation ID and derives path, query, JSON body, and success response inside `wmsApi`, `useWmsQuery`, and `useWmsMutation`. Feature hooks now call wrappers with only `operation` and optional additive `invalidate`.

### WMS Master Domain Contracts (2026-08-03)
- Do not use a catch-all master request, list, or response DTO. Country, Province, City, Company, Branch, Department, and Job Position own generated Swagger contracts for list query, create, update, list response, and delete result; stable operation IDs remain unchanged.
- Keep CRUD reuse presentation-only. `CrudWorkspace` may own table/drawer lifecycle, but each route owns its generated operation descriptors, domain fields, and mutation payloads. Never reintroduce a `resource` switch that widens unrelated contracts.
- When a frontend route needs reuse across ordinary CRUD pages, reuse only presentation lifecycle. Generated operation descriptors must stay in the domain route so body/response types remain exact and cannot widen into a cross-resource union.
- Generated OpenAPI and frontend client files may be intentionally untracked when every developer runs both services. Keep generation mandatory in local/CI scripts; use `git rm --cached` plus `.gitignore` so local artifacts remain available while Git drops them.
- When generated frontend API clients are ignored, every FE static command must ensure local generation has happened first; `api:check` remains the contract freshness gate against the locally generated BE OpenAPI artifact.
- On Windows Git hooks, avoid invoking Yarn from Husky pre-push because its stdin can be non-TTY. Invoke the required Node CLIs directly (Prisma/Nest/Next) so the hook stays non-interactive.
- Keep Husky hook commands direct and non-interactive in both WMS repos; use the same Node CLI convention on FE and BE to prevent platform-specific push failures.

### Jasper Proxy Hardening (2026-08-04)
- Jasper BFF errors must never serialize AxiosError because its request config can contain service credentials. Keep Jasper credentials server-only, use HTTP Basic Auth instead of query credentials, and expose only a safe report error reference to the browser.

### Survey Inspection Location Capture (2026-08-04)
- Survey Request creation sends nullable city_id and site_id as null. Capture City and City-filtered Site during Survey Inspection, reset Site when City changes, and persist both IDs in the inspection update payload.

### FE relation alias audit and hydration (2026-08-05)
- Commit b606bed aligns FE edit/detail selectors with the current BE relation aliases: company_group/country/city, Chasis customer/chasis_type/Cities, tariff Taxes, and explicit Tarif Vendor VAT/WHT relation names.
- Preserve DynamicSelect initial hydration fallback. It only calls detail/:id, then pathApi/:id, when the initial label is missing; do not remove it while BE detail responses still omit relations such as WO Sites.
