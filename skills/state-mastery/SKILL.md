---
name: Adaptive State Mastery
description: Master-level state management with a discovery-first approach to optimize existing architectures.
---

# Adaptive State Mastery Skill

This skill is used to manage and optimize data flow without forcing unnecessary migrations.

## 1. Phase 0: Stack Discovery
Before proposing changes, identify the existing stack:
- **Redux Toolkit**: Look for `createSlice`, `configureStore`, or `RTK Query`.
- **Zustand**: Look for `create` hooks.
- **Context API**: Look for `createContext` and `useContext`.
- **Server State**: Look for `TanStack Query` or `useSWR`.

## 2. Redux Protocol (The Hygiene Mission)
If the project uses Redux:
- **Eliminate `any`**: Ensure all state and action payloads are strictly typed.
- **RTK Query over Thunks**: Prioritize RTK Query for server state to automate caching and re-fetching.
- **Selectors optimization**: Use `createSelector` for performance-sensitive derived data.

## 3. Atomic & Hybrid Patterns
- **Local vs Global**: Keep UI-only state (modals, tabs) in local `useState` or `Zustand`.
- **Hybrid Sync**: Standardize how Redux interacts with Server State (RTK Query).

## 4. Execution Rules
- Never replace a working library unless the technical debt is high.
- Focus on "Type Safety" and "Rendering Performance" first.
