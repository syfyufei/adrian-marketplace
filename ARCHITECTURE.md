# Architecture Overview

This repository is a marketplace containing three independent Claude Code plugins. Each plugin is fully self-contained with its own configuration, templates, and documentation. Everything is represented as declarative markdown so Claude can execute workflows directly with its native tools.

## Multi-Skill Marketplace Layout

```
llm-research-marketplace/
├── .claude-plugin/
│   └── marketplace.json           # Marketplace definition with 3 plugins
├── plugins/                       # Three independent plugins
│   ├── research-memory/
│   │   ├── .claude-plugin/plugin.json
│   │   ├── commands/              # 10 commands
│   │   ├── config/config.json
│   │   ├── docs/
│   │   └── research-memory.md
│   ├── project-management/
│   │   ├── .claude-plugin/plugin.json
│   │   ├── commands/              # 4 commands
│   │   ├── templates/project/     # Plugin-bundled templates
│   │   ├── config/config.json
│   │   ├── docs/
│   │   └── project-management.md
│   └── skill-squared/
│       ├── .claude-plugin/plugin.json
│       ├── commands/              # 4 commands
│       ├── templates/skill/       # Plugin-bundled templates
│       ├── config/config.json
│       ├── docs/
│       └── skill-squared.md
├── docs/                          # Marketplace-level documentation
└── install.sh                     # Installation script
```

All commands are namespaced (`/skill-name:command-name`) to avoid collisions when the plugin grows.

## Namespaced Command Pattern

- Directory structure mirrors namespaces: `plugins/<skill>/commands/<command>.md`.
- Each `plugins/<skill>/.claude-plugin/plugin.json` lists commands for that plugin, allowing `/help` to group them automatically.
- Each command file uses YAML frontmatter + procedural sections (Preparation, Execution Steps, Error Handling) so Claude knows exactly how to orchestrate Read/Write/Edit/Bash calls.

## Relationship with Standalone Repositories

| Standalone Repo | Purpose in Marketplace | Sync Mechanism |
| --- | --- | --- |
| `research-memory` (v0.2.0) | Source of truth for skill definition + original docs | Copy skill definition + 10 command files into `plugins/research-memory/`. Backups removed after verification. |
| `project-management` (v0.1.0) | Provided Python handlers, templates, configuration | Logic converted into `plugins/project-management/` with templates bundled locally. Config extracted into `plugins/project-management/config/config.json`. |
| `skill-squared` (v0.1.0) | Provided scaffolding/validation automation | Converted into `plugins/skill-squared/` with templates bundled locally. Config extracted into `plugins/skill-squared/config/config.json`. |

**Sync Loop** (for v3.x independent plugins):
1. Develop in the standalone repo.
2. Run `/skill-squared:sync` to copy skill definition + commands into `plugins/<skill>/`.
3. Manually verify/update plugin-local config and templates if they changed.
4. Commit the marketplace changes and bump version if user-facing.

## Python → Markdown Conversion

Original handlers scripted filesystem work. Each handler was rewritten as declarative sections:

1. **Describe Inputs** – list required/optional parameters and validation rules.
2. **List Execution Steps** – explicit bash commands, env vars, and output expectations.
3. **Add Error Handling Guidance** – how Claude should respond when validation fails.
4. **Provide Example Replies** – ensures consistent UX.

Claude now follows the markdown instructions to perform the same operations using Read/Write/Edit/Bash tools without Python code.

## Per-Plugin Configuration & Templates (v3.x)

Each plugin is now fully self-contained:

- **Configuration**: `plugins/<skill>/config/config.json` stores skill-specific settings (versions, validation rules, scoring weights, etc.). Commands reference their own plugin's config file.
- **Templates**: `plugins/<skill>/templates/` contains environment-substitution templates bundled with each plugin:
  - `plugins/project-management/templates/project/` → project scaffolding templates
  - `plugins/skill-squared/templates/skill/` → skill creation templates
- **Documentation**: `plugins/<skill>/docs/` stores skill-specific references, while marketplace-level docs (`ARCHITECTURE.md`, `USAGE.md`) remain at the root.

## Documentation Surfaces

- `README.md` – Marketplace snapshot, installation, and quick start.
- `USAGE.md` – Scenario-based instructions per skill with troubleshooting.
- `docs/*.md` – Skill-specific references packaged with the plugin.

## Installation & Distribution (v3.x)

Three supported installation flows:

1. **Selective Plugin Install** (recommended):
   - Add marketplace: `./install.sh` or `/plugin marketplace add <url>`
   - Search: `/plugin marketplace search LLM-Research-Marketplace`
   - Install only what you need:
     ```bash
     /plugin install research-memory@LLM-Research-Marketplace
     # or:
     /plugin install project-management@LLM-Research-Marketplace
     /plugin install skill-squared@LLM-Research-Marketplace
     ```

2. **Install All** (if you want all 18 commands):
   - Same steps as above, but install all three plugins

3. **Local Path Install** (`./install.sh`):
   - Registers marketplace from local path
   - Allows subsequent plugin installation as above

Key difference from v2.x: Users now see **3 separate installable plugins** instead of 1 bundled "llm-research" plugin. Each plugin can be installed/uninstalled independently.

## Future Expansion

To add a new skill to the marketplace:

1. Create `plugins/new-skill/` directory with structure:
   ```
   plugins/new-skill/
   ├── .claude-plugin/plugin.json
   ├── commands/
   ├── config/config.json
   ├── docs/
   ├── templates/ (if needed)
   └── new-skill.md
   ```

2. Register in `.claude-plugin/marketplace.json` under `plugins` array

3. Ensure each plugin is self-contained (no shared resource dependencies)

4. Keep standalone repos authoritative for heavy development; synchronize via `/skill-squared:sync` to publish into the marketplace

**Best Practice**: Each plugin should be installable standalone without requiring other plugins or marketplace-level resources.
