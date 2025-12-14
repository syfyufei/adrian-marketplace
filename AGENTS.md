# Repository Guidelines

## Project Structure & Module Organization
- Marketplace metadata lives in `.claude-plugin/` (`plugin.json` + `marketplace.json`); command specs sit in `.claude/commands/<skill>/<command>.md`.
- Skill definitions are markdown files under `skills/` (research-memory, project-management, skill-squared). Keep these in sync with the source skill repos.
- Reusable templates: `templates/project/` for workspace scaffolds, `templates/skill/` for new skills and commands.
- Docs live in `docs/` plus high-level references (`README.md`, `USAGE.md`, `ARCHITECTURE.md`). Config defaults are in `config/marketplace-config.json`.
- `install.sh` installs the marketplace locally or stages a copy when `TARGET` is set.

## Build, Test, and Development Commands
- `./install.sh` – Registers the marketplace into Claude Code from the local checkout. Users then install plugins via `/plugin install <skill>@LLM-Research-Marketplace`.
- `TARGET=/tmp/llm-rm ./install.sh` – Stage the marketplace files (skills, commands, templates, config) into a target directory for inspection.
- `claude plugin marketplace add <path>` then `claude plugin install llm-research@LLM-Research-Marketplace` – Manual install from a path (mirrors the script).
- `/plugin list` – Verify 3 plugins are present (or fewer if selective install).
- `/help` – Verify commands are exposed (should show 18 total if all 3 plugins installed).
- `/plugin update <skill>` – Refresh a specific plugin after changes.

## Coding Style & Naming Conventions
- Commands and skills are Markdown with frontmatter and clear sections (Goal, Preparation, Execution, Error Handling). Use imperative, task-focused language.
- Command files live in `.claude/commands/<skill>/<name>.md`; slash command names should mirror file stems (e.g., `timeline.md` → `/research-memory:timeline`).
- Use kebab-case for skill names, command stems, and generated project names; avoid spaces/underscores.
- Shell scripts are Bash with `set -euo pipefail`; prefer POSIX-compatible utilities and explicit paths (`"$REPO_ROOT/..."`).
- When adding templates, keep placeholders environment-driven (`envsubst`) and avoid hardcoding user-specific paths.

## Testing Guidelines
- No automated tests exist; rely on manual verification:
  - Run `./install.sh` (or the `TARGET` variant) and ensure `skills/` and `.claude/commands/` copy correctly.
  - In Claude Code, confirm `/help` lists 18 commands and spot-check a sample flow: `/project-management:validate --fix-issues true` or `/research-memory:bootstrap` in a test workspace.
  - For template changes, generate a sample project/skill and check rendered files for missing placeholders.

## Commit & Pull Request Guidelines
- Follow the repo’s history: short, imperative subjects (`Add project-management and skill-squared skills; restructure commands`). Use one change-set per commit when practical.
- PRs should state: scope (skills/templates/config touched), rationale, and test/verification commands run (e.g., `TARGET=... ./install.sh`, `/help` output observed).
- Update relevant docs (`USAGE.md`, `docs/<skill>.md`, `ARCHITECTURE.md`) when behavior, commands, or structure changes.
- If adding a new skill or command, note syncing steps with its source repo and include any backup/dry-run notes for `skill-squared:sync`.
