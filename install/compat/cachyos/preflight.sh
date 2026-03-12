#!/usr/bin/env bash
set -euo pipefail

required=(git bash)
optional=(paru powerprofilesctl chwd limine-mkinitcpio)

for cmd in "${required[@]}"; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Missing required command: $cmd" >&2; exit 1; }
done

for cmd in "${optional[@]}"; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Warning: optional command not found: $cmd" >&2
  fi
done

if [ "$(id -u)" -eq 0 ]; then
  echo "Do not run preflight as root." >&2
  exit 1
fi

echo "Preflight OK"
