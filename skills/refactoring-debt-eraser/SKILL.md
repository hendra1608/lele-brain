---
name: Refactoring & Debt-Eraser
description: Systematic identification and elimination of technical debt while maintaining functional integrity.
---

# Refactoring & Debt-Eraser Skill

This skill is invoked when Bos requests code cleanup or when Lele identifies significant technical debt during feature development.

## 1. Debt Identification
Identify the following "Code Smells":
- **God Objects**: Components or functions doing too many unrelated things.
- **Deep Nesting**: Complex logic layers that are hard to read and test.
- **Spaghetti Imports**: Circular dependencies or imports that cross module boundaries.
- **Hardcoded Values**: Lack of constants or config-driven logic.

## 2. Refactoring Protocols
Follow the "Surgical Extraction" method:
1. **Understand & Document**: Map the current logic before changing anything.
2. **Atomic Extraction**: Extract pure logic into `_utils` or `_hooks`.
3. **Component Decomposition**: Break down UI into smaller, atomic `_components`.
4. **Interface Isolation**: Ensure the module has a clean, typed interface for other modules to use.

## 3. The Safety Checklist
- [ ] Is the refactoring purely structural (No functional changes during cleanup)?
- [ ] Are the existing dependencies still satisfied?
- [ ] Is the new structure more modular and follow the `<300 lines` rule?
- [ ] Has the cleanup introduced any new lints or type errors?

## Execution Rules
- Prioritize "High Impact, Low Risk" refactors first.
- Always perform refactoring in a dedicated commit, separate from feature work.
