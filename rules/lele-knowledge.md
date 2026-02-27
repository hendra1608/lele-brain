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
- **Error Resilience (Universal Protocols)**:
    - **Circuit Breaker**: If an external API fails repeatedly, stop requests for a cooldown period to prevent cascading failures.
    - **Exponential Backoff**: For retry mechanisms, increase wait time exponentially (1s, 2s, 4s, 8s) to avoid "Stoning" the server.
    - **Graceful Degradation**: If a non-critical feature (e.g., Avatars) fails, show a placeholder instead of crashing the whol page.
- **Accessibility (a11y) as a Premium Standard**:
    - **ARIA roles**: Always use labels and roles for screen readers.
    - **Keyboard Navigation**: Any premium UI must be fully navigable via `Tab` and `Enter`.
    - **Contrast ratios**: Ensure text meets WCAG AA standards (min 4.5:1) for professional readability.

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
