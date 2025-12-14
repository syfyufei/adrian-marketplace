# v3.0.0 Independent Plugins - Testing Plan

This document outlines all test cases for the v3.0.0 marketplace refactor where three independent plugins replace the monolithic "llm-research" plugin.

## Test Environment Setup

```bash
cd /Users/adriansun/Documents/GitHub/LLM-Research-Marketplace
```

## Test Cases

### Test 1: Marketplace Addition
**Objective**: Verify marketplace can be added and plugins are discoverable

**Steps**:
```bash
./install.sh
/plugin marketplace search LLM-Research-Marketplace
```

**Expected Results**:
- Marketplace is added successfully
- Search results show 3 plugins:
  - research-memory (v0.2.0)
  - project-management (v0.1.0)
  - skill-squared (v0.1.0)

**Status**: ⏳ Pending

---

### Test 2: Independent Installation of research-memory
**Objective**: Verify research-memory plugin can be installed independently

**Steps**:
```bash
/plugin install research-memory@LLM-Research-Marketplace
/plugin list
/help | grep research-memory
```

**Expected Results**:
- Plugin installed successfully
- `/plugin list` shows "research-memory" (NOT "llm-research")
- `/help` shows 10 research-memory commands:
  - research-memory:bootstrap
  - research-memory:checkpoint
  - research-memory:focus
  - research-memory:insights
  - research-memory:query
  - research-memory:remember
  - research-memory:review
  - research-memory:status
  - research-memory:summary
  - research-memory:timeline

**Status**: ⏳ Pending

---

### Test 3: Independent Installation of project-management
**Objective**: Verify project-management plugin can be installed and templates load correctly

**Steps**:
```bash
/plugin install project-management@LLM-Research-Marketplace
/plugin list
mkdir /tmp/test-project-mgmt && cd /tmp/test-project-mgmt
/project-management:create test-workspace
ls -la test-workspace/
cat test-workspace/README.md
```

**Expected Results**:
- Plugin installed successfully
- `/plugin list` shows "research-memory" and "project-management"
- `/project-management:create` succeeds using bundled templates
- Project structure created: claude-code/, data/raw/, data/cleaned/, codes/, paper/figures/, paper/manuscripts/, pre/poster/, pre/slides/
- README.md contains proper content (not empty, placeholders replaced)
- Files: README.md, .gitignore, project.yml present

**Status**: ⏳ Pending

---

### Test 4: Independent Installation of skill-squared
**Objective**: Verify skill-squared plugin can be installed and skill creation templates work

**Steps**:
```bash
/plugin install skill-squared@LLM-Research-Marketplace
/plugin list
mkdir /tmp/test-skill-creation && cd /tmp/test-skill-creation
/skill-squared:create demo-skill
cat demo-skill/.claude-plugin/plugin.json
```

**Expected Results**:
- Plugin installed successfully
- `/plugin list` shows all 3 plugins
- `/skill-squared:create` succeeds using bundled templates
- Created directories: .claude-plugin/, commands/, templates/, config/, docs/
- plugin.json is valid JSON with correct metadata
- All templates properly rendered (no unreplaced placeholders like {{name}})

**Status**: ⏳ Pending

---

### Test 5: All Three Plugins Installed
**Objective**: Verify all plugins work together when all are installed

**Steps**:
```bash
/plugin list
/help | wc -l
```

**Expected Results**:
- All 3 plugins shown in `/plugin list`:
  - research-memory
  - project-management
  - skill-squared
- `/help` shows ~18+ commands total
- Commands properly namespaced with each skill prefix

**Status**: ⏳ Pending

---

### Test 6: Selective Uninstallation
**Objective**: Verify plugins can be uninstalled independently without affecting others

**Steps**:
```bash
/plugin uninstall project-management
/plugin list
/help | grep -c "research-memory"
/help | grep -c "skill-squared"
/help | grep "project-management" || echo "No project-management commands found"
```

**Expected Results**:
- project-management uninstalled successfully
- `/plugin list` shows only research-memory and skill-squared
- research-memory commands still present (10 commands)
- skill-squared commands still present (4 commands)
- NO project-management commands present (0 matches)

**Status**: ⏳ Pending

---

### Test 7: Configuration Isolation
**Objective**: Verify each plugin loads configuration from its own config file

**Steps**:
```bash
# Reinstall all plugins
/plugin install project-management@LLM-Research-Marketplace

# Test that each plugin uses its own config
# by checking if commands load the correct settings
/research-memory:bootstrap
/project-management:validate
/skill-squared:validate
```

**Expected Results**:
- research-memory loads from `plugins/research-memory/config/config.json`
  - Respects `recent_entries_count` setting
  - Recognizes phase_sections configuration
- project-management loads from `plugins/project-management/config/config.json`
  - Validates against standard_structure
  - Uses scoring_weights
- skill-squared loads from `plugins/skill-squared/config/config.json`
  - Enforces required_files list
  - Validates required frontmatter

**Status**: ⏳ Pending

---

## Test Execution Summary

| Test Case | Expected | Actual | Status |
|-----------|----------|--------|--------|
| Test 1: Marketplace Addition | 3 plugins discoverable | | ⏳ |
| Test 2: research-memory Install | 10 commands visible | | ⏳ |
| Test 3: project-management Install | Templates work, project created | | ⏳ |
| Test 4: skill-squared Install | Skill created with templates | | ⏳ |
| Test 5: All Plugins | 18 commands total | | ⏳ |
| Test 6: Selective Uninstall | Plugin removed, others work | | ⏳ |
| Test 7: Config Isolation | Each plugin uses own config | | ⏳ |

**Overall Status**: ⏳ Pending

---

## Success Criteria

✅ All 7 tests pass
✅ No "llm-research" unified plugin referenced
✅ Each plugin independently installable
✅ Templates and configs bundled within plugins
✅ `/plugin list` shows 3 separate plugins (when all installed)
✅ Selective installation/uninstallation works correctly
✅ Commands properly namespaced and functional

## Migration Verification

Verify v2.x → v3.x migration path:
```bash
# Check README.md has migration guide
grep -A 10 "Migration from v2.x" README.md
```

---

## Notes

- Tests should be run in isolated Claude Code session when possible
- Test directories can be cleaned up after verification: `rm -rf /tmp/test-*`
- All tests must pass before considering v3.0.0 ready for production
- Document any bugs or issues encountered during testing
