# AI Agent Guide — {{PROJECT_NAME}}

Keep this file short (<120 lines). It is the entrypoint loaded at every AI session.
Detailed documentation, architecture, and domain knowledge belong in `docs/`.

---

## Project Snapshot

- **Description**: {{PROJECT_DESCRIPTION}}
- **Primary Language / Environment**: {{PROJECT_ENVIRONMENT}}
- **Main Entrypoint**: {{MAIN_ENTRYPOINT}}
- **Repository Type**: {{PROJECT_TYPE}} <!-- e.g. Library, CLI, Service, Application, Pipeline -->

---

## Core Invariants

These rules are **never** negotiated without explicit user consent in this session:

1. **No unsolicited refactoring** — changes are laser-focused on the requested task only.
2. **No new dependencies** — never introduce external libraries or tools without explicit approval.
3. **No secret exposure** — never hardcode, log, or commit credentials, tokens, or API keys.
4. **No auto-commit** — never run `git commit` without explicit user confirmation.
5. **No branch switching on dirty tree** — always check `git status` first; stop if tree is dirty.
6. **No data mutation** — never modify, truncate, or delete files under `data/` without explicit instruction.
7. **No CHANGELOG reordering** — append only under `[Unreleased]`; never renumber or reformat existing entries.
8. **Preserve public contracts** — never change public APIs, CLI interfaces, or serialization formats unless requested.

---

## Forbidden Actions

- Modify any file under `data/` (read-only at runtime)
- Change the version number in `CHANGELOG.md` or reorder its entries
- Run destructive commands (`rm -rf`, `DROP TABLE`, `truncate`, etc.) without confirmation
- Commit or push without explicit user instruction
- Install system-level packages or modify global tooling config

---

## Session Lifecycle

### Session Start
1. Read `STATE.md` — identify active task, branch, and blockers.
2. If no active task, check `TODO-NOW.md` for top priority.
3. Read the latest entry in `WORK_LOG.md` for recent context.
4. Run `git status --short --branch`. **Stop if tree is dirty and branch is unexpected.**
5. Read **only** the code and docs strictly necessary for the immediate task.

### Execution
- Work in small, coherent slices.
- Inspect existing patterns before modifying — do not assume.
- Respect the Core Invariants above at all times.

### Session End (for any meaningful change)
1. Run the project verification suite (tests, linter, or compiler).
2. Update `STATE.md`: current status, blockers, next immediate action.
3. Prepend a structured entry to `WORK_LOG.md` using the required format (see WORK_LOG.md header).
4. Update `CHANGELOG.md` under `[Unreleased]` **only** if public-facing behavior changed.
5. Leave changes staged. **Do not auto-commit.**

---

## Lessons Learned

*Persistent pitfalls discovered during this project. Add entries here — do NOT rely on re-reading WORK_LOG.*

<!-- FORMAT: - [YYYY-MM-DD] <Pitfall description> → <Mitigation> -->

- *(none yet — add after first non-trivial session)*

---

## Canonical Commands

```bash
# Verification / Static Checks
{{CMD_CHECK}}

# Tests (unit / integration)
{{CMD_TEST}}

# Build / Compilation / Packaging
{{CMD_BUILD}}

# Run / Local Execution
{{CMD_RUN}}
```

---

## Quality & Verification Standard

- A task is **not complete** until relevant checks/tests pass.
- If verification cannot run in this environment, document the reason and the manual command in `STATE.md` under `blockers`.

---

## Key Paths

- **Core Logic / Source**: `{{PATH_SRC}}`
- **Tests / Validation**: `{{PATH_TESTS}}`
- **Configuration**: `{{PATH_CONFIG}}`
- **Living State**: `STATE.md`, `WORK_LOG.md`, `TODO-NOW.md`
- **Documentation**: `docs/`
