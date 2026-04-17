# Frontend UI Patterns

SLP follows a strict modular UI pattern using Ant Design 5 as the foundation, enhanced with custom-tailored components.

## 1. Table & List Views
Most list pages use one of these patterns:
- **`OutstandingTable`**: Specialized for outstanding transaction lists (e.g., Quotations, Stock Transfers). It handles status-based coloring and standardized column formats.
- **`TemplateRequestTable`**: Used for survey and inspection templates.
- **SCSS Styling**: Centralized in `table.scss` for consistent borders, hover effects, and premium spacing.

## 2. Form Management & Selection
- **AntD Form Integration**: Forms are managed using Ant Design's `Form` component. Validation rules are defined inline or via common utility objects.
- **`DynamicSelect`**: The "golden standard" for dropdowns. It supports server-side searching, debouncing, and custom option rendering (e.g., for Account Receivable or Spare Parts).
- **`PaginatedSelect`**: Optimized for extremely large datasets, ensuring only a window of results is loaded at once.
- **`PremiumImageUpload`**: A custom wrapper for `antd` Upload, providing a more premium preview and progress UX.

## 3. Specialized Layouts
- **Banner UI**: Every main transaction page includes a summary banner (Cards) showing totals or counts.
- **Glassmorphism**: Applied subtly to overlays and modals to maintain the "WOW" factor.

## Related
- [[State-Management]]
- [[Core-Utility-Hooks]]
- [[Architecture-Overview]]
