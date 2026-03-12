#!/usr/bin/env bash
set -euo pipefail

# Thin overlay hook. Add CachyOS-specific overrides here if needed, then delegate.
script_name="$(basename "$0")"
UPSTREAM_ROOT="${UPSTREAM_ROOT:-../omarchy-upstream}"
exec "${UPSTREAM_ROOT}/install/compat/cachyos/${script_name}" "$@"
