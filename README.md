# Agentic Project Template

A battle-tested, lightweight, stack-agnostic system for shipping software with AI agents — without losing control of your codebase.

> **Used across multiple shipped projects.** This workflow emerged from real development sessions, iterated on failures, and refined until agents stopped hallucinating, drifting, and breaking things.

---

## Quick Setup

Paste this to your AI agent — works for new and existing projects:

```
Read https://raw.githubusercontent.com/wjurkowlaniec/agentic-project-template/main/BOOTSTRAP.md
and set up the agentic workflow for this project.

Target: /path/to/my-project
Name: <Project Name>
Purpose: <1-2 sentences>
```

That's it. The agent reads the bootstrap instructions from the remote, detects whether the target is a new or existing project, and configures all living docs automatically.

---

## The Problem

AI coding assistants are powerful but unreliable at scale. If you've used them on non-trivial projects, you know the failure modes:

- **Context amnesia** — every new session starts from scratch. The agent doesn't know what branch you're on, what broke last time, or what you were in the middle of.
- **Scope creep** — without explicit boundaries, agents rewrite code they were never asked to touch, pull in unvetted libraries, or redesign working architecture "while they're at it."
- **Task drift** — given a vague backlog, agents wander into low-priority cleanup instead of fixing the actual blocker.
- **Silent failures** — agents declare success after a commit without verifying that the code actually runs.

Standard solutions (system prompts, complex tooling, SaaS memory layers) add overhead and still break across sessions.

---

## The Solution

A lightweight, file-based protocol living directly in your repository. No external services. No proprietary extensions. No lock-in.

**It works because files are durable, versionable, and universally readable by any LLM.**

The system gives agents:
1. **Persistent operational memory** — they always know where they left off
2. **Explicit scope boundaries** — they know exactly what to touch and what to leave alone
3. **Objective completion criteria** — a task isn't done until tests pass, not until a commit happens
4. **Structured session handoffs** — every session leaves a record for the next one

---

## What Gets Shipped

This workflow has been used to ship:
- CLI tools with complex domain logic
- Libraries with public API contracts
- Data pipelines with strict schema invariants
- Services with operational runbooks

The common thread: agents that stay focused, document their work, and hand off cleanly — session after session.

---

## How It Works

### File Structure

```text
.
├── AGENT.md                       # Agent entrypoint: rules, commands, invariants
├── STATE.md                       # Live operational memory: branch, status, blockers, next step
├── WORK_LOG.md                    # Append-only session journal (structured format, newest on top)
├── TODO-NOW.md                    # Immediate focus: strictly 3–5 items, worked top-to-bottom
├── TODO_SPRINT.md                 # Current iteration: bugs, features, tech debt
├── CHANGELOG.md                   # Public release notes (Keep a Changelog format)
├── BOOTSTRAP.md                   # How to set up this template on a new or existing project
├── AGENT_SPECIALIZED_TEMPLATE.md  # Template for domain-specific sub-agents (audits, migrations)
└── docs/
    ├── INDEX.md                   # Documentation index
    ├── ARCHITECTURE.md            # System topology, data flow, trust boundaries
    ├── MODULES.md                 # Subsystems, responsibilities, module boundaries
    ├── DEVELOPMENT.md             # Local setup, iteration loop, testing conventions
    ├── OPERATIONS.md              # Build, release, rollback procedures
    ├── BACKLOG.md                 # Strategic roadmap (P0–P3)
    ├── PROMPTS/
    │   ├── README.md              # Guide for delegating tasks to autonomous subagents
    │   └── TEMPLATE__task-prompt.md
    └── TEMPLATES/
        ├── FEATURE-SPEC-TEMPLATE.md
        └── LESSONS-IDEAS-TEMPLATE.md
```

---

### The Session Lifecycle

Defined in `AGENT.md` and followed by every session without exception.

**Session Start — 3 reads before touching code:**
1. `STATE.md` — current branch, active task, blockers
2. `TODO-NOW.md` — if no active task, pick the top item
3. `WORK_LOG.md` — what happened last session

**Execution rules:**
- Work in small, coherent slices
- Inspect before editing — never assume an interface
- Never add dependencies without explicit approval
- Never touch files outside the task scope

**Session End — done means verified:**
1. Run tests and linter — if they can't run, document why in `STATE.md`
2. Update `STATE.md` with new status and next action
3. Prepend a structured `WORK_LOG.md` entry: What / Evidence / Decisions / Open Ends
4. Update `CHANGELOG.md` only if public behavior changed
5. Stage changes. Never auto-commit.

---

### The Task Horizon System

Agents focus best when their scope is sharply bounded. Three tiers prevent context overload:

| File | Horizon | Purpose | Hard rule |
|:---|:---|:---|:---|
| `TODO-NOW.md` | Hours | Immediate tactical focus | **Max 5 items.** Top-to-bottom order. |
| `TODO_SPRINT.md` | Days–week | Working iteration backlog | Bugs → Features → Tech Debt |
| `docs/BACKLOG.md` | Weeks–months | Strategic roadmap | P0–P3 with acceptance criteria |

---

### Core Invariants (non-negotiable)

Every project using this template enforces these in `AGENT.md`:

- No unsolicited refactoring
- No new dependencies without approval
- No secrets committed
- No auto-commit
- No branch switch on dirty worktree

These aren't suggestions — they are enforced by the agent contract in `AGENT.md`.

---

### Delegated Task Mode

For complex features or when separating planning from execution:

1. **Planner** writes a task prompt in `docs/PROMPTS/YYYY-MM-DD__task-name.md`
2. Prompt contains: goal, files to touch, constraints, acceptance checklist
3. **Executor** implements against the checklist
4. **Planner / Human** verifies, then updates `STATE.md` and `WORK_LOG.md`

---

## Getting Started

### Option 1 — AI Prompt (Zero-Setup, New or Existing Project)

Pass this to your coding agent. It handles both new projects and adoption of existing ones:

```text
Read https://raw.githubusercontent.com/wjurkowlaniec/agentic-project-template/main/BOOTSTRAP.md
and set up the agentic workflow for this project.

Target: /path/to/my-project
Name: <Project Name>
Purpose: <1-2 sentences>
Stack: <e.g. Python 3.12, Rust, Go, TypeScript>
```

The agent will detect whether the target is a new or existing project and apply the correct mode automatically.

---

### Option 2 — Manual Setup

1. Copy repo files into your target directory.
2. Fill in `AGENT.md`: description, language, entrypoint, 4 canonical commands (`CHECK`, `TEST`, `BUILD`, `RUN`), key paths.
3. Add 3–5 immediate priorities to `TODO-NOW.md`.
4. Point your agent to `AGENT.md` to start the first session.
