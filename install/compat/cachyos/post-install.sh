#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}"
LOCAL_BIN="$HOME/.local/bin"
ENV_DIR="$HOME/.config/environment.d"
ENV_FILE="$ENV_DIR/omacachy.conf"

mkdir -p "$LOCAL_BIN" "$ENV_DIR"

if [ -d "$RUNTIME_DIR/bin" ]; then
  find "$RUNTIME_DIR/bin" -maxdepth 1 -type f -executable -print0 |
    while IFS= read -r -d '' src; do
      ln -sf "$src" "$LOCAL_BIN/$(basename "$src")"
    done
fi

cat > "$ENV_FILE" <<EOC
OMARCHY_RUNTIME_DIR=$RUNTIME_DIR
PATH=$LOCAL_BIN:$RUNTIME_DIR/bin:\$PATH
EOC

echo "Post-install complete."
echo "Environment file written: $ENV_FILE"
