# Stock Transfer Refinement

## Context
Refining the Stock Transfer detail view to ensure accurate data mapping from the backend response.

## Mapping Corrections
- **Available Stock**: Replaced `availableStock` (UI-only placeholder) with `total_qty_soh` (real-time Stock on Hand from backend).
- **UoM Logic**: Mapped to `SpareParts.UnitOfMeasurements.uom_name` with a fallback to `uom_code`.
- **Interface Stability**: Updated `TransferStockDetailData` to strictly follow the backend response schema.

## Related
- [[Union-Repository]]
