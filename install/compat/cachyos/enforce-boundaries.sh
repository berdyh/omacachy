#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="${OMARCHY_RUNTIME_DIR:-$HOME/.local/share/omarchy}"
FILTER_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/package-filter.sh"

[ -d "$RUNTIME_DIR" ] || { echo "Runtime missing: $RUNTIME_DIR" >&2; exit 1; }
command -v rg >/dev/null 2>&1 || { echo "rg (ripgrep) is required for boundary enforcement" >&2; exit 1; }

# Guard against backend ownership takeover in runtime scripts.
forbidden_patterns=(
  '/etc/pacman.conf'
  '/etc/pacman.d/mirrorlist'
  'grub-install'
  'bootctl install'
  'mkinitcpio -P'
  'nvidia-utils'
)

while IFS= read -r file; do
  for pattern in "${forbidden_patterns[@]}"; do
    if rg -n --fixed-strings "$pattern" "$file" >/dev/null 2>&1; then
      echo "Boundary violation candidate: $file contains '$pattern'" >&2
      exit 1
    fi
  done
done < <(find "$RUNTIME_DIR" -maxdepth 3 -type f \( -name '*.sh' -o -name 'omarchy-*' \))

# Enforce package filter on any declared package lists if present.
for list_file in "$RUNTIME_DIR/install/packages/pacman.txt" "$RUNTIME_DIR/install/packages/aur.txt"; do
  [ -f "$list_file" ] || continue
  tmp="$(mktemp)"
  "$FILTER_SCRIPT" < "$list_file" > "$tmp"
  if ! cmp -s "$list_file" "$tmp"; then
    cp "$tmp" "$list_file"
    echo "Filtered backend-owned packages in: $list_file"
  fi
  rm -f "$tmp"
done

echo "Boundary enforcement checks passed."
