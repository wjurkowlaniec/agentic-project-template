# Development Workflow — {{PROJECT_NAME}}

## Prerequisites & Setup

1. **Clone the repository**:
   ```bash
   git clone <repo-url>
   cd {{PROJECT_NAME}}
   ```

2. **Environment Configuration**:
   ```bash
   cp .env.example .env  # if applicable
   ```

3. **Install Dependencies / Toolchains**:
   Execute the project-specific dependency installation command defined in `AGENT.md`.

## Development Cycle

1. **Verify Baseline**:
   Always confirm existing tests and checks pass before writing new code:
   ```bash
   {{CMD_CHECK}}
   {{CMD_TEST}}
   ```

2. **Iterative Changes**:
   - Make focused modifications in small, coherent slices.
   - Run fast unit tests repeatedly during development.

3. **Pre-Review Verification**:
   Before ending a session or requesting code review:
   - [ ] Static checks & formatting pass cleanly.
   - [ ] Automated test suite passes with zero failures.
   - [ ] Build / compilation completes with zero warnings or errors.

## Testing Standards

- **Unit Tests**: Test core domain logic in isolation without external I/O dependencies.
- **Integration Tests**: Verify contracts between components, data persistence, and external adapters.
- **Edge Cases & Regressions**: Every bug fix should include a test reproducing the original issue.
