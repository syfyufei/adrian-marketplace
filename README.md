# Adrian Skills

A curated collection of Claude Code skills for research and development workflows, following the [superpowers](https://github.com/obra/superpowers) marketplace pattern.

## Available Skills

### research-memory
Academic research memory management skill for tracking project continuity, decisions, and experiments across sessions.

**Features:**
- Session Bootstrap: Quickly restore project state and recent progress
- Session Logging: Document research activities with structured phase segmentation
- Historical Query: Search past decisions, experiments, and insights

**Usage:**
```
"Research Memory, help me get back up to speed with my project"
"Log this work session to Research Memory"
"Search for our decisions about spatial lag models"
```

## Installation

### Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/syfyufei/adrian-marketplace/main/install.sh | bash
```

### Manual Installation

**Option 1: From GitHub**

```bash
git clone https://github.com/syfyufei/adrian-marketplace.git
cd adrian-marketplace
claude plugin marketplace add .
claude plugin install adrian-skills@adrian-skills-marketplace
```

**Option 2: Direct Marketplace Add**

In Claude Code session:
```bash
/plugin marketplace add syfyufei/adrian-marketplace
/plugin install adrian-skills@adrian-skills-marketplace
```

### Verify Installation

```bash
claude plugin list
```

You should see `adrian-skills` in the installed plugins list.

## Structure

This is a monorepo following the superpowers pattern:

```
adrian-marketplace/
├── .claude-plugin/
│   ├── marketplace.json      # Marketplace definition
│   └── plugin.json          # Plugin metadata
├── skills/
│   └── research-memory.md   # Research memory skill
├── install.sh               # Installation script
└── README.md                # This file
```

## Adding New Skills

To add new skills to this marketplace:

1. Create a new `.md` file in the `skills/` directory
2. Follow the skill format with frontmatter:
   ```markdown
   ---
   name: skill-name
   description: Skill description
   ---
   # Skill documentation...
   ```
3. Update this README to list the new skill
4. Commit and push to GitHub

## Individual Skill Repositories

For development and standalone installation, each skill has its own repository:

- **research-memory**: [syfyufei/research-memory](https://github.com/syfyufei/research-memory)

Users can install skills either:
- From this marketplace (all skills together)
- From individual repositories (single skill)

## Usage

After installation, skills are automatically available in Claude Code sessions. Simply use natural language to trigger them:

```
"Research Memory, bootstrap my project context"
"Log this session to research memory"
```

## Management Commands

```bash
# List installed plugins
claude plugin list

# Update to latest version
claude plugin update adrian-skills

# Uninstall
claude plugin uninstall adrian-skills
```

## Contributing

This is a personal skills collection. Skills are curated and tested before inclusion.

## Documentation

- **[USAGE.md](USAGE.md)**: Detailed usage guide, verification, and troubleshooting
- **[ARCHITECTURE.md](ARCHITECTURE.md)**: System architecture and relationship with individual skill repositories

## License

MIT License. Individual skills may have their own licenses.