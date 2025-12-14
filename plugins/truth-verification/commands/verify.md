# truth-verification:verify

**Goal**: Verify the integrity of registered data files by comparing their current SHA256 hashes against stored baseline values. Detect any unauthorized or accidental modifications.

**When to use**: Verify data regularly (weekly or after major analysis steps) to detect corruption or changes.

---

## Preparation

Before running this command:

1. Ensure `.truth/manifest.json` exists with registered files
2. Ensure all registered files still exist on disk
3. Have read permissions for all files
4. Allocate time proportional to total data size (large datasets may take minutes)

---

## Execution

### Verify all registered files:
```bash
/truth-verification:verify
```

### Verify specific file:
```bash
/truth-verification:verify --file data/raw/dataset.csv
```

### Verify files in a directory:
```bash
/truth-verification:verify --directory data/raw
```

### Verify with detailed report:
```bash
/truth-verification:verify --report-format detailed
```

### Verify and generate JSON report:
```bash
/truth-verification:verify --report-format json --output-file verify-report.json
```

### Stop on first error (fail-fast mode):
```bash
/truth-verification:verify --fail-fast
```

Stops checking after first file integrity failure.

---

## What Happens

1. **Hash Calculation**:
   - Recomputes SHA256 for each registered file
   - Uses streaming to minimize memory usage
   - Shows progress for large files

2. **Comparison**:
   - Compares current hash against registered baseline
   - Marks as VERIFIED if hashes match
   - Marks as MODIFIED if hashes differ
   - Marks as MISSING if file no longer exists

3. **Status Recording**:
   - Updates `last_verified` timestamp in manifest for each file
   - Records verification results in `.truth/logs/verify.log`
   - Updates overall `integrity_status` in manifest

4. **Report Generation**:
   - Displays summary: "15 files verified, 2 modified, 0 missing"
   - Lists all files with issues in detail
   - Suggests next actions if issues found

---

## Output Examples

### Success (all files verified):
```
✓ Verification Complete
  Files verified: 15
  Files modified: 0
  Files missing: 0
  Status: ALL DATA INTEGRITY VERIFIED ✓
  Last verification: 2025-12-15T15:30:00Z
```

### Issues found:
```
⚠ Verification Complete
  Files verified: 15
  Files modified: 2
  Files missing: 0
  Status: INTEGRITY ISSUES DETECTED

Modified Files:
  ❌ data/raw/dataset.csv
     Expected hash: a7b3f8d9e2c1...
     Current hash:  c9d5b1a4e2f3...
     Last verified: 2025-12-15T10:30:00Z
     Time since change: 5 hours

  ❌ data/cleaned/results.csv
     Expected hash: b8c4a9e3d1f2...
     Current hash:  d1e6c2b5f4a9...
     Last verified: 2025-12-15T14:30:00Z
     Time since change: 1 hour
```

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| "File not found: ..." | Registered file no longer exists | Use `--mark-missing` to update manifest, then investigate deletion |
| "Permission denied" | Can't read a file | Check file permissions: `ls -l filename` |
| "Invalid manifest" | `.truth/manifest.json` corrupted | Restore backup: `git checkout .truth/manifest.json` |
| "Hash computation timeout" | Very large file or slow disk | Use `--timeout-minutes 30` to extend limit |
| "No files to verify" | Manifest has empty data_sources array | Register files first: `/truth-verification:register ...` |

---

## Success Indicators

After successful execution:

1. Command returns "ALL DATA INTEGRITY VERIFIED ✓" or lists specific issues
2. Manifest's `integrity_status` field updated with verification timestamp
3. All files shown as "verified" (or specific issues listed)
4. `.truth/logs/verify.log` contains verification record

---

## Interpretation of Results

### VERIFIED
File's current hash matches registered baseline exactly. Data is unchanged.

### MODIFIED
File's hash differs from baseline. This can happen due to:
- **Legitimate**: Analysis scripts updated the file (expected)
- **Accidental**: File was edited manually without updating hash
- **Concerning**: Unauthorized modification or data corruption

### MISSING
File was registered but no longer exists on disk. This can happen due to:
- **Accidental**: File was deleted
- **Expected**: Data cleanup or restructuring
- **Concerning**: Data loss or backup failure

---

## Advanced Scenarios

### Update modified files that changed legitimately:
```bash
/truth-verification:verify --auto-update-modified --backup-old-hashes
```

Recalculates hashes for files that changed, and backs up old hashes.

### Check specific time range:
```bash
/truth-verification:verify --modified-since "2025-12-15T12:00:00Z"
```

Only reports files modified since specified timestamp.

### Compare against previous verification:
```bash
/truth-verification:verify --compare-with-previous
```

Shows detailed diff of what changed since last verification.

---

## Next Steps

If all files verify:
- Continue with analysis confident data is unchanged
- Run `/truth-verification:status` to view overall health
- Commit `.truth/manifest.json` to version control

If issues found:
- Investigate modified files: `git log -p -- data/raw/dataset.csv`
- If modification was intentional, re-register: `/truth-verification:register --file data/raw/dataset.csv --update`
- If modification was accidental, restore from backup or git

---

## Related Commands

- `/truth-verification:register` - Register new files to establish baseline
- `/truth-verification:status` - View verification status and recommendations
- `/truth-verification:reproduce` - Check if results are reproducible given current data
- `/truth-verification:audit` - Generate comprehensive audit report
