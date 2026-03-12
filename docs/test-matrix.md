# Test matrix

## Supported assumptions

- CachyOS base already installed
- SDDM session path
- Limine boot ownership remains CachyOS
- runtime path `~/.local/share/omarchy`

## Smoke tests

- installer rejects non-CachyOS
- installer rejects root execution
- upstream sync populates runtime path
- update path runs migrations when present
- power profile status/switch commands function

## Failure cases

- missing `paru`
- missing `chwd`
- no network for upstream sync

## Rollback notes

- remove runtime tree `~/.local/share/omarchy`
- remove symlinks from `~/.local/bin`
- revert any local overlay changes
