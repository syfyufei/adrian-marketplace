# truth-verification:cite-check

**Goal**: Validate that all data references in papers and manuscripts correspond to registered data sources.

**Status**: Phase 3 (planned). This command validates citations and identifies unreferenced data.

---

## Planned Functionality

This command will:
- Scan paper files for data file references
- Verify each referenced file exists in manifest
- Identify data files that are registered but never cited
- Generate citation validation report
- Support strict and lenient validation modes

## Planned Usage

```bash
/truth-verification:cite-check --paper paper/manuscript.md
```

## Current Status

⏳ **Phase 3 Implementation**: This command will be available in v0.3.0

For Phase 1 (v0.1.0), use:
- `/truth-verification:register` to register all data files
- `/truth-verification:verify` to check integrity
- `/truth-verification:status` to view project health

## See Also

- `/truth-verification:register` - Register data files
- `/truth-verification:reproduce` - Validate reproducibility (Phase 3)
- `/truth-verification:audit` - Generate full audit report (Phase 4)
