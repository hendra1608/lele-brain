# Union Repository Pattern

The `Union Repository` is the core architectural pattern in SLP that enables generic, module-agnostic data handling. It eliminates the need for repetitive boilerplate CRUD logic in every feature module.

## Core Components

### 1. `UnionRepository` (`src/modules/union/repositories/uni_repository.ts`)
The implementation layer for making network requests.
- **`UniversalFindData`**: The main powerhouse. It builds complex query strings (pagination, search, filtering) by iterating over props in the `FindDataRequest`.
- **`UniversalCreate/Update/Delete`**: Handles basic CRUD operations, automatically determining the `parentPath` from `role.ts`.
- **Automatic Permission Binding**: Every request automatically resolves its required permission and parent path by calling `findRoleModule` from `role.ts`.

### 2. `UniversalUseCase` (`src/modules/union/usecases/uni_usecases.ts`)
The service layer that bridges Redux and the Repository.
- **Workflow Persistence**: Spawns loading indicators (`setBtnLoading`, `setContentLoading`) and dispatches results to `unionSlice`.
- **Response Mapping**: Standardizes how `meta` (total pages, current page) and `data` are stored in global state.
- **Error Propagation**: Centralizes `showErrorNotification` so components don't have to handle catches manually.

### 3. `unionSlice` (`src/modules/union/slices/uni_slices.ts`)
The global data container.
- Holds `list` (for tables), `detail` (for edit forms), and `meta` (for pagination).
- **Caution**: Using `unionSlice` in components with multiple tabs can lead to "Data Bleed". Prefer local state (`useState`) and `onSuccess` callbacks in such cases.

## Workflow Example (Reading Data)
1. **Component** calls `UniversalUseCase.HandleFindData({ moduleName: ModuleEnum.Example, pathApi: "findData" }, dispatch)`.
2. **UseCase** triggers `UnionRepository.UniversalFindData`.
3. **Repository** looks up `Example` in `role.ts`, gets `parentPath` and `rolePermission`.
4. **apiClient** sends request with `ROLE_MODULE` header.
5. **Redux** state is updated, and the component re-renders with the new data.

## Related
- [[State-Management]]
- [[Role-Access-Control]]
- [[Architecture-Overview]]
