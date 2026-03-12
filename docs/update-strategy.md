# Update strategy

`bin/omacachy-update` preserves Omarchy update spirit with CachyOS guardrails:

- sync from `berdyh/omarchy-upstream`
- refresh runtime tree at `~/.local/share/omarchy`
- reapply overlays/patches
- run Omarchy migrations when available
- update packages using `paru`

`paru` is canonical to avoid scattered helper assumptions.
Future CI can flag upstream drift and require compatibility review before downstream promotion.
