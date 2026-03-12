# CachyOS compatibility

Adjusted/disabled from upstream Omarchy behavior:

- no pacman.conf or mirrorlist replacement
- no Limine takeover/snapper ownership takeover
- no direct Omarchy ownership of GPU driver family
- no swap policy takeover (keep CachyOS ZRAM defaults)
- AUR helper standardized on `paru`

Preserved from Omarchy where safe:

- frontend UX stack
- keybinding/session workflow
- migration model
- runtime tree structure in `~/.local/share/omarchy`
