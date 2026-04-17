# State Management Strategy

The SLP project uses a hybrid state management strategy to balance persistence, performance, and developer ergonomics.

## 1. Redux (Global & Persistent)
Used for data that needs to live across the entire application lifecycle and potentially persist after a page refresh.
- **Library**: Redux Toolkit (RTK) with `redux-persist`.
- **Persistence**: Managed via `localStorage` (root key).
- **Core Slices**:
    - `authSlice`: User session and tokens.
    - `companySlice`: Current active company context.
    - `unionSlice`: Generic data container for most modules.
    - `basicSlice`: Global UI states like sidebars and breadcrumbs.

## 2. Zustand (Ephemeral & Local UI)
Used for managing transient UI states that do not require global persistence but are too complex for `useState`.
- **Location**: `src/zustand/store`.
- **Usage**: Sidebar state, modal visibility flags, and module-specific temporary clones (e.g., `inquiry_copy_store`).

## 3. TanStack Query v5 (Server State)
Managed via `QueryProvider` in `LayeredLayout`. 
- **Role**: Handling server cache, synchronization, and automated re-fetching.
- **Standard**: Mandatory for newer modules and complex data fetching to avoid global state pollution (`unionSlice` data bleed).

## 4. Local React State (`useState`)
Encouraged for:
- Form data within specific modals.
- Table filtering/pagination details limited to a single page.
- Props-drilling within small component atoms.

## Related
- [[Union-Repository]]
- [[Architecture-Overview]]
