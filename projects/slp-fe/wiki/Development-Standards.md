# Development Standards & Directory Protocol

This guide establishes the mandatory standards for folder structuring, component modularity, and the lifecycle of creating new pages in the SLP project.

## 1. Directory & Folder Structuring
SLP follows a strict nested-feature pattern within the `(pages)` directory.

### Module Level
- **Location**: `src/app/(pages)/(parent-category)/module-name`
- **Internal Nesting**:
    - `_components/`: Private components used only by this module (e.g., `ModuleForm.tsx`).
    - `_hooks/`: Private hooks for state/logic specific to this module.
    - `_types/`: Module-specific interfaces (always in `index.ts`).
    - `_constants/`: Static data like column definitions or option lists.

### Page Types
- `list/page.tsx`: The main landing list.
- `create/page.tsx`: Form for new records.
- `[id]/page.tsx`: Dynamic route for viewing or editing.
- `outstanding-list/page.tsx`: Specialized list for pending approvals/actions.

## 2. Modular Component Rules
- **Extraction Rule**: If a `page.tsx` exceeds 250 lines, extract the main form or complex sections into `_components/`.
- **Pure Logic**: Custom hooks (`_hooks`) should handle the complex `useForm`, `useEffect`, or Redux logic, leaving the component to focus on JSX.
- **Props-only Components**: Try to keep modular components focused on receiving props rather than independently fetching data unless they are "Smart Containers".

## 3. Step-by-Step: Creating a New Page/Module
To maintain consistency and ensure security, follow these steps:

### Step 1: Role & Module Registration
- Open `src/shared/roles/role.ts`.
- Add the module key to `ModuleEnum`.
- Register the module in `roleAPI` with its `parentPath` and required permission paths (`view`, `create`, `update`, `delete`).

### Step 2: Folder Setup
- Create the directory structure in `src/app/(pages)`.
- If it's a sub-module of Finance, put it in `(finance)`.

### Step 3: Implement Data Logic
- Define types in `_types/index.ts`.
- Use `UniversalUseCase` for API interactions to ensure standardized loading and error handling.

### Step 4: UI Implementation
- Use `OutstandingTable` (for lists) or `AntD Form` (for inputs).
- Use `DynamicSelect` for any foreign key lookups (Customers, Vendors, etc.).

## 4. Coding Protocols
- **Strict Typing**: NO `any`. Define interfaces for all API responses and component props.
- **Loading UX**: Always wrap primary triggers in `setBtnLoading` or `setContentLoading` via Redux `basicSlice`.
- **No Side Effects in Layouts**: Ensure layouts (`ProtectedLayout`, `DashboardLayout`) remain clean and only handle orchestration.

## 5. Agentic "Brain-First" Protocol (Lele Exclusive)
To ensure every decision is aligned with the project's DNA, I (Lele/Antigravity) must follow this protocol:
1. **Mandatory Session Boot**: At the very first prompt of a new session, I must read `lele-brain/rules/lele-knowledge.md` and the Wiki `README.md`. **This is no longer optional.**
2. **Search & Link**: Before writing a single line of code, I must list the relevant wiki nodes in my `implementation_plan.md`.
3. **Standard Check**: I must verify the proposed change against [[Development-Standards]] and [[State-Management]].
4. **Source over Wiki**: If a wiki node contradicts the raw codebase, the **codebase is the Absolute Truth**. I must follow the code and then update the wiki accordingly.
5. **Update Protocol**: After every successful implementation, I MUST update [[lele-knowledge.md]] or the relevant wiki node to capture any new patterns.

## Related
- [[Architecture-Overview]]
- [[Frontend-UI-Patterns]]
- [[Union-Repository]]
