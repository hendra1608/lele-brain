# Advance Settlement Approval Module

## Context
A dedicated approval list page for Advance Settlement transactions, integrated with the global `ApprovalWorkflowHelper`.

## Technical Implementation
- **Path**: `/advance-settlement/approval`
- **Hook**: Uses `ApprovalWorkflowHelper.fetchApprovalsByModule("AdvanceSettlement")`.
- **Module Name**: Linked to `ModuleEnum.AdvanceSettlementModule` ("AdvanceSettlements").
- **Workflow**: 
    - Fetches transactions pending approval for the current user's role.
    - Statuses: 0 (Draft), 1 (Waiting Approval), 2 (Approved), 3 (Rejected).
    - Links to `/advance-settlement/[id]?from=approval-list` for the actual approval action.

## Patterns
- **Standard Approval List**: Mirroring the logic used in Stock Adjustment and Scrap modules for UI consistency.
- **Dynamic Routing**: Passing the source page as a query param to enable better "Back" navigation after approval.

## Related
- [[Role-Access-Control]]
- [[Union-Repository]]
