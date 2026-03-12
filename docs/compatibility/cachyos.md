# CachyOS compatibility

Adjusted/disabled from upstream Omarchy behavior:

- no pacman.conf or mirrorlist replacement
- no Limine takeover/snapper ownership takeover
- no direct Omarchy ownership of GPU driver package families
- no swap policy takeover (keep CachyOS ZRAM defaults)
- AUR helper standardized on `paru`

Implemented compatibility hooks:

- `install/compat/cachyos/pacman.sh`: writes an auditable standalone repo snippet (`/etc/pacman.d/omacachy-omarchy.conf`) and never edits `pacman.conf`/mirrorlist directly.
- `install/compat/cachyos/gpu.sh`: detects GPU topology (NVIDIA/AMD/Intel, plus `hybrid-intel-nvidia` and `hybrid-amd-nvidia`), keeps `chwd` as authority, optional apply with `OMACACHY_APPLY_CHWD=1`.
- `install/compat/cachyos/boot.sh`: Limine-safe, optional `limine-mkinitcpio` run with `OMACACHY_APPLY_LIMINE=1`.
- `install/compat/cachyos/sddm.sh`: preserves SDDM model, optional enable with `OMACACHY_ENABLE_SDDM=1`.
- `install/compat/cachyos/post-install.sh`: links runtime executables into `~/.local/bin` and writes `~/.config/environment.d/omacachy.conf` for runtime/PATH resolution.

Preserved from Omarchy where safe:

- frontend UX stack
- keybinding/session workflow
- migration model
- runtime tree structure in `~/.local/share/omarchy`
