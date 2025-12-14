# truth-verification:reproduce

**Goal**: Validate that research results are reproducible by checking the complete dependency chain from source data through scripts to outputs.

**Status**: Phase 3 (planned). This command validates reproducibility and computes reproducibility scores.

---

## Planned Functionality

This command will:
- Verify all input data files exist and match registered hashes
- Validate analysis scripts are traceable
- Verify output files are properly attributed to scripts
- Compute reproducibility score (0-100)
- Identify missing dependencies that prevent reproduction

## Planned Usage

```bash
/truth-verification:reproduce --generate-report
```

## Current Status

⏳ **Phase 3 Implementation**: This command will be available in v0.3.0

For Phase 1 (v0.1.0), use:
- `/truth-verification:register` to register data and outputs
- `/truth-verification:verify` to check integrity
- `/truth-verification:status` to view reproducibility metrics

## See Also

- `/truth-verification:track` - Record script execution (Phase 2)
- `/truth-verification:verify` - Check data integrity
- `/truth-verification:audit` - Generate full audit report (Phase 4)
