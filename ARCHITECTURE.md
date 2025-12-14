# Architecture Overview

This repository packages three previously standalone skills into one marketplace plugin. Everything is represented as declarative markdown so Claude can execute workflows directly with its native tools.

## Multi-Skill Marketplace Layout

```
llm-research-marketplace/
├── .claude-plugin/
│   ├── marketplace.json           # Marketplace definition
│   └── plugin.json                # Plugin metadata (v2.0.0)
├── skills/                        # Skill specifications
│   ├── research-memory.md         # Copied from research-memory v0.2.0
│   ├── project-management.md      # Converted from Python handlers
│   └── skill-squared.md           # Converted from Python handlers
├── .claude/commands/
│   ├── research-memory/           # 10 commands
│   ├── project-management/        # 4 commands
│   └── skill-squared/             # 4 commands
├── templates/                     # Project + skill template packs
├── docs/                          # Skill documentation
└── config/marketplace-config.json # Unified configuration
```

All commands are namespaced (`/skill-name:command-name`) to avoid collisions when the plugin grows.

## Namespaced Command Pattern

- Directory structure mirrors namespaces: `.claude/commands/<skill>/<command>.md`.
- `.claude-plugin/plugin.json` lists commands in namespace order, allowing `/help` to group them automatically.
- Each command file uses YAML frontmatter + procedural sections (Preparation, Execution Steps, Error Handling) so Claude knows exactly how to orchestrate Read/Write/Edit/Bash calls.

## Relationship with Standalone Repositories

| Standalone Repo | Purpose in Marketplace | Sync Mechanism |
| --- | --- | --- |
| `research-memory` (v0.2.0) | Source of truth for skill definition + original docs | Copy `skills/research-memory.md` and the 10 command files into `.claude/commands/research-memory/`. Backups removed after verification. |
| `project-management` (v0.1.0) | Provided Python handlers, templates, configuration | Logic converted into `skills/project-management.md` and four command specs. Templates copied into `templates/project/`. Config merged into unified file. |
| `skill-squared` (v0.1.0) | Provided scaffolding/validation automation | Converted into `skills/skill-squared.md` plus four commands. Templates + validators merged. |

Future updates follow this loop:
1. Develop in the standalone repo.
2. Run `/skill-squared:sync` (or manual copy) to bring markdown + commands here.
3. Commit the marketplace changes and bump version if user-facing.

## Python → Markdown Conversion

Original handlers scripted filesystem work. Each handler was rewritten as declarative sections:

1. **Describe Inputs** – list required/optional parameters and validation rules.
2. **List Execution Steps** – explicit bash commands, env vars, and output expectations.
3. **Add Error Handling Guidance** – how Claude should respond when validation fails.
4. **Provide Example Replies** – ensures consistent UX.

Claude now follows the markdown instructions to perform the same operations using Read/Write/Edit/Bash tools without Python code.

## Unified Configuration & Templates

- `config/marketplace-config.json` stores versions, project blueprint requirements, scoring weights, and skill-squared validation settings. All commands reference this file for shared constants.
- `templates/project/` and `templates/skill/` contain environment-substitution templates (README, gitignore, project.yml, plugin.json, marketplace.json, command skeletons, etc.). Commands reference these locations when rendering files.

## Documentation Surfaces

- `README.md` – Marketplace snapshot, installation, and quick start.
- `USAGE.md` – Scenario-based instructions per skill with troubleshooting.
- `docs/*.md` – Skill-specific references packaged with the plugin.

## Installation & Distribution

Two supported flows:

1. **Local repository install** (`./install.sh`): ensures target directories exist, copies skills/commands/templates/config, and prints verification instructions. Works inside Claude Code Devboxes or any local clone.
2. **Marketplace install** (recommended): use `/plugin marketplace add` + `/plugin install`. Claude pulls metadata from `.claude-plugin` and automatically registers all 18 commands.

Both flows end with `/help` showing the three namespaces.

## Future Expansion

- Add new skills by dropping markdown specs under `skills/` and commands under `.claude/commands/<new-skill>/`.
- Update `plugin.json` and `config/marketplace-config.json` to register new abilities.
- Keep standalone repos authoritative for heavy development; synchronize via `/skill-squared:sync` to publish into the marketplace.
