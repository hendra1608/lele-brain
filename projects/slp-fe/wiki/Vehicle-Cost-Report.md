# Vehicle Cost Report

## Context
Report module to track and analyze costs associated with specific vehicle armadas.

## Details
- **Endpoint**: `GET /vehicle-cost/FindReportVehicleCost`
- **Fields**: Mapping `armada` (Registration number) and `total_cost`.
- **Formatting**: Currency (IDR) for total cost.
- **Reporting**: Jasper integration with `biaya_per_truck.pdf`.

## Related
- [[Union-Repository]]
- [[Jasper-Integration]]
