#!/usr/bin/env bash
set -euo pipefail

mode="${1:-status}"

if ! command -v powerprofilesctl >/dev/null 2>&1; then
  echo "powerprofilesctl is not installed; power profile UI bridge is unavailable on this system." >&2
  exit 0
fi

case "$mode" in
  status)
    powerprofilesctl get
    ;;
  set)
    profile="${2:-}"
    case "$profile" in
      power-saver|balanced|performance) ;;
      *)
        echo "Usage: $(basename "$0") set {power-saver|balanced|performance}" >&2
        exit 2
        ;;
    esac
    powerprofilesctl set "$profile"
    powerprofilesctl get
    ;;
  waybar)
    profile="$(powerprofilesctl get)"
    printf '{"text":"%s","tooltip":"Power profile: %s"}\n' "$profile" "$profile"
    ;;
  *)
    echo "Usage: $(basename "$0") {status|set|waybar}" >&2
    exit 2
    ;;
esac
