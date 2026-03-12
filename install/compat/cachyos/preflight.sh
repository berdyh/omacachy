#!/usr/bin/env bash
set -euo pipefail

for cmd in git bash; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Missing required command: $cmd" >&2; exit 1; }
done

if [ "$(id -u)" -eq 0 ]; then
  echo "Do not run preflight as root." >&2
  exit 1
fi

echo "Preflight OK"
