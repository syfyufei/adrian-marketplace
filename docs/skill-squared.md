# Skill-Squared

Meta-skill for creating, extending, syncing, and validating Claude Code skills.

## Dual-Repository Pattern

1. Develop skills in standalone repos (local Git, custom handlers, templates).
2. Use `/skill-squared:sync` to copy the published artifacts (skill markdown + commands) into a marketplace monorepo.
3. Keep templates aligned so create/add_command produce the same structure in both places.

## Workflow Overview

| Step | Command | Notes |
| --- | --- | --- |
| 1 | `/skill-squared:create` | Generates full repo: `.claude-plugin`, skill markdown, README, install script, MIT license. |
| 2 | `/skill-squared:command` | Adds commands with consistent YAML frontmatter and auto-updates plugin.json. |
| 3 | `/skill-squared:sync` | Moves skill + command markdown into `LLM-Research-Marketplace`. Supports dry-run and backups. |
| 4 | `/skill-squared:validate` | Ensures required files, JSON, frontmatter, and permissions are correct before publishing. |

## Template System

- Templates live in `templates/skill/`.
- Placeholders follow `{{VARIABLE_NAME}}` and are rendered with `envsubst` style substitution.
- Provided templates:
  - `plugin.json.template`
  - `marketplace.json.template`
  - `skill.md.template`
  - `README.md.template`
  - `install.sh.template`
  - `CLAUDE.md.template`
  - `command.md.template`
- Update these templates if you need different defaults (author, version, boilerplate).

## Sync Details

Default `config/marketplace-config.json -> skill-squared.sync` values:

- `files_to_sync`: `skills/{skill_name}.md`, `.claude/commands/`
- `backup_enabled`: true (creates `<file>.backup.<timestamp>.md`)
- `confirm_overwrite`: true

Recommended flow:

1. `dry_run=true` to preview.
2. Review file list and diffs.
3. Run again without dry-run to copy.
4. Immediately `/skill-squared:validate` the marketplace copy.

## Validation Checklist

`/skill-squared:validate` performs:

- Required files present (plugin/marketplace JSON, skill markdown, README, LICENSE, install.sh).
- JSON syntax via `jq`/`python -m json.tool`.
- Frontmatter includes `name` + `description`.
- Commands include `description` YAML.
- `install.sh` is executable.

Fix everything listed under `errors`. Address `warnings` before release (e.g., missing README sections, template variables left unresolved).

## Troubleshooting

- **Templates missing** → reinstall marketplace or copy from `templates/skill/` again.
- **Command not registered** → ensure plugin.json `commands` array contains `./.claude/commands/<command>.md`.
- **Sync overwrote new work** → restore from the automatically created backup path logged in the sync summary.
