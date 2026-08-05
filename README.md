# Lele Brain
Lele Brain is a local-first, versioned source of reusable engineering rules, skills, and safe workflows.
## Structure
- `rules/`: global policy and reusable knowledge.
- `skills/`: focused, callable workflows plus `skill-registry.md`.
- `workflows/`: safe supporting processes.
- `projects/`: project-scoped local memory; do not treat it as global policy.
## Activation
The canonical `lele-orchestrator` skill dispatches by dominant risk. Individual skills are exposed to Codex through source-of-truth directory links that point back to this repository, so no `SKILL.md` is duplicated.
## Local-first safety
`sync-brain.ps1` is read-only by default. It never pulls or pushes. Explicit staging requires file paths, secret scanning, staged-diff checks, and review; committing additionally requires `-ConfirmCommit`.
## Quality gate
Run `powershell -ExecutionPolicy Bypass -File scripts\validate-brain.ps1` and `powershell -ExecutionPolicy Bypass -File scripts\validate-codex-links.ps1`. For security-sensitive or requested scored work, require independent review and resolve every P0/P1 finding before completion.
