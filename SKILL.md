---
name: init-agentic-project
description: >
  Initializes and scaffolds a new technical project using the agentic-project-template
  (https://github.com/wjurkowlaniec/agentic-project-template).
  Configures AGENT.md, STATE.md, TODO-NOW.md, and docs/ tailored to the target project.
---

# Agentic Project Initializer

This guide instructs an AI agent on how to bootstrap and configure a new technical project using `agentic-project-template`.

## Goal

Create a new, fully configured repository at the specified target directory based on `agentic-project-template`, populated with project-specific context, canonical commands, and living documentation.

## Template Repository

- **Git Remote**: `https://github.com/wjurkowlaniec/agentic-project-template.git`
- **Fallback**: If working locally where the template already exists on disk (e.g. in `~/tmp/new-project-template`), you can copy directly from that directory.

## Step-by-Step Procedure

### 1. Extract or Confirm Project Information
Identify the following from the user's prompt (infer reasonable defaults if not explicitly specified):
- **Target Directory**: Destination path for the project (e.g. `/tmp/my-project` or `./my-app`).
- **Project Name**: Human-readable name.
- **Description / Purpose**: 1-2 sentence summary of what the system does.
- **Environment & Stack**: Primary language and runtime (e.g. Python 3.12, Rust, Node.js/TypeScript, Go).
- **Project Type**: e.g. CLI Tool, Library / Package, Service / API, Engine, Pipeline.
- **Entrypoint**: Main source file or executable path.
- **Canonical Commands**:
  - Check / Lint (e.g. `ruff check .`, `cargo clippy`, `npm run lint`)
  - Test (e.g. `pytest`, `cargo test`, `go test ./...`)
  - Build (e.g. `cargo build`, `go build`, `npm run build`, or `echo "no build step"`)
  - Run (e.g. `python main.py`, `cargo run`, `go run .`)

### 2. Scaffold the Target Repository
1. Ensure target directory exists:
   ```bash
   mkdir -p "<TARGET_DIR>"
   ```
2. Clone the template into the target directory:
   ```bash
   git clone --depth 1 https://github.com/wjurkowlaniec/agentic-project-template.git "<TARGET_DIR>"
   rm -rf "<TARGET_DIR>/.git"
   ```
   *(Or if local template path is available: `rsync -av --exclude='.git' /path/to/template/ "<TARGET_DIR>/"`)*

3. Initialize a clean git repository in the target:
   ```bash
   git -C "<TARGET_DIR>" init
   ```

### 3. Tailor the Living Documentation
In `<TARGET_DIR>`, update the following files with concrete project details (do NOT leave raw `{{PLACEHOLDERS}}`):

1. **`AGENT.md`**:
   - Update header: `# AI Agent Guide — <PROJECT_NAME>`
   - `Description`: Concrete project purpose.
   - `Primary Language / Environment`: e.g. `Python 3.12` / `Rust 1.80` / `Go 1.23`.
   - `Main Entrypoint`: e.g. `src/main.py`.
   - `Repository Type`: e.g. `CLI Tool`.
   - `Canonical Commands`: Put the actual commands in the code block.
   - `Key Paths`: Update `PATH_SRC`, `PATH_TESTS`, `PATH_CONFIG` to match the project structure.

2. **`STATE.md`**:
   - Set current date (`YYYY-MM-DD`).
   - Set `current_branch: main`.
   - Set `status: Initial scaffold complete, ready for implementation`.
   - Set `next_action: <First immediate implementation step>`.

3. **`TODO-NOW.md`**:
   - Replace placeholder tasks with 3 immediate tactical tasks relevant to the project's actual goals.

4. **`docs/architecture.md` & `docs/modules.md`**:
   - Adjust component names and diagrams to reflect the actual subsystems if known.

5. **`CHANGELOG.md`**:
   - Update project name header.

### 4. Verify & Commit
1. Verify no unresolved `{{...}}` template tokens remain:
   ```bash
   grep -rn "{{.*}}" "<TARGET_DIR>" || true
   ```
2. Create initial git commit:
   ```bash
   git -C "<TARGET_DIR>" add .
   git -C "<TARGET_DIR>" commit -m "Initial commit from agentic-project-template"
   ```
3. Report success to the user with a summary of configured paths and commands.
