# Upstream sync

Sync process:

1. fetch `berdyh/omarchy-upstream`
2. update runtime tree
3. reapply compatibility patches/overlays
4. run drift checks on high-risk files

High-risk files include:

- `install/preflight/guard.sh`
- `install/preflight/pacman.sh`
- `install/post-install/pacman.sh`
- `install/config/hardware/nvidia.sh`
- `install/login/*.sh`
- `bin/omarchy-update*`
- `config/uwsm/env`
- `config/hypr/bindings.conf`

Manual review is required before compatibility updates are promoted.
