#!/usr/bin/env bash
set -euo pipefail

# Keep SDDM session model; optionally ensure service enabled.
if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available; skipping SDDM checks."
  exit 0
fi

if systemctl list-unit-files | grep -q '^sddm.service'; then
  echo "SDDM service detected."
else
  echo "SDDM service not found; install/configure SDDM before switching sessions." >&2
fi

if [ "${OMACACHY_ENABLE_SDDM:-0}" = "1" ]; then
  if [ "$EUID" -eq 0 ]; then
    systemctl enable sddm.service
  else
    sudo systemctl enable sddm.service
  fi
  echo "Enabled sddm.service"
fi

echo "No login takeover performed (SDDM-first policy)."
