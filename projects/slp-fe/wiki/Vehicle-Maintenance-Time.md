# Vehicle Maintenance Time Report

## Context
Report module to analyze the total maintenance duration for each vehicle armada.

## Details
- **Endpoint**: `GET /maintenance-time/FindReportMaintenanceTime`
- **Fields**: Mapping `armada` and `total_maintenance_hours`.
- **Formatting**: Hours displayed with 2 decimal places.
- **Reporting**: Jasper integration with `maintenance_time.pdf`.

## Related
- [[Vehicle-Cost-Report]]
- [[Jasper-Integration]]
