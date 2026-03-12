# Power UI bridge

CachyOS remains power backend authority.
`omacachy` provides UI bridge commands:

- `bin/omacachy-power-status`
- `bin/omacachy-power-profile`

These wrap `powerprofilesctl` for profile read/switch. No default Omarchy backend policy takeover is applied.
