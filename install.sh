#!/bin/bash
# install.sh — sets up claude-conventional-commits on a new machine
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$REPO_DIR/scripts"
COMMANDS_DIR="${HOME}/.claude/commands"
COMMIT_MD_SRC="$REPO_DIR/commands/commit.md"
COMMIT_MD_DST="$COMMANDS_DIR/commit.md"

echo "Installing claude-conventional-commits from: $REPO_DIR"
echo ""

# 1. Install the Claude slash command
mkdir -p "$COMMANDS_DIR"
sed "s|SCRIPTS_PATH|$SCRIPTS_PATH|g" "$COMMIT_MD_SRC" > "$COMMIT_MD_DST"
echo "✓ Installed Claude slash command → $COMMIT_MD_DST"

# 2. Make scripts executable
chmod +x "$SCRIPTS_PATH"/*
echo "✓ Made scripts executable"

# 3. Optionally install git hooks globally
echo ""
read -rp "Install git hooks globally via core.hooksPath? (y/N): " response
if [[ "${response,,}" == "y" ]]; then
    HOOKS_PATH="$REPO_DIR/hooks"
    chmod +x "$HOOKS_PATH"/*
    git config --global core.hooksPath "$HOOKS_PATH"
    echo "✓ Set git core.hooksPath → $HOOKS_PATH"
    echo "  (all repos on this machine will use these hooks)"
fi

echo ""
echo "Done. Use /commit in Claude Code to commit with conventional commits."
echo ""
echo "Optional: add the scripts directory to your PATH for direct use:"
echo "  export PATH=\"$SCRIPTS_PATH:\$PATH\""
