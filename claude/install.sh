#!/usr/bin/env bash
# Sets up ~/.claude config from dotfiles.
# Run from anywhere: bash ~/workspace/dotfiles/claude/install.sh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

echo "Setting up Claude Code config..."

# Backup existing settings.json if it exists and isn't a symlink
if [ -f "$CLAUDE_DIR/settings.json" ] && [ ! -L "$CLAUDE_DIR/settings.json" ]; then
    cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
    echo "  Backed up settings.json → settings.json.bak"
fi

# Symlink settings.json
ln -sf "$DOTFILES_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "  Linked settings.json"

# Ensure hooks directory exists and symlink hook files
mkdir -p "$CLAUDE_DIR/hooks"
for hook in "$DOTFILES_DIR/hooks/"*; do
    fname="$(basename "$hook")"
    if [ ! -L "$CLAUDE_DIR/hooks/$fname" ]; then
        ln -sf "$hook" "$CLAUDE_DIR/hooks/$fname"
        echo "  Linked hooks/$fname"
    fi
done

# Install Claude Code plugins (requires `claude` CLI in PATH)
if command -v claude &>/dev/null; then
    echo ""
    echo "Installing plugins..."
    claude plugins install caveman@caveman || echo "  caveman already installed or failed"
    claude plugins install superpowers@claude-plugins-official || echo "  superpowers already installed or failed"
    claude plugins install frontend-design@claude-plugins-official || echo "  frontend-design already installed or failed"
else
    echo ""
    echo "claude CLI not found — install plugins manually:"
    echo "  claude plugins install caveman@caveman"
    echo "  claude plugins install superpowers@claude-plugins-official"
    echo "  claude plugins install frontend-design@claude-plugins-official"
fi

echo ""
echo "Done. settings.json uses mise shim node path (~/.local/share/mise/shims/node)."
echo "If not using mise, update the node path in settings.json or run:"
echo "  sed -i \"s|\\\$HOME/.local/share/mise/shims/node|\$(which node)|g\" $CLAUDE_DIR/settings.json"
