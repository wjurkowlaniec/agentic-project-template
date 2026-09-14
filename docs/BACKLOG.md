# Backlog — {{PROJECT_NAME}}

Strategic priority tiers. The AI agent or engineer picks tasks starting from P0.
For immediate tactical tasks (next few hours), refer to `TODO-NOW.md`.

## P0 — Now
- [ ] **Environment baseline** — Configure local environment, populate `AGENT.md` commands, and verify initial test/check run exits 0. Files: `AGENT.md`, configuration files. Acceptance: `{{CMD_CHECK}}` and `{{CMD_TEST}}` succeed.

## P1 — Next
- [ ] **Core functional baseline** — Implement primary domain workflow end-to-end. Files: `{{PATH_SRC}}`. Docs: `docs/ARCHITECTURE.md`. Acceptance: End-to-end baseline test passes cleanly.

## P2 — Soon
- [ ] **Test coverage expansion** — Add edge-case and contract integration test suites. Files: `{{PATH_TESTS}}`. Acceptance: Full test suite passes without regressions.

## P3 — Someday
- [ ] **Performance & diagnostic telemetry** — Add structured diagnostics and benchmark critical code paths. Acceptance: Documented benchmarks and profiling evidence.

---

### Format per item:
```markdown
- [ ] <title> — <one-line why>. Files: <paths>. Docs: <paths>. Acceptance: <testable criteria>.
```
