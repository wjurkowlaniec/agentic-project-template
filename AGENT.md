# AI Agent Guide — {{PROJECT_NAME}}

Keep this file short (<100 lines). It is the entrypoint loaded at the start of AI sessions. Detailed documentation, architecture, and domain knowledge belong in `docs/`.

## Project Snapshot

- **Description**: {{PROJECT_DESCRIPTION}}
- **Primary Language / Environment**: {{PROJECT_ENVIRONMENT}}
- **Main Entrypoint**: {{MAIN_ENTRYPOINT}}
- **Repository Type**: {{PROJECT_TYPE}} <!-- e.g. Library, CLI, Service, Application, Pipeline -->

## Session Lifecycle

### 1. Session Start
1. Read `STATE.md` to identify active task, blockers, and recent context.
2. If `STATE.md` has no active task in progress, check `TODO-NOW.md` for top priority.
3. Read the latest entry in `WORK_LOG.md`.
4. Inspect git status (`git status --short --branch`). Do not change branches if the tree is dirty.
5. Read **only** the code and docs strictly necessary for the immediate task.

### 2. Execution
- Work in small, coherent slices.
- Do not guess or assume — inspect existing patterns and interfaces before modifying.
- Preserve existing public APIs, interfaces, CLI contracts, and behavior unless requested otherwise.

### 3. Session End (for meaningful changes)
1. Run the project verification suite (tests, linter, or compiler).
2. Update `STATE.md` with the current status, blockers, and next immediate action.
3. Prepend a concise entry to `WORK_LOG.md` (summary of changes and test results).
4. Update `CHANGELOG.md` under `[Unreleased]` if public-facing behavior changed.
5. Leave changes staged or cleanly organized. **Do not auto-commit without explicit confirmation.**

## Core Engineering Rules

- **Zero Unsolicited Refactoring**: Keep changes laser-focused on the requested task. Do not reformat or reorganize unrelated files.
- **Dependency Guard**: Never introduce new external libraries, tools, or dependencies without explicit user consent.
- **Respect User State**: Never discard, overwrite, or revert unstaged user changes.
- **Safety & Blast Radius**: Never hardcode, expose, or commit secrets, tokens, or credentials. Ask for confirmation before executing irreversible or destructive commands.

## Canonical Commands

Populate these for this repository (or leave empty if not applicable):

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

## Quality & Verification Standard

- A task is not complete until relevant checks/tests pass.
- If verification cannot be executed in this environment, explicitly document the reason and the command to run manually in `STATE.md` and the final response.

## Key Paths

- **Core Logic / Source**: `{{PATH_SRC}}`
- **Tests / Validation**: `{{PATH_TESTS}}`
- **Configuration**: `{{PATH_CONFIG}}`
- **Living State**: `STATE.md`, `WORK_LOG.md`, `TODO-NOW.md`
- **Documentation**: `docs/`
