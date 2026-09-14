# Prompts Archive & Task-Driver Mode

This directory contains structured task prompts created during planning sessions and handed over to executor agents or subagent workers.

## Naming Convention

```text
YYYY-MM-DD__<short-slug>.md
```
Example: `2026-09-08__core-parser-refactor.md`

## Why Task-Driver Mode?

When collaborating across sessions or delegating implementation:
1. **Separation of Concerns**: The Planner analyzes architecture, invariants, and constraints without burning context on code generation.
2. **Explicit Verification**: The prompt defines an exact acceptance checklist and out-of-scope boundaries.
3. **Audit Trail**: Every prompt remains documented in repository history, explaining *why* and *how* changes were made.

## Workflow

```mermaid
sequenceDiagram
    participant Planner as Planner Agent
    participant User as Human Engineer
    participant Executor as Executor Agent
    participant Repo as Codebase & Living Docs

    Planner->>Repo: 1. Create docs/PROMPTS/YYYY-MM-DD__task.md
    Planner->>User: 2. Ready to execute
    User->>Executor: 3. Pass prompt to executor
    Executor->>Repo: 4. Write code & tests
    Executor->>User: 5. Return diff & completion status
    User->>Planner: 6. Hand diff back for verification
    Planner->>Repo: 7. Run validation & update STATE.md / WORK_LOG.md
```

## Template

Use `docs/PROMPTS/TEMPLATE__task-prompt.md` to create new prompts.
