#!/usr/bin/env bash
set -euo pipefail

if [ ! -f /etc/os-release ]; then
  echo "Cannot detect OS: /etc/os-release missing" >&2
  exit 1
fi

if ! grep -Eiq 'cachyos' /etc/os-release; then
  echo "omacachy supports CachyOS only." >&2
  exit 1
fi

echo "Detected CachyOS"
