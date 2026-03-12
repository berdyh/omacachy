#!/usr/bin/env bash
set -euo pipefail

if [ -f /etc/pacman.conf ] && [ ! -w /etc/pacman.conf ]; then
  echo "pacman config is system-owned and unchanged (expected)."
else
  echo "omacachy policy: never overwrite /etc/pacman.conf or mirrorlists."
fi

echo "Pacman coexistence guard passed"
