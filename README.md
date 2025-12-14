# LLM Research Marketplace

LLM Research Marketplace v2.0.0 bundles three Claude Code skills—research-memory, project-management, and skill-squared—into a single plugin with 18 namespaced commands. The marketplace converts all prior Python handlers into declarative markdown specifications so Claude can execute workflows with its native Read/Write/Edit/Bash tools.

## Marketplace Snapshot

| Skill | Version | Purpose | Commands |
| --- | --- | --- | --- |
| research-memory | 0.2.0 | Academic research memory management | 10 |
| project-management | 0.1.0 | Standardized project scaffolding, restructuring, validation | 4 |
| skill-squared | 0.1.0 | Skill creation, extension, sync, and validation | 4 |

Total commands: **18** – all registered via `.claude/commands/<skill>/<command>.md`.

## Installation

In a Claude Code terminal:

```bash
/plugin marketplace add syfyufei/llm-research-marketplace
/plugin install llm-research@LLM-Research-Marketplace
```

Alternatively, run the included script locally:

```bash
./install.sh
```

### Verify Installation

```bash
/plugin list
/help
```

`/help` should show the 18 commands across three namespaces:

- `/research-memory:*` (10 commands)
- `/project-management:*` (4 commands)
- `/skill-squared:*` (4 commands)

## Quick Start Workflow

1. **Create a project workspace** – `/project-management:create` scaffolds directories, templates, and optional Git init.
2. **Standardize legacy repos** – `/project-management:restructure` backs up and normalizes inherited projects.
3. **Track research progress** – `/research-memory:bootstrap`, `:remember`, and `:query` manage dev logs, decisions, and plans.
4. **Build new skills** – `/skill-squared:create` + `/skill-squared:command` scaffold and extend new Claude Code skills.
5. **Sync skills back** – `/skill-squared:sync` copies artifacts into this marketplace, while `/skill-squared:validate` keeps everything compliant.

## Command Reference

### research-memory Commands
`bootstrap`, `checkpoint`, `focus`, `insights`, `query`, `remember`, `review`, `status`, `summary`, `timeline`

### project-management Commands
`create`, `restructure`, `validate`, `status`

### skill-squared Commands
`create`, `command`, `sync`, `validate`

See `docs/*.md` for deep dives and usage examples.

## Directory Layout

```
llm-research-marketplace/
├── .claude-plugin/
│   ├── marketplace.json
│   └── plugin.json     # Version 2.0.0 with 3 skills / 18 commands
├── .claude/commands/
│   ├── research-memory/
│   ├── project-management/
│   └── skill-squared/
├── skills/
│   ├── research-memory.md
│   ├── project-management.md
│   └── skill-squared.md
├── templates/
│   ├── project/
│   └── skill/
├── config/
│   └── marketplace-config.json
├── docs/
│   ├── research-memory.md
│   ├── project-management.md
│   └── skill-squared.md
├── install.sh
├── ARCHITECTURE.md
├── USAGE.md
└── README.md
```

## Configuration & Templates

- `config/marketplace-config.json` centralizes versions, structure requirements, validation weights, and sync defaults.
- `templates/project/` renders README/gitignore/project.yml/.project-config.json for `/project-management:*` commands.
- `templates/skill/` powers `/skill-squared:create` and `/skill-squared:command` (plugin.json, marketplace.json, skill markdown, README, install script, CLAUDE.md, command template).

## Documentation Set

- `docs/research-memory.md` – Phase logging, memory file expectations, and best practices.
- `docs/project-management.md` – Blueprint, validation scoring, and restructuring notes.
- `docs/skill-squared.md` – Template engine, sync semantics, validation checklist.
- `ARCHITECTURE.md` – Multi-skill marketplace pattern, namespacing, and sync relationships.
- `USAGE.md` – Scenario-based walkthroughs and troubleshooting.

## Management Commands

```bash
# List installed plugins
claude plugin list

# Update to the latest marketplace release
claude plugin update llm-research

# Remove if needed
claude plugin uninstall llm-research
```

## Development Notes

- Source repositories remain available for deep development:
  - `/Users/adriansun/Documents/GitHub/research-memory`
  - `/Users/adriansun/Documents/GitHub/project-management`
  - `/Users/adriansun/Documents/GitHub/skill-squared`
- Sync changes into this marketplace with `/skill-squared:sync` to keep the unified plugin current.

## License

MIT License applies to the marketplace. Individual skill templates inherit the same license.
