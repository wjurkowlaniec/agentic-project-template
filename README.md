# AI-First Project Template

A practical, stack-agnostic template for structuring repositories where humans and AI agents write software together.

---

## Why this exists

If you have used AI coding assistants on non-trivial codebases, you have probably run into the same familiar frustrations:

- **Context amnesia**: Every fresh session starts from zero. The agent has no idea what happened an hour ago, what branch you are on, or what broke during the last run.
- **Context bloat**: An agent reads half the repository into its window, runs out of useful attention, and starts hallucinating interfaces or repeating mistakes.
- **Unsolicited chaos**: Without explicit guardrails, agents love rewriting working code they were never asked to touch, pulling in unvetted libraries, or wiping out unstaged local changes.
- **Task drifting**: When presented with a massive backlog, agents easily wander off into low-priority cleanup instead of solving the immediate blocker.

This template fixes those failure modes using a lightweight, file-based protocol. It does not require any external SaaS, special tooling, or proprietary extensions. It is simply a disciplined convention of living Markdown files living directly in your repository.

It works with any LLM, any coding assistant, and any technical stack (CLI tools, libraries, systems, APIs, or data pipelines).

---

## The System Architecture

The repository is organized into three distinct layers:

```text
.
├── AGENT.md                       # The primary agent contract (brief, rules, canonical commands)
├── STATE.md                       # Current operational memory (branch, status, blockers, next step)
├── WORK_LOG.md                    # Append-only session journal (newest entry on top)
├── TODO-NOW.md                    # Immediate tactical focus (strictly top 3–5 items)
├── TODO_SPRINT.md                 # Current iteration scope (bugs, features, tech debt)
├── CHANGELOG.md                   # Public release notes (Keep a Changelog format)
├── AGENT_SPECIALIZED_TEMPLATE.md  # Template for domain-specific sub-agents (e.g. audits, migrations)
├── docs/
│   ├── index.md                   # Master documentation index
│   ├── architecture.md            # System topology, data flow, trust boundaries, invariants
│   ├── modules.md                 # Subsystems, responsibilities, and module boundaries
│   ├── development.md             # Setup, local iteration loop, and testing conventions
│   ├── operations.md              # Build, release, health verification, and rollback procedures
│   ├── BACKLOG.md                 # Long-term strategic roadmap (P0 through P3)
│   ├── PROMPTS/
│   │   ├── README.md              # Guide for delegating work to autonomous subagents
│   │   └── TEMPLATE__task-prompt.md # Reusable task specification template
│   └── templates/
│       ├── FEATURE-SPEC-TEMPLATE.md # Architectural RFC template for major changes
│       └── LESSONS-IDEAS-TEMPLATE.md# Research notes, technical discoveries, and idea backlog
└── scripts/
    └── init-project.sh            # Setup script to scaffold new projects from this template
```

---

## How It Works in Practice

### 1. The Session Lifecycle

Every AI session follows a strict, repeatable protocol defined in `AGENT.md`:

#### Session Start
1. **Read `STATE.md`** first. It takes 2 seconds and immediately brings the agent up to speed on the current branch, work in progress, and known blockers.
2. If `STATE.md` shows no active task in progress, the agent picks the top item from `TODO-NOW.md`.
3. **Read the latest entry in `WORK_LOG.md`** to see what changes were made in the preceding session.
4. **Inspect `git status`**. Never switch branches or discard changes if the worktree is dirty.
5. **Read only what is needed**. The agent inspects only the specific files relevant to the assigned task.

#### Execution
- The agent works in small, coherent slices rather than attempting huge, risky rewrites.
- Inspect before editing: check existing interfaces and code patterns before proposing changes.
- Never add third-party dependencies without explicit user confirmation.
- Never touch unrelated files or perform drive-by refactoring.

#### Session End
Before ending a session with meaningful changes:
1. Run automated checks and tests to verify nothing broke.
2. Update `STATE.md` with the new status, any new blockers, and the exact next step.
3. Prepend a concise entry to `WORK_LOG.md` recording what was done and the verification outcome.
4. Update `CHANGELOG.md` under `[Unreleased]` if public behavior changed.
5. Leave changes staged or cleanly organized for human review. Never auto-commit without explicit user permission.

---

### 2. The 3-Tier Task Horizon

Agents perform best when their immediate scope is sharply bounded. To prevent context overload, tasks are split across three tiers:

| File | Time Horizon | Purpose | Rule |
| :--- | :--- | :--- | :--- |
| `TODO-NOW.md` | Next few hours | Immediate tactical focus | **Strictly 3–5 items**. The agent always works from top to bottom. |
| `TODO_SPRINT.md` | Current milestone/week | Working backlog for the iteration | Grouped into: Critical & Bugs, Features, Performance, Tech Debt. |
| `docs/BACKLOG.md` | Weeks to months | Strategic product & tech roadmap | Tiered P0–P3 items with explicit acceptance criteria. |

When a task in `TODO-NOW.md` is completed, pull the next priority item from `TODO_SPRINT.md`.

---

### 3. Canonical Commands Contract

Different projects use different languages and toolchains. To keep agents from guessing or searching through config files, `AGENT.md` establishes a standard 4-command contract:

- **Check / Lint**: Static analysis, type-checking, or formatting checks.
- **Test**: Fast unit test suite (run continuously during work) and full test suite.
- **Build**: Compilation, packaging, or artifact creation.
- **Run**: How to run the local binary, service, or entrypoint.

When initializing a new repository, fill these commands in `AGENT.md`. Any agent starting a session will immediately know how to validate its work.

---

### 4. Delegated Task Mode (`docs/PROMPTS/`)

When you want to separate architecture/planning from raw execution (or hand a concrete task to an automated subagent):

1. **Planner** fills out a markdown task prompt in `docs/PROMPTS/YYYY-MM-DD__task-name.md` using the template.
2. The prompt contains exact goal, files to touch, constraints, and an acceptance checklist.
3. **Executor** implements the task against the checklist and returns the diff.
4. **Planner or Human** runs verification, checks the diff, and updates `STATE.md` and `WORK_LOG.md`.

---

## Getting Started

### AI Prompt Initialization (Zero-Setup)

You can bootstrap any new project simply by passing this prompt to your AI coding agent:

```text
Start the project with template. Read https://raw.githubusercontent.com/wjurkowlaniec/agentic-project-template/main/SKILL.md and initialize the project based on what you know.

Target: /path/to/my-new-project
Name: <Project Name>
Purpose: <1-2 sentences explaining what the project does>
Stack: <e.g. Python CLI, Rust crate, Go service>
```

---

### Using the Initialization Script

Run `scripts/init-project.sh` to scaffold a clean copy of the template into a target directory:

```bash
./scripts/init-project.sh ~/dev/my-new-tool "My Tool" "High-performance CLI utility for log parsing."
```

The script will:
- Copy the entire structure (excluding `.git`).
- Replace `{{PROJECT_NAME}}`, `{{PROJECT_DESCRIPTION}}`, and `{{DATE}}` across markdown files.
- Initialize a fresh git repository if one does not already exist.

---

### Manual Setup

If you prefer to copy files manually:
1. Copy the repository files into your target directory.
2. Open `AGENT.md` and define:
   - Your project description, primary language/environment, and main entrypoint.
   - The 4 canonical commands (`CHECK`, `TEST`, `BUILD`, `RUN`).
   - Key paths for source code, tests, and configuration.
3. Add your immediate 3–5 priorities to `TODO-NOW.md`.
4. Point your AI agent to `AGENT.md` to begin the first session.
