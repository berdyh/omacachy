# Sources

## Source-of-truth

1. https://github.com/basecamp/omarchy/blob/dev/install.sh — install entrypoint
2. https://github.com/basecamp/omarchy/blob/dev/install/preflight/guard.sh — guard assumptions
3. https://github.com/basecamp/omarchy/blob/dev/install/preflight/pacman.sh — preflight pacman takeover behavior
4. https://github.com/basecamp/omarchy/blob/dev/install/post-install/pacman.sh — post-install pacman takeover behavior
5. https://github.com/basecamp/omarchy/blob/dev/install/config/config.sh — config copy logic
6. https://github.com/basecamp/omarchy/blob/dev/install/login/sddm.sh — SDDM integration
7. https://github.com/basecamp/omarchy/blob/dev/install/login/limine-snapper.sh — Limine/Snapper takeover behavior
8. https://github.com/basecamp/omarchy/blob/dev/install/config/hardware/nvidia.sh — NVIDIA logic
9. https://github.com/basecamp/omarchy/blob/dev/install/config/hardware/intel.sh — Intel logic
10. Update flow:
   - https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-update
   - https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-update-git
   - https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-update-perform
   - https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-update-system-pkgs
   - https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-update-aur-pkgs
11. https://github.com/basecamp/omarchy/blob/dev/bin/omarchy-migrate — migration model
12. https://github.com/basecamp/omarchy/blob/dev/config/uwsm/env — UWSM env
13. https://github.com/basecamp/omarchy/blob/dev/config/hypr/bindings.conf — bindings behavior
14. https://wiki.cachyos.org/configuration/boot_manager_configuration/ — Limine ownership behavior
15. https://wiki.cachyos.org/configuration/general_system_tweaks/ — system/power context
16. https://wiki.cachyos.org/features/chwd/gpu_migration/ — GPU migration flow

## Reference-only prior art

17. https://github.com/mroboff/omarchy-on-cachyos/blob/main/README.md
18. https://github.com/mroboff/omarchy-on-cachyos/blob/main/bin/install-omarchy-on-cachyos.sh

Items 17–18 are references only; 1–16 are authority.
