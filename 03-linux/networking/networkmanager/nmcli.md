---
tags:
  - linux
  - networking
  - networkmanager
  - nmcli
  - cli
---
# nmcli — NetworkManager CLI

`nmcli` is the command-line interface for **NetworkManager**. It can be used to inspect, configure, activate, and troubleshoot network connections directly from the terminal.

## Basic inspection

```bash
nmcli general status
nmcli device status
nmcli connection show
```

Show detailed information about a device:

```bash
nmcli device show <interface>
```

Example:

```bash
nmcli device show enp0s31f6
```

## Connections vs devices

NetworkManager distinguishes between:

- **device** — physical or virtual network interface, such as `eth0`, `wlan0`, or `enp0s31f6`
- **connection** — NetworkManager configuration/profile associated with a device

Useful commands:

```bash
nmcli device
nmcli connection
```

## Activate / deactivate a connection

```bash
nmcli connection up "<connection-name>"
nmcli connection down "<connection-name>"
```

## Modify a connection

Example: configure a static IPv4 address:

```bash
nmcli connection modify "<connection-name>" \
  ipv4.addresses 192.168.1.10/24 \
  ipv4.gateway 192.168.1.1 \
  ipv4.dns "1.1.1.1 8.8.8.8" \
  ipv4.method manual
```

Apply it:

```bash
nmcli connection up "<connection-name>"
```

## Quick troubleshooting

```bash
nmcli general
nmcli device status
nmcli connection show --active
ip addr
ip route
```

## See also

- `NetworkManager`
- `ip`
- `iproute2`
- `resolvectl`

#linux #networking #networkmanager #nmcli #cli