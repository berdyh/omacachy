# Power UI bridge

CachyOS remains power backend authority.
`omacachy` provides UI bridge commands:

- `bin/omacachy-power-status`
- `bin/omacachy-power-profile`

These wrap `powerprofilesctl` for profile read/switch.

For Waybar JSON output, use:

- `install/compat/cachyos/power.sh waybar`

No default Omarchy backend policy takeover is applied.
