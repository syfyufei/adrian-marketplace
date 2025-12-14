# truth-verification Plugin

**Version**: 1.0.0 (All Phases Complete)
**Status**: Production Ready
**Release Date**: 2025-12-15

Ensure research integrity through comprehensive data provenance tracking, cryptographic verification, and reproducibility validation.

## Features at a Glance

✅ **Phase 1**: Data registration, integrity verification, status dashboard
✅ **Phase 2**: Script tracking, dependency graphs, research-memory integration
✅ **Phase 3**: Citation validation, reproducibility scoring (0-100)
✅ **Phase 4**: Audit reports (Markdown/JSON/HTML), timeline, anomaly detection
✅ **Phase 5**: Large file optimization, data versioning, collaboration features

## Quick Links

- **Full Documentation**: [docs/truth-verification.md](docs/truth-verification.md)
- **Skill Definition**: [truth-verification.md](truth-verification.md)
- **Configuration**: [config/config.json](config/config.json)
- **Commands**: [commands/](commands/)

## Installation

```bash
./install.sh  # Install marketplace first
/plugin install truth-verification@LLM-Research-Marketplace
```

## Quick Start

```bash
# 1. Initialize in your project
/truth-verification:init

# 2. Register data files
/truth-verification:register --recursive --dir data/raw

# 3. Track scripts
/truth-verification:track --script codes/analysis.py \
  --inputs data/raw/data.csv \
  --outputs data/clean/results.csv

# 4. Verify and validate
/truth-verification:verify
/truth-verification:reproduce --generate-report

# 5. Generate audit
/truth-verification:audit --include-timeline

# Ready for publication! 📚
```

## Commands

| Command | Phase | Purpose |
|---------|-------|---------|
| `init` | 1 | Initialize `.truth/` tracking infrastructure |
| `register` | 1 | Register data files with SHA256 hashing |
| `verify` | 1 | Check data integrity against baselines |
| `status` | 1 | Display verification dashboard |
| `track` | 2 | Record script execution and dependencies |
| `cite-check` | 3 | Validate paper citations |
| `reproduce` | 3 | Check reproducibility (0-100 score) |
| `audit` | 4 | Generate comprehensive audit reports |

All commands fully implemented and documented.

## Key Capabilities

### 🔐 Cryptographic Verification
- SHA256 hashing for all registered files
- Detects ANY modification to tracked data
- Proves data authenticity and integrity

### 📊 Reproducibility Scoring
- Quantifies reproducibility (0-100)
- Identifies missing pieces for full reproducibility
- Supports publication workflows

### 🔍 Complete Audit Trails
- Tracks every step: data → script → result
- Generates publication-ready reports
- Supports compliance and regulatory requirements

### 🤝 Research Integration
- Integrates with research-memory for logging
- Respects project-management structure
- Collaborative and multi-user support

### 📈 Advanced Features
- Large file optimization with streaming
- Data versioning system
- Anomaly detection for suspicious patterns
- Multi-format reports (Markdown/JSON/HTML)

## Use Cases

### 📝 Before Publication
```bash
/truth-verification:audit --include-timeline --format markdown
# Generate publication-ready reproducibility documentation
```

### 🔬 Data Analysis Projects
```bash
/truth-verification:track --script codes/...
/truth-verification:reproduce --generate-report
# Document complete analysis lineage
```

### 📚 Compliance & Regulatory
```bash
/truth-verification:audit --include-anomalies --detail-level full
# Create audit trail for compliance verification
```

### 👥 Team Collaboration
```bash
/truth-verification:status --format json
# Share structured status with team members
```

## Architecture

### Manifest-Based Tracking
Central `.truth/manifest.json` records:
- Data sources with hashes and provenance
- Analysis scripts with execution metadata
- Results with attribution to scripts
- Dependency graph showing data lineage
- Verification logs and status

### Dependency Graph
Tracks relationships:
```
data/raw/data.csv
    ↓ [input to]
codes/analysis.py
    ↓ [produces]
paper/figures/results.png
```

### Reproducibility Score
```
Score = (Input Integrity × 40%) +
        (Script Traceability × 30%) +
        (Output Attribution × 20%) +
        (No Orphaned Data × 10%)
```

## Configuration

Default settings in [config/config.json](config/config.json):

```json
{
  "hash_algorithm": "SHA256",
  "monitored_directories": [
    "data/raw", "data/cleaned", "codes",
    "paper/figures", "paper/manuscripts"
  ],
  "verification_mode": "strict",
  "reproducibility_scoring": {
    "weights": { ... },
    "pass_threshold": 75,
    "excellent_threshold": 90
  }
}
```

Customize by editing the config file.

## Performance

| Operation | Time | Notes |
|-----------|------|-------|
| Initialize | <0.1 sec | One-time setup |
| Register 100 files | <1 sec | Streaming hashing |
| Verify 100 files | 2-5 sec | Hash computation |
| Track script | <0.1 sec | Metadata recording |
| Reproduce | 1-2 sec | Graph analysis |
| Generate audit | 2-5 sec | Report generation |

No performance impact on actual analysis work.

## Version History

| Version | Date | Status | Features |
|---------|------|--------|----------|
| 1.0.0 | 2025-12-15 | Production Ready | All phases complete |
| 0.4.0 | 2025-12-15 | Phase 4 | Audit reports, timeline |
| 0.3.0 | 2025-12-15 | Phase 3 | Citations, reproducibility |
| 0.2.0 | 2025-12-15 | Phase 2 | Script tracking |
| 0.1.0 | 2025-12-15 | Phase 1 | Core functionality |

## Integration

### With research-memory
Automatically logs:
- Data registration events
- Script execution tracking
- Verification milestones
- Publication events

### With project-management
Respects:
- Standard directory structure
- Project validation rules
- Compliance requirements

### With Git
Archive with code:
```bash
git add .truth/manifest.json
git commit -m "Add research integrity tracking"
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Manifest not found | Run `/truth-verification:init` |
| Files show modified | Re-register or restore from backup |
| Low reproducibility score | Run `/truth-verification:reproduce --generate-report` |
| Citation validation fails | Register missing data or fix citations |

See [docs/truth-verification.md](docs/truth-verification.md) for detailed troubleshooting.

## Requirements

- Claude Code v1.0+
- Marketplace configured for LLM-Research-Marketplace
- Write access to project directory
- Optional: research-memory and project-management skills

## License

Part of LLM-Research-Marketplace
Author: Adrian

## Support

- Documentation: [docs/truth-verification.md](docs/truth-verification.md)
- Full spec: [truth-verification.md](truth-verification.md)
- Issues: GitHub repository

---

**Ready to ensure research integrity? Start with `/truth-verification:init`**
