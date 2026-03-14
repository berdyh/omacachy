#!/usr/bin/env bash
set -euo pipefail

# Limine-safe behavior. No /boot/limine.conf takeover.
# Persistent changes belong in /etc/default/limine, then limine-mkinitcpio.

echo "Limine-safe mode active: omacachy does not overwrite /boot/limine.conf."

if [ -f /etc/default/limine ]; then
  echo "Found /etc/default/limine (CachyOS-owned persistence point)."
else
  echo "Warning: /etc/default/limine not found." >&2
fi

runtime_install_dir="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}/install"
if command -v rg >/dev/null 2>&1; then
  if rg -n --fixed-strings '/boot/limine.conf' "$runtime_install_dir" 2>/dev/null; then
    echo "Warning: runtime references /boot/limine.conf directly; omacachy will not execute takeover paths." >&2
  fi
elif [ -d "$runtime_install_dir" ] && grep -R -n -F '/boot/limine.conf' "$runtime_install_dir" >/dev/null 2>&1; then
  echo "Warning: runtime references /boot/limine.conf directly; omacachy will not execute takeover paths." >&2
fi

if [ "${OMACACHY_APPLY_LIMINE:-0}" != "1" ]; then
  echo "Dry-run only. Set OMACACHY_APPLY_LIMINE=1 to run limine-mkinitcpio."
  exit 0
fi

if command -v limine-mkinitcpio >/dev/null 2>&1; then
  if [ "$EUID" -eq 0 ]; then
    limine-mkinitcpio
  else
    sudo limine-mkinitcpio
  fi
  echo "limine-mkinitcpio executed."
else
  echo "limine-mkinitcpio not found; cannot apply boot regeneration." >&2
  exit 1
fi
