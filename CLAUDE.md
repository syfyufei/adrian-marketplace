# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Quick Commands

- **Install locally**: `./install.sh`
- **Install from marketplace**: `/plugin install research-memory@LLM-Research-Marketplace` (or other plugins)
- **Verify installation**: `/plugin list` (should show 3 plugins) and `/help` (should show 18 commands if all installed)
- **Staged installation** (for inspection): `TARGET=/tmp/llm-rm ./install.sh`

## Project Overview

This is a **multi-skill marketplace** that bundles three independent Claude Code skills: `research-memory`, `project-management`, and `skill-squared`. Instead of a single monolithic plugin, users can install only the skills they need.

## Architecture & Key Concepts

### Structure
```
llm-research-marketplace/
├── .claude-plugin/
│   ├── marketplace.json          # Marketplace registry
│   └── plugin.json               # Plugin metadata (v2.0.0)
├── plugins/                      # Three skill plugins
│   ├── research-memory/          # Academic research memory management (10 commands)
│   ├── project-management/       # Workspace scaffolding & validation (4 commands)
│   └── skill-squared/            # Skill creation tooling (4 commands)
├── config/
│   └── marketplace-config.json   # Unified config: versions, templates, validation rules
├── templates/
│   ├── project/                  # Project workspace templates (directories, files, .gitignore)
│   └── skill/                    # Skill repo templates (plugin.json, install.sh, README)
├── docs/                         # Skill-specific documentation
├── ARCHITECTURE.md               # High-level design & sync patterns
├── USAGE.md                      # Scenario-based playbooks per skill
└── install.sh                    # Local installation & staging script
```

### Key Design Patterns

1. **Namespaced Commands**: All commands use `/skill-name:command-name` format to avoid collisions. The file structure mirrors this: `plugins/<skill>/commands/<command>.md`.

2. **Declarative Command Specs**: Commands are Markdown files with YAML frontmatter + procedural sections (Preparation, Execution Steps, Error Handling). Claude follows these instructions to orchestrate Read/Write/Edit/Bash calls.

3. **Sync Loop**: Standalone skill repos remain authoritative for heavy development. Changes are synced into this marketplace via `/skill-squared:sync`, keeping command specs and docs in sync.

4. **Templating**: Project and skill templates use environment variable substitution (`envsubst`) for dynamic rendering during creation.

## What Each Skill Does

### research-memory (v0.2.0)
Tracks research progress and context across sessions. Maintains a `memory/` directory with:
- `project-overview.md` – High-level goals and status
- `devlog.md` – Timestamped session entries organized by phase (DGP, data_preprocess, data_analyse, modeling, robustness, writing, infra, notes)
- `todos.md` – Open tasks and blockers

**10 commands**: bootstrap, remember, checkpoint, summary, review, query, focus, timeline, insights, status

### project-management (v0.1.0)
Scaffolds standardized research workspaces and validates structural compliance.

**Standard structure** (required dirs/files):
- Required directories: `claude-code/`, `data/raw`, `data/cleaned`, `codes/`, `paper/figures`, `paper/manuscripts`, `pre/poster`, `pre/slides`
- Required files: `README.md`, `.gitignore`, `project.yml`

**Validation scoring**: Directories (40%), required files (35%), content quality (15%), Git integration (10%).

**4 commands**: create, restructure, validate, status

### skill-squared (v0.1.0)
Scaffolds new Claude Code skills and manages the skill development lifecycle.

**Validation rules** (enforced before publishing):
- Required files: `.claude-plugin/{marketplace,plugin}.json`, `skills/{skill_name}.md`, `README.md`, `LICENSE`, `install.sh`
- YAML frontmatter: must have `name` and `description`
- Permissions: `install.sh` must be executable

**4 commands**: create, command, sync, validate

## Development Workflow

