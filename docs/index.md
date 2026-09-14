# Developer Documentation — {{PROJECT_NAME}}

Welcome to the technical documentation for {{PROJECT_NAME}}.

## System & Architecture

- **[System Architecture](architecture.md)**: High-level design, data flow, trust boundaries, and core invariants.
- **[Modules & Subsystems](modules.md)**: Subsystem breakdown, responsibilities, public interfaces, and directory layout.

## Engineering Workflows

- **[Development Workflow](development.md)**: Local setup, iterative dev loop, testing standards, and verification checklists.
- **[Operations & Release Guide](operations.md)**: Release pipeline, pre-release checklists, operational commands, and rollback procedures.

## Session Lifecycle (Living Docs at Repo Root)

The project uses root-level living documents to maintain state across AI sessions:

- **`AGENT.md`** — Entrypoint for every AI session: snapshot, lifecycle protocol, rules, canonical commands, and key paths.
- **`STATE.md`** — Ephemeral operating memory: branch, blockers, active status, and immediate next action.
- **`WORK_LOG.md`** — Append-only session diary (newest on top) recording completed tasks and test results.
- **`TODO-NOW.md`** — Immediate tactical focus: strictly top 3–5 items (P0/P1).
- **`TODO_SPRINT.md`** — Sprint backlog categorized by priority (Bugs, Features, Tech Debt).
- **`CHANGELOG.md`** — User-facing release notes following Keep a Changelog format.
- **`docs/BACKLOG.md`** — Strategic prioritized roadmap (P0, P1, P2, P3).
- **`docs/PROMPTS/`** — Task prompts for delegated execution. Template in `docs/PROMPTS/README.md`.
