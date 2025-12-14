# truth-verification:init

**Goal**: Initialize the `.truth/` directory infrastructure and create an empty manifest file for tracking data provenance and analysis workflows.

**When to use**: Run this command at the start of any research project or when setting up truth-verification for an existing project.

---

## Preparation

Before running this command:

1. Ensure you are in your project's root directory
2. Have write permissions for creating the `.truth/` directory
3. Verify the project doesn't already have a `.truth/` directory (unless using `--force`)

---

## Execution

### Basic usage:
```bash
/truth-verification:init
```

Creates `.truth/` directory with default manifest structure.

### Force overwrite existing manifest:
```bash
/truth-verification:init --force
```

Recreates manifest even if `.truth/` already exists (backs up old manifest as `.truth/manifest.backup.json`).

### Custom manifest location:
```bash
/truth-verification:init --manifest-dir .verification
```

Uses `.verification/` instead of `.truth/` (useful for teams with naming preferences).

---

## What Happens

1. **Creates directory structure**:
   ```
   .truth/
   ├── manifest.json           # Central registry
   ├── hashes/                 # Hash records (populated by register)
   ├── logs/                   # Execution logs
   └── reports/                # Generated reports
   ```

2. **Creates empty manifest.json** with template structure:
   ```json
   {
     "version": "1.0.0",
     "initialized_at": "2025-12-15T10:30:00Z",
     "project_root": "/path/to/project",
     "data_sources": [],
     "analysis_scripts": [],
     "results": [],
     "dependencies": []
   }
   ```

3. **Adds `.truth/` to .gitignore** (creates .gitignore if needed):
   - Prevents accidental commits of manifest changes during local work
   - Optional: Use `--include-gitignore` to NOT add to .gitignore (for shared teams)

4. **Validates setup**:
   - Confirms all directories created
   - Verifies manifest.json is valid JSON
   - Tests write permissions
   - Shows success message or errors

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| "Permission denied" | No write access to project dir | Check directory permissions: `chmod u+w .` |
| ".truth directory already exists" | Init already run | Use `--force` to overwrite, or use different `--manifest-dir` |
| "Not in a project root" | Current dir isn't a valid project | Verify you're in project root (`ls project.yml` or `ls .claude-plugin/`) |
| "Invalid manifest JSON created" | File system issue | Contact support; manifest template is hard-coded and should never fail |

---

## Success Indicators

After successful execution:

1. Directory `.truth/` exists with subdirectories (manifest, hashes, logs, reports)
2. File `.truth/manifest.json` contains valid JSON with empty data_sources array
3. `.gitignore` includes `.truth/` line (unless `--include-gitignore=false`)
4. Command output shows: `✓ Initialized .truth/ directory at /path/to/project/.truth`

---

## Next Steps

After initialization:

1. **Register existing data**: `/truth-verification:register --recursive --dir data/raw`
2. **Check status**: `/truth-verification:status`
3. **Track analysis**: `/truth-verification:track --script codes/analysis.py ...` (after running scripts)

---

## Related Commands

- `/truth-verification:register` - Add data files to manifest after init
- `/truth-verification:status` - View current verification state
- `/truth-verification:verify` - Check if any registered files have been modified
