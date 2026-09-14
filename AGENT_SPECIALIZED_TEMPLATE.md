# Specialized Agent Guide Template — <Domain / Subsystem>

Use this template when a project domain requires specialized protocols that would bloat `AGENT.md` (e.g., Compliance/Audit, Optimization, Security Review, Data Migrations, or Hardware Integration).

---

# <Specialized Role Name> Guide

## 1. Goal & Scope

<Describe the specific objective of this agent role, e.g. "Audit security baseline against commits", "Benchmark and optimize throughput", or "Verify data integrity across schema versions".>

## 2. Infrastructure & Access Points

- **Primary Target / Route**: `<path/to/module or entrypoint>`
- **Configuration / Key**: `<path/to/config or environment key>`
- **Test Fixtures / Data**: `<path/to/fixtures>`

## 3. Workflow Procedure

### Phase A: Baseline & Identification
1. Identify baseline commit or metric.
2. Run baseline comparison: `git log --oneline <baseline>..HEAD` or baseline test runner.
3. List candidate items, regressions, or target areas.

### Phase B: Execution
1. Apply focused changes or optimizations.
2. Re-run verification suite with relevant flags.

### Phase C: Evidence & Verification
1. Gather evidence: test run output, benchmark metric, or diagnostic report.
2. Confirm zero regressions on standard test suites.

## 4. Quality Rules & Invariants

- Rule 1: <Invariant specific to this domain>
- Rule 2: <What the agent MUST NEVER do>
- Rule 3: <Evidence requirements before claiming success>

## 5. End Procedure

1. Update domain-specific log (e.g., `AUDIT_LOG.md` or `BENCHMARKS.md`).
2. Update `STATE.md` and `WORK_LOG.md` if the review altered local state or revealed blockers.
3. Do not auto-commit without explicit confirmation.
