---
name: bootstrap-agentic-project
description: >
  Bootstraps a new OR adopts an existing technical project using agentic-project-template
  (https://github.com/wjurkowlaniec/agentic-project-template).
  Configures AGENT.md, STATE.md, TODO-NOW.md, and docs/ for the target project.
  Scope: living-docs setup only. Application implementation starts AFTER explicit user request.
---

# Agentic Project Bootstrap

This guide instructs an AI agent how to set up agentic living documentation for a project.

> **TWO MODES** — determine which applies before doing anything else:
>
> - **Mode A — New Project**: target directory is empty or does not exist → clone template, fill placeholders
> - **Mode B — Adopt Existing Project**: target directory contains an existing codebase → add only missing files, discover info from code

---

## Template Repository

- **Git Remote**: `https://github.com/wjurkowlaniec/agentic-project-template.git`
- **Fallback (local)**: `rsync -av --exclude='.git' ~/tmp/new-project-template/ "<TARGET_DIR>/"`

---

## Mode A — New Project

### Step A1 — Extract Project Information

**Required before proceeding** — ask the user only for these if missing:

| Field | Notes |
|---|---|
| **Target Directory** | Destination path (e.g. `~/dev/my-app`) |
| **Project Name** | Human-readable name (used in all headers) |
| **Description** | 1–2 sentences: what the system does |

**Fill as `TBD` if unknown — do not ask, do not block:**

| Field | Default when unknown |
|---|---|
| **Stack** | `TBD — define when implementation starts` |
| **Project Type** | `TBD` |
| **Entrypoint** | `TBD — define with the first implementation slice` |
| **Canonical Commands** | `TBD — no command configured yet` (for each of check/test/build/run) |

> These technical details emerge from the first implementation session, not from bootstrapping.
> Leave them as TBD — the agent will fill them in when the stack is decided.


### Step A2 — Scaffold the Target Repository

```bash
git clone --depth 1 https://github.com/wjurkowlaniec/agentic-project-template.git "<TARGET_DIR>"
rm -rf "<TARGET_DIR>/.git"
git -C "<TARGET_DIR>" init
```

### Step A3 — Tailor the Living Documentation

**First, find every token dynamically:**

```bash
grep -rn "{{" "<TARGET_DIR>" --include="*.md" --include="*.sh" | grep -v BOOTSTRAP.md
```

Replace **every** occurrence. Do not work from a static list of file names.

**Rules for specific files:**

- `docs/ARCHITECTURE.md`, `docs/MODULES.md` — update header/name only. **Leave component/module sections as placeholders — do NOT design architecture now.**
- All other files — replace all `{{TOKENS}}` with concrete values.

### Step A3.5 — Remove Template-Only Files

The following files are part of the template infrastructure and **must be deleted** from the target project:

```bash
rm "<TARGET_DIR>/BOOTSTRAP.md"                  # bootstrap instructions, not needed in project
rm "<TARGET_DIR>/AGENT_SPECIALIZED_TEMPLATE.md" # blank template, only keep if you'll use sub-agents
rm -rf "<TARGET_DIR>/scripts/"                  # init-project.sh only makes sense in the template repo
```

Then **replace `README.md`** with a minimal project-specific one:

```bash
cat > "<TARGET_DIR>/README.md" << 'EOF'
# <PROJECT_NAME>

<PROJECT_DESCRIPTION>

## Quick Start

```bash
# Setup
<setup commands>

# Run
<CMD_RUN>
```

## Development

See `AGENT.md` for canonical commands and project conventions.
EOF
```

> **Tip**: Keep `README.md` minimal at bootstrap — it can be expanded once the project has real content.

### ⛔ STOP — New Project Initialization Boundary

After Step A3.5, initialization is complete. Do not proceed further unless explicitly asked.

**Out of scope for new project bootstrap:**
- Writing application source code
- Designing or implementing architecture
- Filling module details in `docs/MODULES.md` or `docs/ARCHITECTURE.md`
- Adding dependencies or configuring tooling

If the user's prompt implies any of the above: *"Bootstrap complete. Do you want me to start implementation now?"*

---

## Mode B — Adopt Existing Project

### Step B1 — Discover Project Information from Codebase

Do **not** ask the user for information that can be read from the code. Inspect in order:

```bash
# Identify stack & project metadata
cat pyproject.toml 2>/dev/null || cat package.json 2>/dev/null || cat Cargo.toml 2>/dev/null || cat go.mod 2>/dev/null
cat README.md 2>/dev/null | head -60
ls -la
```

Extract from the above:
- **Project Name** — from `[project] name`, `"name":`, `[package] name`, `module` directive, or directory name
- **Description** — from `[project] description`, `"description":`, or README first paragraph
- **Stack** — from tooling files (`pyproject.toml` → Python, `Cargo.toml` → Rust, `package.json` → Node/TS, `go.mod` → Go)
- **Entrypoint** — from `[project.scripts]`, `"main":`, `[[bin]]`, or convention (`src/main.py`, `cmd/main.go`, `src/index.ts`)
- **Canonical Commands** — from `[tool.taskfile]`, `Makefile`, `"scripts":` in `package.json`, or CI config (`.github/workflows/`)

If any field cannot be determined from code, ask the user only for that specific field.

### Step B2 — Add Only Missing Files

Check which template files are absent. Copy **only** what is missing — never overwrite existing files.

```bash
# Check what's missing
for f in AGENT.md STATE.md WORK_LOG.md TODO-NOW.md TODO_SPRINT.md CHANGELOG.md .gitignore; do
  [ ! -f "<TARGET_DIR>/$f" ] && echo "MISSING: $f"
done
for f in docs/ARCHITECTURE.md docs/MODULES.md docs/DEVELOPMENT.md docs/OPERATIONS.md docs/INDEX.md docs/BACKLOG.md; do
  [ ! -f "<TARGET_DIR>/$f" ] && echo "MISSING: $f"
done
```

Copy each missing file from the template (clone to a temp dir if needed):
```bash
git clone --depth 1 https://github.com/wjurkowlaniec/agentic-project-template.git /tmp/agentic-template
# Then copy individual missing files, e.g.:
cp /tmp/agentic-template/AGENT.md "<TARGET_DIR>/AGENT.md"
rm -rf /tmp/agentic-template
```

### Step B2.5 — Do NOT copy template-only files

The following files belong to the template infrastructure only. **Never copy them into an existing project:**

| File | Reason |
|---|---|
| `BOOTSTRAP.md` | Bootstrap instructions — irrelevant once setup is done |
| `AGENT_SPECIALIZED_TEMPLATE.md` | Blank template — copy manually only if you need sub-agents |
| `scripts/init-project.sh` | Creates new projects from the template — not useful inside a project |
| `README.md` | Template's own README — the existing project already has one; do not overwrite |

### Step B3 — Tailor the Living Documentation

**Find every token dynamically:**

```bash
grep -rn "{{" "<TARGET_DIR>" --include="*.md" --include="*.sh" | grep -v BOOTSTRAP.md
```

Replace **every** occurrence. Rules differ from Mode A for architecture/modules:

- `docs/ARCHITECTURE.md`, `docs/MODULES.md` — **fill from actual code inspection** (directory layout, key files, existing README architecture sections). For existing projects this is expected.
- `WORK_LOG.md` — add an initial adoption entry describing the state of the project at time of adoption.
- `STATE.md` — reflect actual current branch (`git branch --show-current`) and real project status, not "Initial scaffold complete".
- `TODO-NOW.md` — populate from any existing TODO comments, open issues, or known next steps.
- `CHANGELOG.md` — if project has existing changelog in another format, link to it; do not duplicate history.

### ⛔ STOP — Adoption Boundary

After Step B3, adoption is complete. The following remain out of scope unless explicitly asked:

- Modifying existing application source code
- Adding or removing dependencies
- Running migrations, refactors, or cleanups

*"Adoption complete. Living docs are now set up. Do you want me to [next task]?"*

---

## Step 4 — Acceptance Verification (Both Modes)

Run each check. All must pass before reporting success.

### Check 1 — No orphan tokens
```bash
grep -rn "{{" "<TARGET_DIR>" --include="*.md" --include="*.sh" | grep -v BOOTSTRAP.md
# Expected: no output
```

### Check 2 — Commit exists (Mode A) / Git is clean (Mode B)
```bash
# Mode A:
git -C "<TARGET_DIR>" add . && git -C "<TARGET_DIR>" commit -m "chore: initial scaffold from agentic-project-template"
git -C "<TARGET_DIR>" log --oneline -1

# Mode B:
git -C "<TARGET_DIR>" status --short
# Expected: only new living-doc files appear as untracked/modified
```

### Check 3 — Smoke test
Run the project's `CMD_RUN` as defined in `AGENT.md`. If the environment cannot execute it, document the reason in `STATE.md` under `blockers`.

### Success Report Format
```
Bootstrap complete. [Mode A: New Project | Mode B: Existing Project Adoption]
- No orphan tokens: ✓
- Commit / git status: ✓  (<detail>)
- Smoke test: ✓ / SKIPPED (<reason>)
- Stack: <stack name>
- Entrypoint: <entrypoint path>
- Commands configured in AGENT.md: check / test / build / run
```
