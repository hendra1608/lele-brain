---
scope: global
status: active
last-verified: 2026-08-05
maintenance: deduplicated
---
# Lele Global Knowledge
## Entry Policy
Every entry in this file is `scope: global`, `status: active`, and `last-verified: 2026-08-05` unless it says otherwise. Add an entry only when it is reusable across projects and supported by source, tests, or a documented incident. Project-specific facts belong under that project's knowledge area or repository wiki.
## Contract-First Delivery
- **Source:** observed cross-stack delivery practice. **Rule:** If an authoritative API contract exists, generate and consume transport types from it. Do not duplicate request/response interfaces in consumers; manual types are only for derived UI or domain state.
- **Source:** API compatibility practice. **Rule:** Treat operation identity, route, method, request shape, and response shape as a versioned boundary. Regenerate clients and run contract/type checks after contract changes.
## State and UI Boundaries
- **Source:** repository-convention discovery. **Rule:** Distinguish server state from local UI state. Retain the existing server-state library unless there is measured debt and an approved migration.
- **Source:** accessibility practice. **Rule:** Prefer readable states, keyboard access, loading/error/empty handling, and operational clarity over ornamental UI.
## Security and Authorization
- **Source:** global security baseline. **Rule:** Keep credentials and reusable authorization material out of browser-readable storage by default. Enforce authorization in trusted server code; client checks only improve UX.
- **Source:** incident diagnosis practice. **Rule:** Trace auth failures across presentation, request transport, server guard/policy, and persisted permission configuration. Select stack-specific adapters only after discovery.
## Knowledge Lifecycle
- **Source:** governance policy. **Rule:** Mark obsolete guidance as `deprecated`, preserve a scoped migration note, and remove it from global defaults. Do not append duplicate blocks.
- **Legacy SLP note:** SLP's historical role-header/localStorage implementation is project-scoped legacy material, not a global recommendation. See `projects/slp-fe/wiki/Role-Access-Control.md` when that project is explicitly active.
