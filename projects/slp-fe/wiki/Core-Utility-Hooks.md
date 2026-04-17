# Core Utility Hooks

These custom hooks are the building blocks of cross-module logic in SLP.

## 1. Reporting & Integration
- **`use_jasper`**: The universal hook for triggering Jasper reports. It abstracts the axios call to the internal `/api/jasper-server` proxy, handling PDF generation and browser download/viewing.

## 2. Approval Logic
- **`use-approval-workflow`**: Handles the logic for fetching and managing approval sequences. It integrates with `ApprovalWorkflowHelper` for module-specific data resolution.
- **`use-approval-permissions`**: Encapsulates the logic for checking if the current user/role has permission to Approve, Reject, or Cancel a transaction based on the workflow state.

## 3. UI Helpers
- **`use-pagination-select`**: Orchestrates state for `PaginatedSelect` components, managing searching, debouncing, and manual trigger/reset.
- **`use-modal`**: A simplified wrapper for managing AntD modal states (visible, confirmLoading) with standard reset logic.
- **`use_responsive`**: Provides standardized breakpoints for layouts that need manual adjustments outside of SASS media queries.

## 4. Security & Navigation
- **`use_dashboard_access`**: Evaluates `localStorage` tokens and roles to dynamically hide/show sidebar items.
- **`handle-logout`**: Centralized logic for clearing `iron-session`, clearing Redux persisted state, and redirecting to login.

## Related
- [[State-Management]]
- [[Architecture-Overview]]
- [[Role-Access-Control]]
