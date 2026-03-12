#!/usr/bin/env bash
set -euo pipefail

if command -v chwd >/dev/null 2>&1; then
  echo "GPU ownership remains with CachyOS chwd."
else
  echo "Warning: chwd not found; cannot verify CachyOS GPU tooling." >&2
fi
