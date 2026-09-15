---
tags:
  - linux
  - networking
  - wifi
  - wireless
  - cli
  - troubleshooting
  - iw
---

# iw — Linux Wireless CLI

`iw` is a command-line utility used to inspect and configure **Linux wireless devices** through the `nl80211` interface.

It is mainly useful for checking Wi-Fi interfaces, link state, supported capabilities, frequencies, channels, and nearby wireless networks.

## Basic inspection

List wireless devices:

```bash
iw dev
```

Show detailed wireless capabilities:

```bash
iw list
```

Show information about a specific interface:

```bash
iw dev <interface> info
```

Example:

```bash
iw dev wlp0s20f3 info
```

## Check current connection

```bash
iw dev <interface> link
```

Example:

```bash
iw dev wlp0s20f3 link
```

Typical output includes:

- connected SSID
- access point MAC address
- frequency
- signal strength
- transmit bitrate

## Scan nearby Wi-Fi networks

```bash
sudo iw dev <interface> scan
```

Filter useful fields:

```bash
sudo iw dev wlp0s20f3 scan | grep -E "SSID:|signal:|freq:"
```

## Check wireless statistics

```bash
iw dev <interface> station dump
```

Example:

```bash
iw dev wlp0s20f3 station dump
```

Useful values include:

- signal strength
- TX/RX bitrate
- transmitted packets
- retries
- failed transmissions

## Regulatory domain

Check the current wireless regulatory domain:

```bash
iw reg get
```

Example output may include the allowed frequencies and transmit power for the configured country.

## Quick troubleshooting

```bash
iw dev
iw dev <interface> link
iw dev <interface> info
iw dev <interface> station dump
iw reg get

ip link show <interface>
nmcli device status
```

## `iw` vs `nmcli`

`iw` operates closer to the Linux wireless stack and is useful for inspecting radio and Wi-Fi-specific details.

`nmcli` manages NetworkManager connections and profiles.

Typical troubleshooting workflow:

```text
nmcli → NetworkManager / connection state
iw    → wireless radio / association / signal details
ip    → Linux interface / addressing / routing
```

## See also

- `nmcli`
- `ip`
- `rfkill`
- `NetworkManager`
- `wpa_supplicant`

#linux #networking #wifi #wireless #iw #cli