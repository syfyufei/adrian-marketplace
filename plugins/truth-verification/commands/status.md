# truth-verification:status

**Goal**: Display a comprehensive verification status dashboard showing project integrity, statistics, and recommendations for research continuity.

**When to use**: Run before major milestones (paper submission, milestone checkpoints) or as a quick health check (daily/weekly).

---

## Preparation

Before running this command:

1. Ensure `.truth/manifest.json` exists (run `/truth-verification:init` if needed)
2. Register files to track (run `/truth-verification:register` if manifest is empty)
3. Optional: Run `/truth-verification:verify` first for current integrity status

---

## Execution

### Quick status overview:
```bash
/truth-verification:status
```

Shows dashboard with essential statistics.

### Detailed status with recommendations:
```bash
/truth-verification:status --detail-level full
```

Includes detailed statistics, issue analysis, and actionable recommendations.

### Export status to file:
```bash
/truth-verification:status --output status-report.txt
```

### Generate JSON status for tools/scripts:
```bash
/truth-verification:status --format json --output status.json
```

### Focus on specific category:
```bash
/truth-verification:status --category data
```

Shows only data source statistics.

---

## What Happens

1. **Manifest Analysis**:
   - Reads `.truth/manifest.json`
   - Parses all data sources, scripts, results, and dependencies
   - Calculates comprehensive statistics

2. **Status Checks**:
   - Verifies .truth/ directory is accessible
   - Checks for recent verification logs
   - Detects unregistered files in monitored directories
   - Computes dependency graph completeness

3. **Statistics Computation**:
   - Counts registered items by category
   - Calculates total data size
   - Measures time since last activities
   - Computes integrity and reproducibility metrics

4. **Dashboard Rendering**:
   - Displays human-readable status summary
   - Shows color-coded indicators (✓ green, ⚠ yellow, ❌ red)
   - Lists recommendations and next actions

---

## Sample Output

```
════════════════════════════════════════════════════════════════════
                    TRUTH-VERIFICATION STATUS
════════════════════════════════════════════════════════════════════

PROJECT: test-verification
ROOT: /path/to/test-verification
STATUS: ✓ HEALTHY

────────────────────────────────────────────────────────────────────
DATA SOURCES
────────────────────────────────────────────────────────────────────
  Registered files:     15
  Total size:          487 MB
  Integrity status:     ✓ All verified (as of 2 hours ago)
  Last verification:    2025-12-15T15:00:00Z
  Files modified:       0
  Files missing:        0

────────────────────────────────────────────────────────────────────
ANALYSIS SCRIPTS
────────────────────────────────────────────────────────────────────
  Tracked scripts:      3
  Total executions:     12
  Last execution:       2025-12-15T14:30:00Z (analysis.py)
  Execution success:    100%

────────────────────────────────────────────────────────────────────
RESULTS
────────────────────────────────────────────────────────────────────
  Generated results:    8
  Total output size:    156 MB
  All results traced:   ✓ Yes
  Reproducibility:      95/100 (Excellent)

────────────────────────────────────────────────────────────────────
DEPENDENCIES
────────────────────────────────────────────────────────────────────
  Total dependencies:   18
  Complete chains:      ✓ All intact
  Broken links:         0
  Orphaned data:        0 files

────────────────────────────────────────────────────────────────────
INTEGRATION STATUS
────────────────────────────────────────────────────────────────────
  research-memory:      ✓ Integrated
  project-management:   ✓ Integrated

────────────────────────────────────────────────────────────────────
RECOMMENDATIONS
────────────────────────────────────────────────────────────────────
✓ All systems nominal. Ready for paper submission.
✓ Consider archiving .truth/ with manuscript for reproducibility.
```

---

## Status Categories

### Data Sources
- Number of registered files
- Total data volume
- Integrity verification status
- Time since last verification
- Any missing or modified files

### Analysis Scripts
- Number of tracked scripts
- Execution history
- Execution success rate
- Latest execution details

### Results
- Number of generated results
- Output volume
- Traceability to source scripts
- Reproducibility scoring

### Dependencies
- Total number of tracked dependencies
- Completeness of dependency graph
- Detection of orphaned or unused files
- Validation of chains

### Integration Status
- research-memory connection status
- project-management validation status
- Any integration warnings or issues

---

## Interpretation Guide

### ✓ HEALTHY Status
All checks pass:
- All data files integrity verified
- All dependencies complete
- No orphaned files
- High reproducibility score (>85)

→ Safe to proceed with analysis or publication.

### ⚠ CAUTION Status
Some issues detected:
- Some data files not recently verified
- Some minor dependency issues
- Low-medium reproducibility score (60-85)

→ Investigate recommendations before major decisions.

### ❌ CRITICAL Status
Serious issues detected:
- Missing data files
- Broken dependency chains
- Data integrity violations
- Very low reproducibility score (<60)

→ Must resolve before proceeding with analysis or publication.

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| "Manifest not found" | `.truth/manifest.json` doesn't exist | Run `/truth-verification:init` first |
| "Manifest corrupted" | JSON parsing failed | Restore from backup or reinitialize |
| "No data registered" | Manifest has empty data_sources array | Register files: `/truth-verification:register ...` |
| "Permission denied" | Can't read manifest or logs | Check file permissions in `.truth/` |

---

## Advanced Options

### Show status for time period:
```bash
/truth-verification:status --since "2025-12-15T00:00:00Z"
```

Shows activities and changes since specified time.

### Compare with previous status:
```bash
/truth-verification:status --compare-with-previous-day
```

Highlights what changed in past 24 hours.

### Generate status with historical trend:
```bash
/truth-verification:status --include-historical-trend
```

Shows how integrity has changed over time.

---

## Common Status Checks

**Before Paper Submission**:
```bash
/truth-verification:status --detail-level full
```

Ensure reproducibility score is excellent (>90).

**Weekly Health Check**:
```bash
/truth-verification:status
```

Quick overview to catch issues early.

**Collaboration Checkpoint**:
```bash
/truth-verification:status --format json
```

Share structured status with team members.

---

## Next Steps

Based on status output:

**If HEALTHY**:
- Proceed with analysis or publication
- Consider archiving `.truth/` with results

**If CAUTION**:
- Run `/truth-verification:verify` to get detailed results
- Address recommendations listed
- Retry `/truth-verification:status` to confirm resolution

**If CRITICAL**:
- Immediately run `/truth-verification:verify --fail-fast`
- Investigate issues with `/truth-verification:audit`
- Restore data from backup if needed

---

## Related Commands

- `/truth-verification:verify` - Detailed integrity checking
- `/truth-verification:audit` - Comprehensive audit report
- `/truth-verification:reproduce` - Check reproducibility in detail
- `/truth-verification:init` - Initialize if status fails
