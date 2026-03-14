# Upstream sync

Sync process:

1. fetch `berdyh/omarchy-upstream`
2. create candidate runtime tree
3. preserve user customization paths
4. regenerate upstream-owned paths
5. checkpoint backup + lock-protected switch
6. reapply compatibility patches/overlays deterministically
7. run boundary and runtime/session validation checks

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
