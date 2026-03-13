#!/usr/bin/env bash
set -euo pipefail

aur_helper() {
  if command -v paru >/dev/null 2>&1; then
    printf '%s\n' paru
    return 0
  fi
  echo "paru is required as canonical AUR helper" >&2
  return 1
}

aur_install() {
  local helper
  helper="$(aur_helper)"
  "$helper" -S --needed --noconfirm "$@"
}

aur_update() {
  local helper
  helper="$(aur_helper)"
  "$helper" -Syu --noconfirm
}
