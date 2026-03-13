# omacachy

`omacachy` installs **Omarchy on top of an existing CachyOS installation**.

It is:
- a thin compatibility overlay
- an install/update orchestration layer
- a policy guard for CachyOS ownership boundaries

It is **not**:
- an ISO builder
- a USB flasher
- a standalone distro image project
- a full permanent rewrite/fork of all Omarchy internals

## Repository topology

- `basecamp/omarchy` = upstream Omarchy
- `berdyh/omarchy-upstream` = clean mirror/sync source
- `berdyh/omacachy` (this repo) = CachyOS compatibility overlay
- `berdyh/shomacachy` = later personal app/config delta only

## Ownership boundary

CachyOS owns backend/system policy (kernel, bootloader, pacman config/mirrors, GPU driver flow, swap/zram, power backend).
Omarchy owns frontend UX (Hyprland config, bindings, UI workflow, migrations, runtime tree).

`omacachy` keeps runtime at:

- `~/.local/share/omarchy`

and applies targeted compatibility logic without re-owning Omarchy.

## Install summary

```bash
bin/omacachy-install
```

This detects CachyOS, syncs from `berdyh/omarchy-upstream`, populates `~/.local/share/omarchy`, and applies compatibility hooks.

## Update summary

```bash
bin/omacachy-update
```

This performs lock-protected upstream sync with checkpoints/rollback, reapplies deterministic compatibility overlays/patches, validates runtime/session readiness, runs migrations when present, and updates packages via canonical `paru`.

## Documentation

See `docs/` for architecture, source authorities, install/update strategy, CI drift policy, and downstream `shomacachy` boundaries.
