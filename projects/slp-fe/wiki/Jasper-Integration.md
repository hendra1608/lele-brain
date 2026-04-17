# Jasper Integration (Reporting System)

## Context
Centralized system for generating PDF reports via an internal proxy to the Jasper Server.

## Details
- **Global Hook**: `useJasper` simplifies report triggering.
- **Proxy**: Requests are sent to `/api/jasper-server` defined in the Next.js API routes.
- **Parameters**: Requires `report_name` (e.g., `report_revenue.pdf`) and automatically prefixes with `SLP/` path.

## Related
- [[Union-Repository]]
