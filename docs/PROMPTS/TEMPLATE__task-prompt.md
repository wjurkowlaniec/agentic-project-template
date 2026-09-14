# <Task Title>

## Context
<1–3 sentences: what subsystem/module is affected and why this change is needed now.>

## Goal
<1 sentence: what success looks like in plain terms.>

## Files likely to change
- `path/to/file.ext`
- `path/to/tests.ext`

## Constraints & Invariants
- Preserve all existing public APIs, interfaces, CLI contracts, and behavior unless explicitly requested.
- Inspect existing implementations before modifying; adhere to the established code style.
- No new third-party dependencies without prior approval.
- Keep changes modular and focused.

## Implementation Steps
1. **Preparation**: Inspect existing code and verify baseline test/check pass.
2. **Core Changes**: Step-by-step description of modifications.
3. **Refactoring**: Keep changes cohesive and clean.
4. **Testing**: Add or update automated test cases.

## Acceptance Checklist
- [ ] Static checks & linter pass cleanly (`{{CMD_CHECK}}`).
- [ ] Automated tests pass (`{{CMD_TEST}}`).
- [ ] Build / compilation completes with zero errors (`{{CMD_BUILD}}`).
- [ ] Verification command executed without regressions.
- [ ] `CHANGELOG.md` updated under `[Unreleased]` if public behavior changed.

## Out of Scope
- <List anything the agent should NOT touch or refactor in this task.>

## Risk Areas
- <Highlight any tricky states, race conditions, performance pitfalls, or backwards-compatibility traps.>
