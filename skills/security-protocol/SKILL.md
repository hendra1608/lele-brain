---
name: Security Protocol
description: Hardening the application against common security threats and data leakage.
---

# Security Protocol Skill

This skill is invoked during design and verification to ensure robust security.

## 1. Frontend Hardening
- **XSS Prevention**: Never use `dangerouslySetInnerHTML` unless sanitization is guaranteed.
- **Input Sanitization**: Validate all form inputs with Zod or equivalent before submission.
- **CSRF Tokens**: Ensure all mutations include proper session/CSRF headers (handled by `UniUseCase`).

## 2. Data Protection
- **Sensitive Data Detection**: Never log tokens, passwords, or PII (Personally Identifiable Information) in the console or telemetry.
- **Role Enforcement**: Always verify that the UI hides "Unauthorized" actions, even if the API eventually rejects them.

## 3. The Security Audit Checklist
- [ ] Is all user input sanitized before rendering or sending?
- [ ] are there any `console.log` leaks of sensitive objects?
- [ ] Is the session expiry handled gracefully (no stale tokens used)?
- [ ] Are roles correctly enforced in the logic layer?

## Execution Rules
- Follow the "Principle of Least Privilege" in UI visibility.
- Report any suspected Backend security flaws (e.g., missing API authorization) to Bos immediately.
