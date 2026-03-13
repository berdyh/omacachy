# Decision log

- Bootloader policy: Limine (CachyOS-owned)
- Swap policy: keep CachyOS default ZRAM
- AUR helper: paru
- Session/login: SDDM-based
- Scope: no ISO/USB builder
- Topology: `omarchy-upstream` -> `omacachy` -> `shomacachy`
- Downstream model: `shomacachy` is lightweight personal delta only
- Integration model: `omacachy` consumes upstream Omarchy; it does not re-own full Omarchy codebase
