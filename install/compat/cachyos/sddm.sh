#!/usr/bin/env bash
set -euo pipefail

mode="${1:-status}"

if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available; skipping SDDM checks."
  exit 0
fi

check_session_entries() {
  local found=0
  for dir in /usr/share/wayland-sessions /usr/local/share/wayland-sessions; do
    [ -d "$dir" ] || continue
    if command -v rg >/dev/null 2>&1; then
      if find "$dir" -maxdepth 1 -type f -name '*.desktop' | rg -q '.'; then
        echo "Found Wayland sessions in $dir"
        found=1
      fi
    elif find "$dir" -maxdepth 1 -type f -name '*.desktop' | grep -q '.'; then
      echo "Found Wayland sessions in $dir"
      found=1
    fi
  done
  [ "$found" -eq 1 ] || {
    echo "No wayland session .desktop entries found for SDDM." >&2
    return 1
  }
}

sddm_present=0
if systemctl list-unit-files | grep -q '^sddm.service'; then
  sddm_present=1
  echo "SDDM service detected."
fi

if [ "$sddm_present" -eq 0 ]; then
  if [ "${OMACACHY_ALLOW_NO_SDDM:-0}" = "1" ]; then
    echo "SDDM service not found; continuing due to OMACACHY_ALLOW_NO_SDDM=1" >&2
  elif [ "${OMACACHY_REQUIRE_SDDM:-0}" = "1" ]; then
    echo "SDDM service not found; failing due to OMACACHY_REQUIRE_SDDM=1" >&2
    exit 1
  else
    echo "SDDM service not found; continuing in compatibility mode. Set OMACACHY_REQUIRE_SDDM=1 to enforce." >&2
  fi
fi

case "$mode" in
  validate)
    if [ "$sddm_present" -eq 0 ]; then
      echo "Skipping SDDM validate checks because sddm.service is unavailable." >&2
    else
      check_session_entries
      if systemctl is-enabled sddm.service >/dev/null 2>&1; then
        echo "sddm.service is enabled."
      else
        echo "sddm.service is not enabled; enable if this host should boot to SDDM." >&2
      fi
    fi
    ;;
  status)
    if [ "$sddm_present" -eq 0 ]; then
      echo "Skipping SDDM status checks because sddm.service is unavailable." >&2
    else
      check_session_entries || true
    fi
    ;;
  enable)
    if [ "$sddm_present" -eq 0 ]; then
      echo "SDDM service not found; cannot enable sddm.service." >&2
      exit 1
    fi
    if [ "$EUID" -eq 0 ]; then
      systemctl enable sddm.service
    else
      sudo systemctl enable sddm.service
    fi
    echo "Enabled sddm.service"
    ;;
  *)
    echo "Usage: $(basename "$0") {status|validate|enable}" >&2
    exit 2
    ;;
esac

echo "No login takeover performed (SDDM-first policy)."
