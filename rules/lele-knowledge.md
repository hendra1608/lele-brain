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
