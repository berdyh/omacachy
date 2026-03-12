#!/usr/bin/env bash
set -euo pipefail

# Filter package operations to preserve CachyOS backend ownership.
# Accepts package names either as CLI args or via stdin.

filter_one() {
  local pkg="$1"
  case "$pkg" in
    # Boot ownership remains CachyOS.
    grub|grub-*|systemd-boot*|refind*|snapper|snap-pac)
      return 1
      ;;
    # GPU driver stack ownership remains CachyOS/chwd.
    nvidia|nvidia-*|lib32-nvidia*|xf86-video-nouveau|mesa-vdpau)
      return 1
      ;;
    # swap backend policy remains CachyOS defaults.
    zram-generator|zram-generator-defaults)
      return 1
      ;;
    *)
      return 0
      ;;
  esac
}

emit_if_allowed() {
  local pkg="$1"
  [ -n "$pkg" ] || return 0
  if filter_one "$pkg"; then
    printf '%s\n' "$pkg"
  fi
}

if [ "$#" -gt 0 ]; then
  for pkg in "$@"; do
    emit_if_allowed "$pkg"
  done
else
  while IFS= read -r pkg; do
    emit_if_allowed "$pkg"
  done
fi
