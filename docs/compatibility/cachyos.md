# CachyOS compatibility

Adjusted/disabled from upstream Omarchy behavior:

- no pacman.conf or mirrorlist replacement
- no Limine takeover/snapper ownership takeover
- no direct Omarchy ownership of GPU driver package families
- no swap policy takeover (keep CachyOS ZRAM defaults)
- AUR helper standardized on `paru` (required)

Implemented compatibility hooks:

- `install/compat/cachyos/pacman.sh`: writes an auditable standalone repo snippet (`/etc/pacman.d/omacachy-omarchy.conf`) and never edits `pacman.conf`/mirrorlist directly.
- `install/compat/cachyos/gpu.sh`: detects GPU topology (NVIDIA/AMD/Intel, plus `hybrid-intel-nvidia` and `hybrid-amd-nvidia`), keeps `chwd` as authority, optional apply with `OMACACHY_APPLY_CHWD=1`.
- `install/compat/cachyos/boot.sh`: Limine-safe, only supports persistence through `/etc/default/limine` + `limine-mkinitcpio`, optional apply with `OMACACHY_APPLY_LIMINE=1`.
- `install/compat/cachyos/sddm.sh`: validates SDDM presence and session entries for Wayland desktop visibility.
- `install/compat/cachyos/post-install.sh`: links runtime executables into `~/.local/bin` and writes `~/.config/environment.d/omacachy.conf`.
- `install/compat/cachyos/validate-runtime.sh`: validates PATH, helper resolution, launcher/menu/terminal/browser readiness, keybinding file presence, and session env coherence.
- `install/compat/cachyos/enforce-boundaries.sh`: actively blocks backend ownership takeovers and filters package manifests through `package-filter.sh`.

Concrete compatibility payload in overlays:

- `install/overlays/bin/omarchy-launcher`
- `install/overlays/bin/omarchy-menu`
- `install/overlays/bin/omarchy-terminal`
- `install/overlays/bin/omarchy-browser`
- `install/overlays/config/uwsm/env/90-omacachy-path.conf`

These wrappers harden command resolution drift for launcher/menu/terminal/browser paths while preserving upstream ownership.

Non-SDDM compatibility/testing override:

- `OMACACHY_ALLOW_NO_SDDM=1` allows validation to continue when SDDM is unavailable.
