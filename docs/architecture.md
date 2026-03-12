# Architecture

`omacachy` is a thin compatibility overlay. It consumes Omarchy from `berdyh/omarchy-upstream`, places the runtime at `~/.local/share/omarchy`, then applies focused compatibility rules.

## Why this is not an ISO project

This project installs onto an existing CachyOS base system and intentionally does not build install media.

## Ownership boundary

- CachyOS: backend/system ownership
- Omarchy: frontend UX/runtime ownership
- omacachy: orchestration and compatibility guards

## Why consume upstream instead of re-owning

Keeping Omarchy source in `berdyh/omarchy-upstream` allows clean sync with upstream and makes each downstream compatibility change auditable.
