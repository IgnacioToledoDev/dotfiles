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

# Backup existing CLAUDE.md if it exists and isn't a symlink
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.bak"
    echo "  Backed up CLAUDE.md → CLAUDE.md.bak"
fi

# Symlink CLAUDE.md (includes gentle-ai SDD/ODD orchestrator instructions)
ln -sf "$DOTFILES_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  Linked CLAUDE.md"

# Ensure hooks directory exists and symlink hook files
mkdir -p "$CLAUDE_DIR/hooks"
for hook in "$DOTFILES_DIR/hooks/"*; do
    fname="$(basename "$hook")"
    if [ ! -L "$CLAUDE_DIR/hooks/$fname" ]; then
        ln -sf "$hook" "$CLAUDE_DIR/hooks/$fname"
        echo "  Linked hooks/$fname"
    fi
done

PLUGINS=(
    "caveman@caveman"
    "superpowers@claude-plugins-official"
    "frontend-design@claude-plugins-official"
    "atlassian@claude-plugins-official"
    "code-review@claude-plugins-official"
    "context7@claude-plugins-official"
    "engram@engram"
    "figma@claude-plugins-official"
    "lua-lsp@claude-plugins-official"
    "php-lsp@claude-plugins-official"
    "redis-development@claude-plugins-official"
    "rust-analyzer-lsp@claude-plugins-official"
    "sentry@claude-plugins-official"
    "shopify-ai-toolkit@claude-plugins-official"
    "skill-creator@claude-plugins-official"
    "sonarqube@claude-plugins-official"
    "stripe@claude-plugins-official"
)

# Install Claude Code plugins (requires `claude` CLI in PATH)
if command -v claude &>/dev/null; then
    echo ""
    echo "Installing plugins..."
    for plugin in "${PLUGINS[@]}"; do
        claude plugins install "$plugin" || echo "  $plugin already installed or failed"
    done
else
    echo ""
    echo "claude CLI not found — install plugins manually:"
    for plugin in "${PLUGINS[@]}"; do
        echo "  claude plugins install $plugin"
    done
fi

# gentle-ai CLI powers the SDD/ODD orchestrator hooks wired in settings.json
# (sdd-preflight-hook, review stop-hook, telemetry, skill-registry refresh).
if ! command -v gentle-ai &>/dev/null; then
    echo ""
    echo "WARNING: gentle-ai CLI not found in PATH."
    echo "  settings.json hooks call it (PreToolUse/SessionStart/Stop/SubagentStop/UserPromptSubmit)."
    echo "  See https://github.com/Gentleman-Programming for install instructions."
fi
if ! command -v codegraph &>/dev/null; then
    echo ""
    echo "WARNING: codegraph CLI not found in PATH (used by the UserPromptSubmit hook)."
fi

echo ""
echo "Done. settings.json uses mise shim node path (~/.local/share/mise/shims/node)."
echo "If not using mise, update the node path in settings.json or run:"
echo "  sed -i \"s|\\\$HOME/.local/share/mise/shims/node|\$(which node)|g\" $CLAUDE_DIR/settings.json"
