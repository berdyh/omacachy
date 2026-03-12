#!/usr/bin/env bash
set -euo pipefail

echo "Limine-safe mode: not overwriting /boot/limine.conf from omacachy."
if [ -f /etc/default/limine ]; then
  echo "CachyOS boot config present at /etc/default/limine"
fi
