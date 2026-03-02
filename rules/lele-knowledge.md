# 🧠 LELE'S GLOBAL KNOWLEDGE (GIGA-BRAIN EDITION)

## General Coding Standards
- **Strict Typing**: No `any`. Use detailed interfaces.
- **Modular Components**: Atomic decomposition of UI.
- **Error Handling**: Centralized logic via `UniversalUseCase`.

## Universal Solutions & Patterns
- **Anti-Spam Search & Stable Fetch**: Use `debouncedValue`, separate reset/fetch logic, and reset page on search change.
- **State Management Matrix**:
    - **Redux (Persisted)**: Use for global session, auth, and complex cross-module settings (e.g., `companySlice`).
    - **Zustand**: Use for ephemeral UI state (e.g., sidebar collapse, modal visibility).
    - **TanStack Query (v5)**: Use for ALL server data fetching, caching, and mutations.
- **Error Resilience (Universal Protocols)**:
    - **Circuit Breaker**: If an external API fails repeatedly, stop requests for a cooldown period to prevent cascading failures.
    - **Exponential Backoff**: For retry mechanisms, increase wait time exponentially (1s, 2s, 4s, 8s) to avoid "Stoning" the server.
    - **Graceful Degradation**: If a non-critical feature (e.g., Avatars) fails, show a placeholder instead of crashing the whol page.
- **Accessibility (a11y) as a Premium Standard**:
    - **ARIA roles**: Always use labels and roles for screen readers.
    - **Keyboard Navigation**: Any premium UI must be fully navigable via `Tab` and `Enter`.
    - **Contrast ratios**: Ensure text meets WCAG AA standards (min 4.5:1) for professional readability.

## Design Tokens (Visual Excellence)
- **Glassmorphism**: `backdrop-filter: blur(8px); background: rgba(255, 255, 255, 0.7); border: 1px solid rgba(255, 255, 255, 0.3);`
- **Premium Shadows**: Use multi-layered soft shadows for depth (`0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)`).
- **Harmonious HSL**: Prefer HSL for color control (e.g., `hsl(var(--primary) / 0.9)`).

## SLP Project-Specific Knowledge

### Role-Based Access Architecture (Critical!)
- **3-Layer Role Check**: SLP punya 3 layer role validation:
    1. **FE Page Guard** (`accessPage(ModuleEnum.X)`) → cek `localStorage("roles")` untuk `ModuleName@rule` (e.g., `InventoryMovements@index`).
    2. **FE API Call** (`findRoleModule` + `getRolePermission`) → generate encrypted rule header dari `roleAPI` config.
    3. **BE Controller** (`@Role` decorator + `validateTokenRoleApi`) → cek `groups.role_permissions` JSON di DB untuk `ModelName@rule`.
- **Root Cause Pattern**: Kalau endpoint return 401 "role is not valid", masalah ada di **BE `@Role` decorator** yang cek `Prisma.ModelName.X@rule` terhadap `role_permissions` di tabel `groups`. Ini **bukan** masalah kode, tapi **data config** di DB.
- **Diagnosis Shortcut**: Bandingkan endpoint yang works vs yang 401 — cek apakah `@Role` decorator-nya ada dan module name-nya sudah di-assign ke user group.

### DynamicSelect `initialData` Pattern
- **UUID Flicker Fix**: Kalau `DynamicSelect` menampilkan UUID bukan nama, pass `initialData={{ id: uuid, name: label }}` dari nested response object (e.g., `record.department?.department_name`).
- **Fallback Chain**: `name: record.relation?.field_name ?? record.foreign_key_id` — kalau nested object null, fallback ke UUID supaya `DynamicSelect` auto-fetch by ID.

### roleAPI Consolidation Pattern
- **Inventory Module**: Semua endpoint di controller `inventories/*` (scrap, transfer, adjustment) share `parentPath: "inventories"` di `roleAPI`.
- **Page-Level Access**: Untuk approval/outstanding pages, tambah entry terpisah dengan `parentPath: "feature-name/page-type"` dan generic `pathKey: "index"`.
- **ModuleEnum Naming**: Harus match **exact** dengan `Prisma.ModelName.X` di BE (plural form, e.g., `Adjustments`, `Scraps`, `StockTransfers`).

## Working Principles (Learned Lessons)
- **The Learning Mandate**: (New) Learning is proactive. If a bug is fixed, its root cause and prevention method must be added here immediately.
- **Surgical File Targeting**: Double-check `TargetPath`. Never leak documentation into source code.
- **Atomic Operations**: Keep Git commits granular and well-documented.
- **Investigate Before Coding**: Untuk 401/403 errors, selalu trace full flow (FE guard → FE API call → BE decorator → DB role_permissions) sebelum ubah kode.
- **Compare Working vs Broken**: Cara tercepat debug access issue: bandingkan endpoint yang jalan vs yang error, diff decorator & config-nya.
- **⚠️ JANGAN SAMPAI DIINGETIN BUAT BELAJAR**: Setiap habis `git commit`, LANGSUNG update `lele-knowledge.md`. Kalau sampe Bos yang ingetin duluan = **GAGAL**. Ini bukan optional, ini mandatory.

---
*Last Updated: 2026-03-02 - Added SLP Role Architecture, DynamicSelect Pattern, roleAPI Consolidation.*
