# Project Architecture Overview

## Technology Stack
- **Framework**: Next.js 14 (App Router)
- **UI Library**: Ant Design 5 (with `@ant-design/nextjs-registry`)
- **State Management**: Redux Toolkit, Zustand, TanStack Query v5
- **Communication**: Axios with centralized `apiClient`
- **Styling**: SASS/SCSS & Styled Components

## Directory Structure
- `src/app`: Next.js 14 App Router pages and layouts.
- `src/modules`: Domain-driven feature modules (Auth, Master, Transactions, Union).
- `src/shared`: Generic hooks, helpers, components, and security roles.
- `src/redux`: Global state store and slices.
- `src/zustand`: Local/Ephemeral UI state store.
- `src/config`: Axios, session, and project-wide configurations.

## Layout Hierarchy
1. **`ProtectedLayout`**: Server-side session validation (iron-session). Redirects to `/auth/login` if expired.
2. **`LayeredLayout`**: Provider orchestration (Zustand, React Query, Redux, AntD).
3. **`DashboardLayout`**: The main shell (Sidebar, Navbar, Breadcrumbs).

## Core Patterns
- **Union Repository**: A generic data-fetching pattern that allows any module to perform CRUD operations using a single repository and use-case class.
- **Universal Use Case**: Standardized logic for handling API requests, loading states, and notifications.

## Related
- [[State-Management]]
- [[Role-Access-Control]]
- [[Union-Repository]]
