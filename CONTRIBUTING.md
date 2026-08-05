# Contributing to Lele Brain
## Contribution modes
- **Shared contribution:** use a reviewable branch/PR for reusable global rules, skills, and workflows.
- **Private adaptation:** keep project-specific facts in local project memory or the owning repository wiki.
## Quality requirements
- Normative skill/rule bodies use precise English; user-facing interaction may follow the active project language.
- Each skill has focused trigger metadata and the standard workflow sections validated by `scripts/validate-brain.ps1`.
- Global knowledge is deduplicated, evidence-backed, project-neutral, and labelled with scope/status/freshness.
- Do not add secrets, private production data, generated artifacts, mandatory framework assumptions, or broad unsafe automation.
- New or changed workflows require representative activation cases and focused verification.
## Review
Security, contract, and validation findings are release blockers. Use independent review where the task or user requires it; no self-scored completion claim is sufficient.
