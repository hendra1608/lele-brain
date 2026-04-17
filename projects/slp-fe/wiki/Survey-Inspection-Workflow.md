# Survey Inspection Workflow

## Context
Standardized workflow for vehicle survey inspections, minimizing redundant API calls and centralizing Work Order (WO) creation logic on the backend.

## Technical Implementation
- **Unified Submission**: Previously used `create-to-wo`, now unified into a single `PATCH` (update) call.
- **Backend Automation**: The backend now automatically generates a Work Order based on the data provided and the `is_abort` flag.
- **Service Population**: Fixed mapping of `TsurveyServices` to the frontend `services` state to ensure correct data loading when editing or re-viewing a survey.

## Patterns
- **Status Mapping**: Uses `status_vehicle` (e.g., 'B' for Breakdown) and `is_abort` to control flow.
- **Single Source of Truth**: Removing frontend-driven transaction creation in favor of backend-driven orchestration.

## Related
- [[Role-Access-Control]]
- [[Union-Repository]]
