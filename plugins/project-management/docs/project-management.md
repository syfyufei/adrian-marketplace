# Project Management Skill

A Claude Code skill that standardizes research projects with repeatable creation, restructuring, validation, and reporting workflows.

## Overview

- **Version**: 0.1.0 (bundled inside LLM-Research-Marketplace v2.0.0)
- **Scope**: Any research project needing reproducible organization, Git hygiene, and compliance checks.
- **Blueprint**:
  ```
  claude-code/
  data/raw/
  data/cleaned/
  codes/
  paper/figures/
  paper/manuscripts/
  pre/poster/
  pre/slides/
  ```

## Commands

| Command | Purpose | Key Outputs |
| --- | --- | --- |
| `/project-management:create` | Scaffold new project (dirs, templates, Git) | Created dirs/files, git status, next steps |
| `/project-management:restructure` | Retrofit legacy workspace with backups | Backup path, created/removed dirs, file moves |
| `/project-management:validate` | Score compliance and optionally auto-fix | Score (0‑100), missing/extra items, fixes |
| `/project-management:status` | Summarize structure + Git telemetry | Stats table, compliance score, recommendations |

## Workflow

1. **Create** a fresh workspace when kicking off a study.
2. **Restructure** any inherited project to align with the blueprint.
3. **Validate** before handoffs or milestones (auto-fix to heal trivial gaps).
4. **Status** during check-ins to highlight progress blockers.

## Templates

Located under `templates/project/`:

- `README.md.template`
- `gitignore.template`
- `project.yml.template`
- `project-config.json.template`

All templates support simple `{{variable}}` substitution (see skill doc for variable names).

## Configuration

`config/marketplace-config.json -> project-management` stores:

- `required_dirs` / `required_files`
- Validation scoring weights
- UI score tiers

Update this section if you need additional directories or different scoring.

## Best Practices

- Keep notebooks under `codes/` to simplify validation.
- Store source datasets inside `data/raw` and derived outputs inside `data/cleaned`.
- Run `/project-management:validate --fix-issues` before archiving or sharing.
- Delete backups created by `/project-management:restructure` only after confirming success.

## FAQ

**Q: Can I use snake_case project names?**  
A: No. The skill enforces kebab-case to maintain portability and tooling compatibility.

**Q: Does validation require Git?**  
A: Git is optional, but repos without commits lose up to 10 points in the compliance score.

**Q: Where are templates rendered?**  
A: They live in `templates/project/` inside the marketplace. The command copies them into your project with simple environment substitution.
