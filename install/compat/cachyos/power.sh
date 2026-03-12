#!/usr/bin/env bash
set -euo pipefail

mode="${1:-status}"

case "$mode" in
  status)
    powerprofilesctl get
    ;;
  waybar)
    profile="$(powerprofilesctl get)"
    printf '{"text":"%s","tooltip":"Power profile: %s"}\n' "$profile" "$profile"
    ;;
  *)
    echo "Usage: $(basename "$0") {status|waybar}" >&2
    exit 2
    ;;
esac
