Place compatibility patch files (`*.patch`) here.

Behavior:

- Applied in lexicographic order to `~/.local/share/omarchy`.
- Applied by `bin/omacachy-apply-patches` with idempotent checks.
- Successful patch application stamps are stored at `~/.local/state/omacachy/patch-stamps`.
- Patch failures are treated as hard errors.
