#!/usr/bin/env bash
set -euo pipefail

# Thin overlay hook: resolve upstream relative to this file, then delegate.
script_name="$(basename "$0")"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/../../.." && pwd)"
UPSTREAM_ROOT="${UPSTREAM_ROOT:-${repo_root}/../omarchy-upstream}"

exec "${UPSTREAM_ROOT}/install/compat/cachyos/${script_name}" "$@"
