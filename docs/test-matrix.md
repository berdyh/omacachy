# Test matrix

## Supported assumptions

- CachyOS base already installed
- SDDM session path
- Limine boot ownership remains CachyOS
- runtime path `~/.local/share/omarchy`

## Smoke tests

- installer rejects non-CachyOS
- installer rejects root execution
- upstream sync creates checkpoint + lock-guarded runtime replacement
- update path runs migrations when present
- runtime validation checks:
  - key helpers (`omarchy-launcher`, `omarchy-menu`, `omarchy-terminal`)
  - launcher backend availability (`walker`/`wofi`/`rofi`)
  - terminal backend availability (`kitty`/`foot`/`alacritty`/`wezterm`)
  - browser handoff (`xdg-open`)
  - keybinding file checks for `SUPER+Return`, `SUPER+space`, `SUPER+ALT+space`
  - UWSM env visibility and SDDM session entries

## Failure triage

- patch apply conflicts: rerun `bin/omacachy-apply-patches` and inspect failing patch
- sync failures: restore from `~/.local/state/omacachy/backups/<timestamp>`
- session/PATH failures: rerun `install/compat/cachyos/post-install.sh` then `install/compat/cachyos/validate-runtime.sh`
- missing helper commands: install required launcher/terminal dependencies and rerun validation
- broken menu/launcher/bindings: verify `~/.local/share/omarchy/config/hypr/bindings.conf` and wrapper presence in runtime `bin/`

## Rollback notes

- checkpoint restore:
  - `cp -a ~/.local/state/omacachy/backups/<timestamp> ~/.local/share/omarchy`
- rerun checks:
  - `install/compat/cachyos/validate-runtime.sh post-update`
