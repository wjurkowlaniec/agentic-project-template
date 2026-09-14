# Work Log — {{PROJECT_NAME}}

Append-only session diary. **Newest entry on top.**

## Required Entry Format

Every entry MUST include all four fields. No field may be omitted or left empty.

```markdown
## YYYY-MM-DD — <Short title of what was done>

- **What**: <1–3 sentences: what changed, which files, what behavior was affected>
- **Evidence**: <Verification output — test results, linter output, git diff summary, or "could not verify: <reason>">
- **Decisions**: <Key choices made and why; "none" is acceptable if truly no decisions>
- **Open Ends**: <What is unresolved, deferred, or needs follow-up; "none" if clean>
```

> If you cannot fill a field, write `N/A — <reason>`. Do NOT omit the field.

---

## 2026-09-07 — Project Template Initialization

- **What**: Initialized directory layout, living documentation system, and session lifecycle files. Configured `AGENT.md` with session protocols, `TODO-NOW.md`, `TODO_SPRINT.md`, and `docs/BACKLOG.md`.
- **Evidence**: Directory layout verified. Template token grep returned expected results for a fresh template.
- **Decisions**: Used append-only log format (newest on top) for easier context loading. Kept AGENT.md under 120 lines to stay within fast-read budget.
- **Open Ends**: Canonical commands left as `{{CMD_*}}` placeholders — to be filled during project-specific bootstrap.
