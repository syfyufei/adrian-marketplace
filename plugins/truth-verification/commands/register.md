# truth-verification:register

**Goal**: Register data source files with SHA256 hashing to establish baseline integrity and enable change detection.

**When to use**: Before starting data analysis, register all raw data files. Register outputs after completion to create dependencies for reproducibility tracking.

---

## Preparation

Before running this command:

1. Ensure `.truth/manifest.json` exists (run `/truth-verification:init` if needed)
2. Identify all data files to register
3. Have read access to all files being registered
4. For large files (>100MB), allow extra time for hashing

---

## Execution

### Register a single file:
```bash
/truth-verification:register --file data/raw/dataset.csv
```

### Register all files in a directory (recursive):
```bash
/truth-verification:register --recursive --dir data/raw
```

### Register with pattern filtering:
```bash
/truth-verification:register --recursive --dir data/ --include "*.csv" --exclude "*-temp*"
```

### Register and add metadata:
```bash
/truth-verification:register --file data/raw/dataset.csv --source "downloaded from https://example.com/data" --description "Q4 2025 sales records"
```

### Dry run (preview without committing):
```bash
/truth-verification:register --recursive --dir data/ --dry-run
```

Shows which files would be registered without modifying manifest.

---

## What Happens

1. **File Discovery**:
   - Locates all files matching criteria
   - Skips symbolic links and directories (unless `--follow-symlinks`)
   - Skips binary files by default (unless `--include-binary`)

2. **Hash Calculation**:
   - Computes SHA256 for each file
   - Uses streaming for files >10MB to minimize memory use
   - Stores hash at `.truth/hashes/{filename}.sha256`

3. **Metadata Collection**:
   - File size, modification time, permissions
   - Optional: source URL, description, author
   - Optional: file tags for organization (e.g., "raw", "external", "validated")

4. **Manifest Update**:
   - Adds entry to `.truth/manifest.json` under `data_sources`
   - Creates entry structure:
   ```json
   {
     "path": "data/raw/dataset.csv",
     "hash": "a7b3f...",
     "size_bytes": 1048576,
     "registered_at": "2025-12-15T10:30:00Z",
     "source": "original source info",
     "tags": ["raw", "external"]
   }
   ```

5. **Logging**:
   - Records registration in `.truth/logs/register.log`
   - Shows summary: "Registered 15 files, 2 skipped, total 487 MB"

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| "File not found: ..." | Path doesn't exist | Verify file path with `ls -la` |
| "Permission denied" | Can't read file | Check read permissions: `chmod u+r filename` |
| "Invalid manifest" | `.truth/manifest.json` corrupted | Restore with `/truth-verification:init --force` |
| "File already registered" | File exists in manifest | Use `--update` to re-hash and update entry |
| "Hash mismatch during re-registration" | File was modified since last registration | Use `--force` to overwrite hash, or investigate the modification |

---

## Success Indicators

After successful execution:

1. Output shows count of registered files: `✓ Registered 15 files`
2. New entries appear in `.truth/manifest.json` under `data_sources`
3. Hash files created in `.truth/hashes/` directory
4. Log entry in `.truth/logs/register.log` shows timestamp and file list

---

## Advanced Options

### Register with backup:
```bash
/truth-verification:register --file data/raw/dataset.csv --backup-original
```

Creates `.truth/backups/dataset.csv.original` for future recovery if needed.

### Register with external source tracking:
```bash
/truth-verification:register --file data/raw/download.zip --source "AWS S3: s3://bucket/archive.zip" --source-hash "s3:md5:abcd1234..."
```

Enables verification that original source hasn't changed (if source supports hash queries).

### Register outputs as results:
```bash
/truth-verification:register --file data/cleaned/results.csv --tag "output" --parent-script codes/analysis.py
```

Links result file to generating script for dependency tracking.

---

## Next Steps

After registration:

1. **Proceed with analysis**: Run your data processing scripts
2. **Track execution**: `/truth-verification:track --script codes/analysis.py --inputs data/raw/dataset.csv --outputs data/cleaned/results.csv`
3. **Verify later**: `/truth-verification:verify --file data/raw/dataset.csv` to check if data changed

---

## Related Commands

- `/truth-verification:init` - Initialize manifest before registering
- `/truth-verification:verify` - Check if registered files have been modified
- `/truth-verification:track` - Record how registered files are used in scripts
- `/truth-verification:reproduce` - Validate complete dependency chains
