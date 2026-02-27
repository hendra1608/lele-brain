---
name: Performance Optimizer
description: Detecting and resolving performance bottlenecks in React/Next.js applications.
---

# Performance Optimizer Skill

This skill is invoked during the verification phase or when a feature feels laggy or slow.

## 1. Diagnostic Protocol
- **React Profiler**: Use to identify "Why did this render?" and detect re-render waterfalls.
- **Network Audit**: Check for over-fetching, large payloads, and missing compression.
- **Bundle Analysis**: Use `@next/bundle-analyzer` to identify heavy dependencies that should be code-split.

## 2. Optimization Strategies
- **Memoization Mastery**: 
    - Use `React.memo` for components with heavy render logic but stable props.
    - Use `useCallback` for functions passed as props to children to prevent unnecessary re-renders.
    - Use `useMemo` for derived data filters or complex object construction.
- **Stable Fetching**: Always separate reset logic from fetch logic to avoid state-trigger-fetch loops.
- **Debouncing/Throttling**: Apply to all search inputs and resize listeners.

## 3. The Performance Checklist
- [ ] Are all expensive calculations memoized?
- [ ] Is the network payload minimized (JSON sizing)?
- [ ] Are we using Skeleton screens for perceived performance?
- [ ] Is the "Anti-Spam Search & Stable Fetch" pattern applied?
- [ ] Does the lighthouse score for Performance exceed 90?

## Execution Rules
- Prioritize "Good Enough" performance over premature optimization.
- Focus on user-perceivable lag (TTI - Time to Interactive).
