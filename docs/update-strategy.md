# Update strategy

`bin/omacachy-update` preserves Omarchy update spirit with CachyOS guardrails:

- sync from `berdyh/omarchy-upstream`
- refresh runtime tree at `~/.local/share/omarchy`
- reapply overlays/patches
- run Omarchy migrations when available
- run system package update via `pacman -Syu`
- run AUR update via canonical helper `paru`

Pacman coexistence rules still apply: no replacement of `/etc/pacman.conf` or `/etc/pacman.d/mirrorlist`.

Future CI can flag upstream drift and require compatibility review before downstream promotion.
