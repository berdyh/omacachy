# Update strategy

`bin/omacachy-update` now uses a transaction-safe model with explicit preservation and rollback:

1. fetch `berdyh/omarchy-upstream`
2. build a new candidate runtime tree
3. preserve user-safe paths from current runtime (`local`, `tmp`, `logs`, `config/local`, `config/custom`)
4. regenerate Omarchy-owned paths (`bin`, `config`, `themes`) from upstream
5. checkpoint backup of any existing runtime tree to `~/.local/state/omacachy/backups/<timestamp>`
6. atomically switch runtime at `~/.local/share/omarchy` (same-filesystem rename within runtime parent)
7. reapply deterministic compatibility patches/overlays
8. run boundary enforcement and runtime/session validation checks
9. run migrations and package updates

## Safety controls

- Lockfile protection:
  - update run lock: `~/.local/state/omacachy/update-run.lock`
  - runtime sync lock: `~/.local/state/omacachy/update.lock`
- patch application is idempotent with stamp files in `~/.local/state/omacachy/patch-stamps`
- automatic rollback to latest checkpoint if runtime replacement fails

## User customization policy

Safe user customization locations (preserved):

- `~/.local/share/omarchy/local`
- `~/.local/share/omarchy/tmp`
- `~/.local/share/omarchy/logs`
- `~/.local/share/omarchy/config/local`
- `~/.local/share/omarchy/config/custom`

Regenerated on update (do not hand-edit in place):

- `~/.local/share/omarchy/bin`
- `~/.local/share/omarchy/config`
- `~/.local/share/omarchy/themes`

## Rollback

If an update fails after sync, restore a checkpoint manually:

```bash
cp -a ~/.local/state/omacachy/backups/<timestamp> ~/.local/share/omarchy
```

Then rerun validation:

```bash
install/compat/cachyos/validate-runtime.sh post-update
```
