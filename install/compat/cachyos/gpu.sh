#!/usr/bin/env bash
set -euo pipefail

# Detect GPU vendor(s) and keep driver ownership with CachyOS chwd.
# Optional apply mode: OMACACHY_APPLY_CHWD=1

if ! command -v lspci >/dev/null 2>&1; then
  echo "lspci missing; cannot detect GPU topology." >&2
  exit 0
fi

pci_out="$(lspci -nn | grep -Ei 'vga|3d|display controller' || true)"
[ -n "$pci_out" ] || { echo "No display adapters detected."; exit 0; }

echo "Detected display adapters:"
echo "$pci_out"

has_nvidia=0
has_amd=0
has_intel=0

echo "$pci_out" | grep -Eiq 'nvidia' && has_nvidia=1 || true
echo "$pci_out" | grep -Eiq 'amd|advanced micro devices|ati' && has_amd=1 || true
echo "$pci_out" | grep -Eiq 'intel' && has_intel=1 || true

profile=""
if [ "$has_nvidia" -eq 1 ] && [ "$has_amd" -eq 1 -o "$has_intel" -eq 1 ]; then
  profile="hybrid"
elif [ "$has_nvidia" -eq 1 ]; then
  profile="nvidia"
elif [ "$has_amd" -eq 1 ]; then
  profile="amd"
elif [ "$has_intel" -eq 1 ]; then
  profile="intel"
else
  profile="unknown"
fi

echo "GPU profile classification: $profile"

if ! command -v chwd >/dev/null 2>&1; then
  echo "chwd not found; cannot perform CachyOS GPU flow." >&2
  exit 0
fi

if [ "${OMACACHY_APPLY_CHWD:-0}" != "1" ]; then
  echo "Dry-run only. To apply driver profile via chwd, set OMACACHY_APPLY_CHWD=1."
  exit 0
fi

case "$profile" in
  nvidia) chwd --force -i pci nvidia ;;
  amd|intel) chwd --force -i pci video-linux ;;
  hybrid) chwd --force -i pci hybrid-intel-nvidia-prime ;;
  *) echo "Unknown profile; skipping automatic chwd apply." ;;
esac

echo "If GPU stack changed, regenerate boot artifacts with: sudo limine-mkinitcpio"
