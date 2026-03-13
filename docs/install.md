# Install

## Prerequisites

- Existing CachyOS installation
- User account with sudo access
- git, bash
- required: paru (canonical AUR helper), git, bash
- recommended: chwd, powerprofilesctl, limine-mkinitcpio

## Flow

1. `bin/omacachy-install`
2. detect CachyOS and verify non-root execution
3. sync `berdyh/omarchy-upstream`
4. populate `~/.local/share/omarchy`
5. apply local patches/overlays
6. run CachyOS compatibility hooks

## Optional apply toggles

- `OMACACHY_APPLY_CHWD=1` to apply detected GPU profile through `chwd`
- `OMACACHY_APPLY_LIMINE=1` to run `limine-mkinitcpio`
- `OMACACHY_ENABLE_SDDM=1` to enable `sddm.service`

By default these run in safe dry-run/reporting mode.

## What changes

- Omarchy runtime and userland configs are installed
- session/frontend integration hooks are prepared
- runtime helper binaries are linked into `~/.local/bin`

## What does not change

- no ISO/USB flow
- no takeover of `/etc/pacman.conf` or mirrorlist
- no boot takeover of `/boot/limine.conf`
- no GPU backend takeover
- no swap policy override


## Post-install hardening checks

```bash
install/compat/cachyos/validate-runtime.sh post-install
```

This fails loudly if key launcher/menu/terminal helpers, PATH wiring, UWSM env, or SDDM session visibility are broken.
