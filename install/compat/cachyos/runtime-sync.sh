#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_DIR="${UPSTREAM_DIR:-}"
RUNTIME_DIR="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}"
STATE_DIR="${OMACACHY_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/omacachy}"
TMP_DIR="${TMPDIR:-/tmp}"
LOCK_FILE="$STATE_DIR/update.lock"
BACKUP_ROOT="$STATE_DIR/backups"
WORK_DIR="$TMP_DIR/omacachy-runtime-sync.$$"

PRESERVE_PATHS=(
  "local"
  "tmp"
  "logs"
  "config/local"
  "config/custom"
)

REGENERATE_PATHS=(
  "bin"
  "config"
  "themes"
)

BACKUP_DIR=""
ROLLBACK_DONE=0
SYNC_DONE=0
SWAP_COMPLETE=0
HAS_LOCK=0

cleanup() {
  if [ "$SWAP_COMPLETE" -eq 1 ]; then
    rm -rf "${WORK_DIR:?}"
  fi
}

rollback() {
  [ "$SYNC_DONE" -eq 1 ] && return 0
  [ "$ROLLBACK_DONE" -eq 1 ] && return 0
  ROLLBACK_DONE=1

  if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
    rm -rf "${RUNTIME_DIR:?}"
    cp -a "$BACKUP_DIR" "$RUNTIME_DIR"
    echo "Rolled back runtime to checkpoint: $BACKUP_DIR" >&2
  fi
}

on_exit() {
  rollback
  if [ "$HAS_LOCK" -eq 1 ]; then
    rmdir "$LOCK_FILE" >/dev/null 2>&1 || true
  fi
  cleanup
}
trap on_exit EXIT

mkdir -p "$STATE_DIR" "$BACKUP_ROOT"

if [ -z "$UPSTREAM_DIR" ] || [ ! -d "$UPSTREAM_DIR/.git" ]; then
  echo "UPSTREAM_DIR must point to a cloned omarchy-upstream git repository." >&2
  exit 1
fi

if mkdir "$LOCK_FILE" 2>/dev/null; then
  HAS_LOCK=1
else
  echo "omacachy runtime sync lock is already held: $LOCK_FILE" >&2
  echo "If no update is running, remove it manually and retry." >&2
  exit 1
fi

mkdir -p "$WORK_DIR"
NEW_TREE="$WORK_DIR/new"
mkdir -p "$NEW_TREE"
cp -a "$UPSTREAM_DIR"/. "$NEW_TREE"/

if [ -d "$RUNTIME_DIR/.git" ]; then
  BACKUP_ID="$(date +%Y%m%d-%H%M%S)"
  BACKUP_DIR="$BACKUP_ROOT/$BACKUP_ID"
  cp -a "$RUNTIME_DIR" "$BACKUP_DIR"
  echo "Created backup checkpoint: $BACKUP_DIR"
fi

for preserve in "${PRESERVE_PATHS[@]}"; do
  src="$RUNTIME_DIR/$preserve"
  dst="$NEW_TREE/$preserve"
  if [ -e "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    rm -rf "${dst:?}"
    cp -a "$src" "$dst"
    echo "Preserved runtime path: $preserve"
  fi
done

for regen in "${REGENERATE_PATHS[@]}"; do
  rm -rf "${RUNTIME_DIR:?}/$regen"
  echo "Regenerated runtime path: $regen"
done

rm -rf "${RUNTIME_DIR:?}"
mkdir -p "$(dirname "$RUNTIME_DIR")"

if ! mv "$NEW_TREE" "$RUNTIME_DIR"; then
  echo "Failed to move new runtime tree into place." >&2
  exit 1
fi

SYNC_DONE=1
SWAP_COMPLETE=1

echo "Runtime sync completed safely at: $RUNTIME_DIR"
if [ -n "$BACKUP_DIR" ]; then
  echo "Rollback checkpoint retained at: $BACKUP_DIR"
fi
