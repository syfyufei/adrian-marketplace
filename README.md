# Adrian Marketplace

Personal Claude Code plugin marketplace containing curated plugins for enhanced productivity.

## Available Plugins

### research-memory
- **Description**: A comprehensive research and memory management plugin for Claude Code
- **Version**: 1.0.0
- **Author**: syfyufei
- **Category**: Productivity
- **Tags**: research, memory, notes, knowledge-management

## Installation

To use this marketplace with Claude Code:

1. Add this marketplace to your Claude configuration:
```bash
claude plugin marketplace add /Users/adrian/Documents/GitHub/adrian-marketplace
```

2. Install plugins from this marketplace:
```bash
claude plugin install research-memory
```

## Structure

```
adrian-marketplace/
├── marketplace.json          # Marketplace configuration
├── plugins/                  # Plugin definitions
│   └── research-memory/
│       └── plugin.json      # Plugin metadata
└── README.md               # This file
```

## Contributing

This is a personal marketplace. Plugins are curated and tested before inclusion.

## License

This marketplace configuration is licensed under MIT License. Individual plugins may have their own licenses.