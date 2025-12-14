#!/bin/bash

set -euo pipefail

VERSION="2.0.0"
REPO_ROOT=$(cd "$(dirname "$0")" && pwd)
TARGET_DIR=${TARGET:-}
SKILL_NAMES=(research-memory project-management skill-squared)
TOTAL_COMMANDS=18

copy_dir_contents() {
  local src="$1"
  local dest="$2"
  mkdir -p "$dest"
  if [ -d "$src" ]; then
    cp -R "$src/." "$dest/"
  fi
}

copy_commands() {
  for skill in "${SKILL_NAMES[@]}"; do
    local src="$REPO_ROOT/.claude/commands/$skill"
    local dest="$1/.claude/commands/$skill"
    mkdir -p "$dest"
    cp "$src"/*.md "$dest/"
  done
}

if [ -n "$TARGET_DIR" ]; then
  echo "Installing LLM-Research-Marketplace v$VERSION into $TARGET_DIR"
  mkdir -p "$TARGET_DIR/.claude/commands"
  mkdir -p "$TARGET_DIR/.claude-plugin"
  mkdir -p "$TARGET_DIR/skills"
  mkdir -p "$TARGET_DIR/templates"
  mkdir -p "$TARGET_DIR/config"
  mkdir -p "$TARGET_DIR/docs"

  copy_commands "$TARGET_DIR"
  copy_dir_contents "$REPO_ROOT/.claude-plugin" "$TARGET_DIR/.claude-plugin"
  copy_dir_contents "$REPO_ROOT/skills" "$TARGET_DIR/skills"
  copy_dir_contents "$REPO_ROOT/templates/project" "$TARGET_DIR/templates/project"
  copy_dir_contents "$REPO_ROOT/templates/skill" "$TARGET_DIR/templates/skill"
  cp "$REPO_ROOT/config/marketplace-config.json" "$TARGET_DIR/config/"
  copy_dir_contents "$REPO_ROOT/docs" "$TARGET_DIR/docs"

  echo "✓ Installed 3 skills and $TOTAL_COMMANDS commands"
  echo "Next: /plugin marketplace add syfyufei/llm-research-marketplace && /plugin install llm-research@LLM-Research-Marketplace"
  exit 0
fi

if ! command -v claude >/dev/null 2>&1; then
  echo "Error: claude CLI not found in PATH. Install Claude Code CLI or set TARGET to deploy manually." >&2
  exit 1
fi

if [ -f "$REPO_ROOT/.claude-plugin/marketplace.json" ] && [ -d "$REPO_ROOT/skills" ]; then
  echo "Installing LLM Research Marketplace v$VERSION from local checkout..."
  claude plugin marketplace add "$REPO_ROOT"
  claude plugin install llm-research@LLM-Research-Marketplace
else
  echo "Cloning llm-research-marketplace from GitHub..."
  TEMP_DIR=$(mktemp -d)
  git clone https://github.com/syfyufei/llm-research-marketplace.git "$TEMP_DIR/llm-research-marketplace"
  claude plugin marketplace add "$TEMP_DIR/llm-research-marketplace"
  claude plugin install llm-research@LLM-Research-Marketplace
  rm -rf "$TEMP_DIR"
fi

cat <<MSG

✓ Installed LLM Research Marketplace v$VERSION
✓ Registered 3 skills (research-memory, project-management, skill-squared)
✓ Registered $TOTAL_COMMANDS commands

Verify inside Claude Code with:
  /plugin list
  /help
MSG
