# Research Memory Skill

Memory system for long-running research projects. Consolidates the standalone `research-memory` repo (v0.2.0) into this marketplace.

## Capabilities

1. **Bootstrap** – Restore context (project overview, latest logs, TODOs) with `/research-memory:bootstrap`.
2. **Checkpointing** – Record structured session logs, experiments, and decisions via `/research-memory:remember`, `:review`, `:summary`, etc.
3. **Historical Query** – Search past work with `/research-memory:query` and `/research-memory:insights`.
4. **Planning** – Use `/research-memory:focus` and `/research-memory:timeline` to plan next steps.

## Memory Files

```
memory/
├── project-overview.md
├── devlog.md
├── decisions.md
├── experiments.csv
└── todos.md
```

Keep these files inside any project you want tracked. The commands expect this structure.

## Command Reference

| Command | Purpose |
| --- | --- |
| `/research-memory:bootstrap` | Summarize overview, last N log entries, TODOs. |
| `/research-memory:checkpoint` | Lightweight checkpoint (headline + TODOs). |
| `/research-memory:focus` | Extract actionable focus areas for the current session. |
| `/research-memory:insights` | Surface cross-session trends and insights. |
| `/research-memory:query` | Keyword search across logs, decisions, experiments. |
| `/research-memory:remember` | Write detailed session log with experiments/decisions. |
| `/research-memory:review` | Review past week/month progress. |
| `/research-memory:status` | Report log counts, outstanding TODOs, latest phases. |
| `/research-memory:summary` | Summarize conversation fragment into the devlog. |
| `/research-memory:timeline` | Build chronological view of major milestones. |

## Configuration

See `config/marketplace-config.json -> research-memory` for:

- `bootstrap.recent_entries_count`
- Supported `logging.phase_sections`

Adjust these values if you need more history or custom research phases.

## Best Practices

- Run `/research-memory:remember` at the end of every session to keep `devlog.md` current.
- Keep `todos.md` tidy; completed items should be checked off so bootstrap views are actionable.
- Store experiments in `experiments.csv` with consistent headers so queries produce reliable results.
- Combine with `/project-management:status` to correlate process health with research memory insights.
