---
name: Cloud-Edge Orchestra
description: Deployment-layer optimization to achieve ultra-low latency and premium responsiveness.
---

# Cloud-Edge Orchestra Skill

This skill focuses on infrastructure and deployment strategies to enhance the "Snappy" feel of an application.

## 1. The Edge Mechanic
- **Latency Targeting**: Aim for <50ms responses by moving logic to the Edge (nearest server to user).
- **Runtime Awareness**: Understand the limitations of the Edge Runtime (limited Node.js APIs) vs Node.js Runtime.

## 2. Next.js Optimizations (Zero-Touch)
- **Edge Middleware**: Use for authentication, geolocation, and A/B testing at the edge level.
- **ISR (Incremental Static Regeneration)**: Balance between fresh data and instant page loads.
- **Streaming & RSC**: Implement React Server Components and Suspense to chunk-load heavy pages.

## 3. Implementation Guardrails
- **Cost Analysis**: Evaluate if Edge Functions fit the project budget.
- **Compatibility Check**: Ensure external libraries are compatible with Edge Runtime before enabling.

## 4. Execution Rules
- Prioritize "Snappy" UI transitions and instant auth checks.
- Only suggest Edge conversion for high-latency or high-frequency endpoints.
