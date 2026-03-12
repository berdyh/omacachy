#!/usr/bin/env bash
set -euo pipefail

# Reads package names from stdin and emits safe subset for CachyOS ownership policy.
# Drops packages tied to bootloader/GPU backend ownership managed by CachyOS.
for pkg in "$@"; do
  case "$pkg" in
    grub|systemd-boot*|nvidia*|xf86-video-nouveau|snapper)
      ;;
    *) printf '%s\n' "$pkg" ;;
  esac
done
