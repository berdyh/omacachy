#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}"
LOCAL_BIN="$HOME/.local/bin"
mode="${1:-full}"

fail() {
  echo "VALIDATION ERROR: $*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "missing required command in PATH: $1"
}

[ -d "$RUNTIME_DIR" ] || fail "runtime directory missing: $RUNTIME_DIR"
[ -d "$RUNTIME_DIR/bin" ] || fail "runtime bin missing: $RUNTIME_DIR/bin"
command -v rg >/dev/null 2>&1 || fail "rg (ripgrep) is required for runtime validation"

if [ "$mode" = "full" ]; then
  case ":$PATH:" in
    *":$LOCAL_BIN:"*) ;;
    *) fail "PATH is missing $LOCAL_BIN; run post-install/session env refresh" ;;
  esac

  case ":$PATH:" in
    *":$RUNTIME_DIR/bin:"*) ;;
    *) fail "PATH is missing $RUNTIME_DIR/bin; session env not coherent" ;;
  esac
else
  case ":$PATH:" in
    *":$LOCAL_BIN:"*) ;;
    *) echo "VALIDATION WARNING: PATH is missing $LOCAL_BIN; expected after next login" >&2 ;;
  esac

  case ":$PATH:" in
    *":$RUNTIME_DIR/bin:"*) ;;
    *) echo "VALIDATION WARNING: PATH is missing $RUNTIME_DIR/bin; expected after next login" >&2 ;;
  esac
fi

export PATH="$LOCAL_BIN:$RUNTIME_DIR/bin:$PATH"

for helper in omarchy-launcher omarchy-menu omarchy-terminal; do
  require_cmd "$helper"
  target="$(command -v "$helper")"
  [ -x "$target" ] || fail "helper not executable: $helper -> $target"
done

if ! command -v walker >/dev/null 2>&1 && ! command -v wofi >/dev/null 2>&1 && ! command -v rofi >/dev/null 2>&1; then
  fail "no launcher backend found (walker/wofi/rofi)"
fi

if ! command -v xdg-open >/dev/null 2>&1; then
  fail "xdg-open is required for browser/default-launcher handoff"
fi

if ! command -v kitty >/dev/null 2>&1 && ! command -v foot >/dev/null 2>&1 && ! command -v alacritty >/dev/null 2>&1 && ! command -v wezterm >/dev/null 2>&1; then
  fail "no supported terminal backend found (kitty/foot/alacritty/wezterm)"
fi

bindings_file="$RUNTIME_DIR/config/hypr/bindings.conf"
if [ -f "$bindings_file" ]; then
  rg -n "SUPER.*Return" "$bindings_file" >/dev/null || fail "missing required keybinding: SUPER+Return in $bindings_file"
  rg -n "SUPER.*space" "$bindings_file" >/dev/null || fail "missing required keybinding: SUPER+space in $bindings_file"
  rg -n "SUPER.*ALT.*space" "$bindings_file" >/dev/null || fail "missing required keybinding: SUPER+ALT+space in $bindings_file"
else
  fail "bindings file missing: $bindings_file"
fi

if [ "$mode" = "post-update" ] || [ "$mode" = "full" ]; then
  uwsm_env="$RUNTIME_DIR/config/uwsm/env"
  [ -d "$uwsm_env" ] || fail "UWSM env directory missing: $uwsm_env"
fi

"$(dirname "$0")/sddm.sh" validate

echo "Runtime/session validation passed ($mode)."
