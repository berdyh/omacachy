#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}"
mkdir -p "$HOME/.local/bin"
ln -sf "$RUNTIME_DIR/bin"/* "$HOME/.local/bin/" 2>/dev/null || true

echo "Post-install complete. Ensure ~/.local/bin is in PATH."
