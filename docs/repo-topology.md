# Repo topology

- `berdyh/omarchy-upstream`: clean upstream mirror
- `berdyh/omacachy`: CachyOS compatibility layer (this repo)
- `berdyh/shomacachy`: lightweight personal downstream config/app delta

CI/CD flow should propagate upstream changes into `omarchy-upstream`, then run compatibility review in `omacachy`, then optional downstream personalization in `shomacachy`.
