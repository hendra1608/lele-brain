---
name: UI Premium Vault
description: Mastery of high-end, premium UI/UX design and implementation.
---

# UI Premium Vault Skill

This skill is invoked when Bos requests a "WOW" factor or when building high-visibility UI components.

## 1. Visual Hierarchy & Depth
- **Layering**: Use `z-index` and shadows to create clear functional layers.
- **Glassmorphism**: Use for overlays and floating cards.
- **Micro-spacing**: Follow a strict 4px/8px grid system for consistency.

## 2. Micro-interactions (The Living UI)
- **Framer Motion Recipes**:
    - **Fade In/Up**: For new elements entering the viewport.
    - **Tap Response**: Subtle `scale: 1.02` on interactive elements.
    - **Layout Transitions**: Use `layoutId` for shared element transitions (e.g., expanding cards).
- **Feedback Loops**:
    - Pulse effects on active loading states.
    - Success/Error color transitions on form fields.

## 3. The "WOW" Checklist
- [ ] Does it have depth (shadows/blur)?
- [ ] Does it move (animations)?
- [ ] Is the color palette harmonious?
- [ ] Is it responsive and readable on mobile?
- [ ] Are the loading states (Skeletons) as beautiful as the content?

## Execution Rules
- Never use default browser scrollbars; customize them to fit the theme.
- Ensure all images have proper aspect ratios and fallbacks.
- Use `antd` tokens for theme consistency.
