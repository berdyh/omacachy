# Install

## Prerequisites

- Existing CachyOS installation
- User account with sudo access
- git, bash, paru

## Flow

1. `bin/omacachy-install`
2. detect CachyOS and verify non-root execution
3. sync `berdyh/omarchy-upstream`
4. populate `~/.local/share/omarchy`
5. apply local patches/overlays
6. run CachyOS compatibility hooks

## What changes

- Omarchy runtime and userland configs are installed
- session/user frontend integration is enabled

## What does not change

- no ISO/USB flow
- no takeover of pacman/mirrorlist
- no boot takeover
- no GPU backend takeover
- no swap policy override
