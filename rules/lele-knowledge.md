# 🧠 LELE'S GLOBAL KNOWLEDGE (GIGA-BRAIN EDITION)

## General Coding Standards
- **Strict Typing**: No `any`. Use detailed interfaces.
- **Modular Components**: Atomic decomposition of UI.
- **Error Handling**: Centralized logic via `UniversalUseCase`.

## Universal Solutions & Patterns
- **Anti-Spam Search & Stable Fetch**: Use `debouncedValue`, separate reset/fetch logic, and reset page on search change.
- **State Management Matrix**:
    - **Redux (Persisted)**: Use for global session, auth, and complex cross-module settings (e.g., `companySlice`).
    - **Zustand**: Use for ephemeral UI state (e.g., sidebar collapse, modal visibility).
    - **TanStack Query (v5)**: Use for ALL server data fetching, caching, and mutations.
- **Error Resilience**:
    - Implement local Error Boundaries for non-critical widgets.
    - Always provide a "Retry" mechanism for failed API fetches.
    - Use "Empty State" illustrations rather than just blank screens.

## Design Tokens (Visual Excellence)
- **Glassmorphism**: `backdrop-filter: blur(8px); background: rgba(255, 255, 255, 0.7); border: 1px solid rgba(255, 255, 255, 0.3);`
- **Premium Shadows**: Use multi-layered soft shadows for depth (`0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)`).
- **Harmonious HSL**: Prefer HSL for color control (e.g., `hsl(var(--primary) / 0.9)`).

## Working Principles (Learned Lessons)
- **The Learning Mandate**: (New) Learning is proactive. If a bug is fixed, its root cause and prevention method must be added here immediately.
- **Surgical File Targeting**: Double-check `TargetPath`. Never leak documentation into source code.
- **Atomic Operations**: Keep Git commits granular and well-documented.

---
*Last Updated: 2026-02-27 - Upgraded to Giga-Brain Knowledge.*
