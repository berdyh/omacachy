#!/usr/bin/env bash
set -euo pipefail

# Thin overlay entrypoint: delegate to upstream detect routine when available.
UPSTREAM_ROOT="${UPSTREAM_ROOT:-../omarchy-upstream}"
exec "${UPSTREAM_ROOT}/install/compat/cachyos/detect.sh" "$@"