1. **Modify a skill**: Update files in the standalone repo (e.g., `/Users/adriansun/Documents/GitHub/research-memory`).
2. **Sync to marketplace**: Run `/skill-squared:sync` to copy skill specs + commands into `plugins/<skill>/` with automatic backups.
3. **Test locally**: Run `./install.sh`, then verify commands work with `/help` and test runs (e.g., `/project-management:create test-proj`).
4. **Commit & release**: Once verified, commit changes to this repo and bump version in `config/marketplace-config.json` if user-facing.

## Configuration & Templates

- **Per-Plugin Config**: Each plugin has `plugins/<skill>/config/config.json` with skill-specific settings. No shared configuration.
- **Plugin-Bundled Templates**:
  - `plugins/project-management/templates/project/` rendered when `/project-management:create` runs. Supports `${project_name}`, `${author_name}`, `${description}`, `${creation_date}`, `${year}`.
  - `plugins/skill-squared/templates/skill/` rendered when `/skill-squared:create` runs. Uses `{{name}}` pattern for placeholders.
- **Bundled Documentation**: Each plugin includes docs in `plugins/<skill>/docs/`

## Testing & Verification

No automated test suite. Manual verification:

1. **Installation**: `./install.sh && /plugin list` (expect `llm-research v2.0.0`)
2. **Commands visible**: `/help` should list all 18 commands grouped by skill namespace
3. **Smoke test each skill**:
   - `project-management`: `/project-management:create test-workspace` in a temp dir; verify directories and files
   - `research-memory`: `/research-memory:bootstrap` in a project with `memory/` structure
   - `skill-squared`: `/skill-squared:validate` on this marketplace itself
4. **Template rendering**: Create a test project/skill and grep for unreplaced placeholders

## Standalone Source Repos

Keep in sync with `/skill-squared:sync`:

| Repo | Purpose | Version |
| --- | --- | --- |
| `/Users/adriansun/Documents/GitHub/research-memory` | Source of truth for skill definition + docs | 0.2.0 |
| `/Users/adriansun/Documents/GitHub/project-management` | Workspace scaffolding & validation logic | 0.1.0 |
| `/Users/adriansun/Documents/GitHub/skill-squared` | Skill creation & publishing automation | 0.1.0 |

## Documentation

- **README.md** – Marketplace overview, installation, quick start
- **USAGE.md** – Scenario-based playbooks and troubleshooting per skill
- **ARCHITECTURE.md** – Multi-skill layout, Python-to-Markdown conversion, sync loop
- **AGENTS.md** – Repository guidelines for structure, naming, testing, commit style
- **docs/\*.md** – Skill-specific references bundled with the plugin

## Common Tasks

**Add a new command to an existing skill**:
1. Create `plugins/<skill>/commands/<name>.md` with YAML frontmatter + sections
2. Update `plugins/<skill>/.claude-plugin/plugin.json` to register the new command
3. Test with `/help` and manually run the command
4. Commit with rationale in the message

**Update a skill's logic**:
1. Edit the source repo (e.g., `/Users/adriansun/Documents/GitHub/research-memory`)
2. Run `/skill-squared:sync` in this marketplace to pull changes
3. Verify changes with a test run
4. Commit with a note that this was synced from the source repo

**Release a new version**:
1. Update version in `config/marketplace-config.json` for affected skills
2. Ensure all tests pass (manual verification via `/help` and smoke tests)
3. Commit with message like "Bump research-memory to v0.3.0; add query refinements"

## Code Style Notes

- **Markdown command files**: Use imperative, task-focused language in sections. Include clear examples.
- **Naming**: Kebab-case for skill names, command stems, and project names. No spaces or underscores.
- **Shell scripts** (`install.sh`): Bash with `set -euo pipefail`. Use explicit paths (`"$REPO_ROOT/..."`), not relative ones.
- **Templates**: Use environment-driven placeholders (`${VAR_NAME}`); avoid hardcoding user paths or system-specific values.
- **Path References in Commands**: Use relative paths from plugin root (e.g., `../templates/`, `../config/`) since plugins are installed independently.
- **Commenting**: Keep command specs DRY. Link to external docs (USAGE.md, ARCHITECTURE.md) rather than duplicating instructions.
