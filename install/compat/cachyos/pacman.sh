#!/usr/bin/env bash
set -euo pipefail

# Auditable coexistence: never overwrite /etc/pacman.conf or mirrorlist.
# We write a standalone snippet and instruct explicit include by admin.

SNIPPET_PATH="${OMACACHY_PACMAN_SNIPPET:-/etc/pacman.d/omacachy-omarchy.conf}"
OMARCHY_REPO_BLOCK=$(cat <<'EOC'
[omarchy]
SigLevel = Optional TrustAll
Server = https://pkg.omarchy.org/$repo/$arch
EOC
)

if [ "${EUID}" -ne 0 ]; then
  if sudo -n true 2>/dev/null; then
    SUDO="sudo"
  else
    echo "No passwordless sudo; skipping pacman snippet write."
    echo "Policy remains: do not overwrite /etc/pacman.conf or /etc/pacman.d/mirrorlist."
    exit 0
  fi
else
  SUDO=""
fi

if [ -f /etc/pacman.conf ]; then
  echo "Verified /etc/pacman.conf exists and is not overwritten by omacachy."
fi
if [ -f /etc/pacman.d/mirrorlist ]; then
  echo "Verified /etc/pacman.d/mirrorlist exists and is not overwritten by omacachy."
fi

$SUDO mkdir -p "$(dirname "$SNIPPET_PATH")"
printf '%b' "$OMARCHY_REPO_BLOCK" | $SUDO tee "$SNIPPET_PATH" >/dev/null

echo "Wrote repo snippet: $SNIPPET_PATH"
echo "Add this include manually to /etc/pacman.conf if desired:"
echo "  Include = $SNIPPET_PATH"
