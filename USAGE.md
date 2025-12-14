# LLM Research Marketplace – Usage Guide

This guide explains how to verify the installation, run each skill, and troubleshoot common issues for the v2.0.0 multi-skill release.

## Verify Installation

After running `./install.sh` or `/plugin install llm-research@LLM-Research-Marketplace`:

```bash
/plugin list             # Expect llm-research v2.0.0
/plugin marketplace list # Expect LLM-Research-Marketplace
/help                    # Should show 18 commands
```

If `/help` does not list all namespaces, reinstall via `./install.sh`.

## Multi-Skill Quick Start

1. `/project-management:create` – Scaffold a new research workspace (directories + templates + optional Git init).
2. `/research-memory:bootstrap` – Restore project context (overview + latest devlog + TODOs) before working.
3. Work and log progress with `/research-memory:remember` or `/research-memory:checkpoint`.
4. `/project-management:status` – Capture structural/compliance snapshots for weekly updates.
5. `/skill-squared:create` – Spin up new Claude Code skills; `/skill-squared:command` adds slash commands.
6. `/skill-squared:sync` – Copy standalone skill updates into this marketplace; `/skill-squared:validate` ensures compliance before release.

## Skill Playbooks

### research-memory
- **Bootstrap**: `/research-memory:bootstrap` compiles `memory/project-overview.md`, the last N entries from `memory/devlog.md`, and open TODOs.
- **Focus & Planning**: Use `/research-memory:focus`, `/research-memory:timeline`, `/research-memory:insights` for planning and insight generation.
- **Logging**: `/research-memory:remember` (full session), `/research-memory:checkpoint` (quick note), `/research-memory:summary` (summarize conversation), `/research-memory:review` (bounded time window).
- **Query**: `/research-memory:query` searches across memory files; `/research-memory:status` spots stale areas.

Keep the `memory/` directory inside each project. Configuration lives in `config/marketplace-config.json -> research-memory` (recent entry count, phase sections).

### project-management
- **Create**: `/project-management:create` asks for project name/root, validates kebab-case, renders templates from `templates/project/`, and optionally initiates Git.
- **Restructure**: `/project-management:restructure` backs up legacy repos, creates missing dirs, and optionally removes non-standard folders.
- **Validate**: `/project-management:validate` scores compliance (0–100) using config weights and can auto-create missing directories/files.
- **Status**: `/project-management:status` aggregates metadata, validation score, file stats, and Git info for status reports.

### skill-squared
- **Create Skills**: `/skill-squared:create` renders entire skill repositories (plugin.json, marketplace.json, README, install.sh, templates) using `templates/skill/`.
- **Add Commands**: `/skill-squared:command` scaffolds `.claude/commands/<name>.md` and updates plugin.json automatically.
- **Sync**: `/skill-squared:sync` mirrors `skills/<skill>.md` + `.claude/commands/` from standalone repos into this marketplace with backups and dry-run support.
- **Validate**: `/skill-squared:validate` ensures required files, YAML frontmatter, and permissions meet publishing standards.

## Integration Examples

- **Daily workflow**: `/project-management:status` (structure) → `/research-memory:bootstrap` (context) → work/log → `/research-memory:summary` for standups.
- **Skill development**: `/skill-squared:create data-orbit` → develop locally → `/skill-squared:command data-orbit sync` → `/skill-squared:validate` → `/skill-squared:sync` to copy into this marketplace.
- **Audit prep**: `/project-management:validate --fix-issues true` then `/research-memory:timeline` to pair structural compliance with research narrative.

## Troubleshooting

| Symptom | Checks | Fix |
| --- | --- | --- |
| Commands missing in `/help` | `claude plugin list` → ensure `llm-research v2.0.0` | Re-run `./install.sh`; ensure `.claude-plugin/plugin.json` lists all 18 commands. |
| `research-memory` cannot find memory files | Ensure `memory/` exists, run `ls memory` | Create via `mkdir -p memory` and rerun `/research-memory:bootstrap` (will create templates). |
| `project-management:create` fails regex | Project name must be kebab-case | Rename input and retry or set `force` for collisions. |
| Validation score stuck low | Missing directories/files | Run `/project-management:validate --fix-issues true` then inspect summary. |
| `/skill-squared:sync` overwrote local work | Backups emitted as `.backup.<timestamp>` | Restore from backup, rerun with `dry_run=true` to preview. |
| `/skill-squared:validate` flags permissions | `install.sh` not executable | `chmod +x install.sh` in the skill repo before validating. |

## Management Commands

```bash
claude plugin list
claude plugin update llm-research
claude plugin uninstall llm-research
claude plugin marketplace remove LLM-Research-Marketplace
```

## Further Reading

- `docs/research-memory.md`
- `docs/project-management.md`
- `docs/skill-squared.md`
- `ARCHITECTURE.md`
