---
tags:
  - linux
  - hyprland
  - wayland
  - displays
---
---
tags:
  - linux
  - hyprland
  - wayland
  - displays
---

# Dynamic Monitor Configuration in Hyprland

## Overview

My Hyprland setup runs on a laptop that regularly moves between different monitor environments:

- Laptop display only
- Home ultrawide monitor
- Office monitor
- Unknown external monitors

The internal laptop display provides a stable baseline, while external monitors are detected and configured dynamically.

The solution combines:

- Hyprland monitor and workspace configuration
- Hyprland IPC events
- EDID-based physical monitor detection
- Bash scripts
- A `systemd --user` service

The basic flow is:

```text
Monitor connected/disconnected
            │
            ▼
       Hyprland IPC
      .socket2.sock
            │
            ▼
       hyprmon.sh
            │
   monitoraddedv2 /
   monitorremovedv2
            │
            ▼
   monitor-profile.sh
            │
       ┌────┴────┐
       ▼         ▼
    hyprctl     EDID
       │         │
       └────┬────┘
            ▼
      Select profile
            │
       ┌────┼─────┐
       ▼    ▼     ▼
    Office Home Unknown
       │    │     │
       └────┴─────┘
            │
            ▼
         hyprctl
```

## Components

The implementation consists of four files:

| Component | Location | Purpose |
| --- | --- | --- |
| Monitor configuration | `~/.config/hypr/hyprland.conf.d/monitors.conf` | Baseline monitor and workspace configuration |
| Event watcher | `~/.config/hypr/scripts/hyprmon.sh` | Listens for Hyprland monitor events |
| Profile script | `~/.config/hypr/scripts/monitor-profile.sh` | Detects the physical monitor and applies the appropriate layout |
| systemd service | `~/.config/systemd/user/hyprmon.service` | Runs and supervises the event watcher |

---

## Base Hyprland Configuration

Monitor-related configuration is kept in:

```text
~/.config/hypr/hyprland.conf.d/monitors.conf
```

The laptop display is explicitly configured:

```ini
monitor=eDP-1,2160x1350@60,0x0,1
```

Known external configurations are retained as references:

```ini
# Office
#monitor=DP-3,3440x1440@100,2160x0,1

# Home
#monitor=DP-3,5120x1440@60,0x-1440,1
```

Workspace placement also has a static baseline:

```ini
workspace = 1, monitor:eDP-1, default:true, persistent:true, layout:master, layoutopt:orientation:left
workspace = 2, monitor:DP-3, default:true
workspace = 3, monitor:DP-3, persistent:true
workspace = 4, monitor:DP-3, persistent:true
workspace = 5, monitor:DP-3, persistent:true
```

The important part, however, is that the runtime scripts do **not** assume that an external monitor will always be `DP-3`.

The actual connector is discovered dynamically.

---

## Monitor Layouts

### Office

The office monitor runs at:

```text
3440x1440 @ 100 Hz
```

with 10-bit color and is positioned to the right of the laptop:

```text
┌──────────────────┐ ┌─────────────────────────────┐
│                  │ │                             │
│      Laptop      │ │        Office monitor       │
│    2160x1350     │ │         3440x1440           │
│                  │ │                             │
└──────────────────┘ └─────────────────────────────┘
```

Workspace `1` stays on the laptop.

Workspaces `2` through `5` are placed on the office monitor using the `master` layout with left orientation.

### Home

The home monitor runs at:

```text
5120x1440 @ 60 Hz
```

with 8-bit color.

It is positioned above the laptop:

```text
┌───────────────────────────────────────────────────┐
│                                                   │
│                  Home ultrawide                   │
│                    5120x1440                      │
│                                                   │
└───────────────────────────────────────────────────┘
┌──────────────────┐
│      Laptop      │
│    2160x1350     │
└──────────────────┘
```

Workspace `1` remains on the laptop.

Workspaces `2` through `5` are placed on the ultrawide using the `master` layout with center orientation.

### Unknown External Monitor

Unknown monitors use their preferred mode and are placed to the right of the laptop:

```text
┌──────────────────┐ ┌─────────────────────────────┐
│                  │ │                             │
│      Laptop      │ │       External monitor      │
│                  │ │                             │
└──────────────────┘ └─────────────────────────────┘
```

The script obtains the actual laptop width from Hyprland:

```bash
LAPTOP_WIDTH=$(echo "$MONITORS_JSON" \
    | jq -r '.[] | select(.name=="eDP-1") | .width')
```

and uses it as the X coordinate of the external monitor:

```bash
h keyword monitor "${output},preferred,${LAPTOP_WIDTH}x0,1"
```

This provides a useful fallback when connecting the laptop to a monitor that has never been configured before.

---

# Implementation

## Hyprland Event Watcher

Hyprland exposes compositor events through:

```text
$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock
```

The watcher connects to this socket using `socat`.

File:

```text
~/.config/hypr/scripts/hyprmon.sh
```

```bash
#!/usr/bin/env bash
set -euo pipefail

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
PROFILE_SCRIPT="$HOME/.config/hypr/scripts/monitor-profile.sh"

echo "Listening on $SOCKET"

socat -u UNIX-CONNECT:"$SOCKET" - | while IFS= read -r event; do
    echo "RAW: $event"

    case "$event" in
        monitoraddedv2*|monitorremovedv2*)
            echo "MATCH: $event"
            logger -t hyprmon "event: $event"
            "$PROFILE_SCRIPT" "$event"
            ;;
    esac
done
```

The socket produces many Hyprland events, but only these trigger monitor reconfiguration:

```text
monitoraddedv2
monitorremovedv2
```

This makes the implementation event-driven rather than polling the monitor state.

---

## Monitor Profile Selection

The actual monitor detection and configuration is implemented in:

```text
~/.config/hypr/scripts/monitor-profile.sh
```

The script first obtains Hyprland's current view of the monitor topology:

```bash
MONITORS_JSON="$(hyprctl monitors -j)"
```

and discovers every monitor other than the laptop panel:

```bash
EXTERNAL_OUTPUTS="$(echo "$MONITORS_JSON" |
    jq -r '.[] | select(.name != "eDP-1") | .name')"
```

This is important because external connectors are not hard-coded.

An external display might currently be:

```text
DP-3
```

but the profile logic operates on whatever output Hyprland reports.

### EDID Detection

The physical monitor is identified through its EDID:

```bash
get_edid_text() {
    local output="$1"
    local edid_file=""

    for edid_file in /sys/class/drm/card*-"${output}"/edid; do
        [[ -e "$edid_file" ]] || continue

        if edid-decode "$edid_file" 2>/dev/null; then
            return 0
        fi
    done

    return 1
}
```

The decoded EDID is then classified:

```bash
detect_monitor_type() {
    local output="$1"
    local edid_text

    edid_text="$(get_edid_text "$output" || true)"

    if echo "$edid_text" | grep -q 'LS34A650U\|H4ZRA06381'; then
        echo "office"
    elif echo "$edid_text" | grep -q 'LS49C95xU\|HNTY300517'; then
        echo "home"
    else
        echo "unknown"
    fi
}
```

The known monitor identities are therefore:

| Profile | EDID match |
| --- | --- |
| Office | `LS34A650U` or `H4ZRA06381` |
| Home | `LS49C95xU` or `HNTY300517` |
| Fallback | Anything else |

The connector and physical monitor identity are deliberately treated as different things:

> Hyprland tells the script **where** the display is connected; EDID tells it **which display** is connected.

---

## Applying the Office Profile

When the office monitor is detected:

```bash
h keyword monitor "${LAPTOP_NAME}, preferred, 0x0, 1"
h keyword monitor "${OFFICE_DP},3440x1440@100,2160x0,1,bitdepth,10"

h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true"
h keyword workspace "2, monitor:${OFFICE_DP}, default:true, persistent:true, layout:master, layoutopt:orientation:left"
h keyword workspace "3, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left"
h keyword workspace "4, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left"
h keyword workspace "5, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left"
```

The resulting policy is:

```text
Laptop
└── Workspace 1

Office monitor
├── Workspace 2
├── Workspace 3
├── Workspace 4
└── Workspace 5
    └── master / left
```

---

## Applying the Home Profile

When the home ultrawide is detected:

```bash
h keyword monitor "${LAPTOP_NAME},preferred,0x0,1"
h keyword monitor "${HOME_DP},5120x1440@60,0x-1440,1,bitdepth,8"

h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true"
h keyword workspace "2, monitor:${HOME_DP}, default:true, persistent:true, layout:master, layoutopt:orientation:center"
h keyword workspace "3, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center"
h keyword workspace "4, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center"
h keyword workspace "5, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center"
```

The important difference from the office profile is the `master` orientation:

```text
Office → orientation:left
Home   → orientation:center
```

The ultrawide benefits from the centered master layout, while the office monitor uses the conventional left-oriented master layout.

---

## Applying the Fallback Profile

If neither known monitor is detected, the laptop is configured first:

```bash
h keyword monitor "${LAPTOP_NAME},preferred,0x0,1"
h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true"
```

The laptop width is obtained dynamically:

```bash
LAPTOP_WIDTH=$(echo "$MONITORS_JSON" \
    | jq -r '.[] | select(.name=="eDP-1") | .width')
```

Every external output is then placed immediately to its right:

```bash
for output in $EXTERNAL_OUTPUTS; do
    h keyword monitor "${output},preferred,${LAPTOP_WIDTH}x0,1"

    h keyword workspace "2, monitor:${output}, persistent:true, layout:master, layoutopt:orientation:left"
    h keyword workspace "3, monitor:${output}, persistent:true, layout:master, layoutopt:orientation:left"
    h keyword workspace "4, monitor:${output}, persistent:true, layout:master, layoutopt:orientation:left"
    h keyword workspace "5, monitor:${output}, persistent:true, layout:master, layoutopt:orientation:left"
done
```

This means the fallback does not depend on a specific resolution or connector name.

---

## systemd User Service

The event watcher is kept alive by a systemd user service:

```text
~/.config/systemd/user/hyprmon.service
```

```ini
[Unit]
Description=Hyprland Monitor Event Watcher
After=graphical-session.target

[Service]
Type=simple
ExecStart=%h/.config/hypr/scripts/hyprmon.sh
Restart=always
RestartSec=2

[Install]
WantedBy=default.target
```

Enable and immediately start it with:

```bash
systemctl --user enable --now hyprmon.service
```

Check its state:

```bash
systemctl --user status hyprmon.service
```

After modifying the unit:

```bash
systemctl --user daemon-reload
systemctl --user restart hyprmon.service
```

The use of systemd is intentional:

- The watcher starts with the user session.
- It can be restarted independently from Hyprland.
- `Restart=always` recovers the watcher if the IPC connection terminates.
- Logs are available through journald.

---

## Troubleshooting

The most useful command while testing the setup is:

```bash
journalctl --user -u hyprmon.service -f
```

The watcher prints all received Hyprland events:

```text
RAW: focusedmon>>DP-3,2
RAW: activewindow>>obsidian,...
```

Monitor topology events additionally produce:

```text
MATCH: monitoraddedv2...
```

The profile script also writes relevant events through:

```bash
logger -t hyprmon
```

The current monitor topology can be checked independently:

```bash
hyprctl monitors
```

or:

```bash
hyprctl monitors -j | jq
```

To inspect the physical monitor identity directly:

```bash
edid-decode /sys/class/drm/card*-DP-3/edid
```

When troubleshooting, the complete path is:

```text
Monitor
   ↓
Hyprland detects topology change
   ↓
.socket2.sock
   ↓
hyprmon.sh receives event
   ↓
monitor-profile.sh executes
   ↓
hyprctl monitors -j
   ↓
DRM EDID
   ↓
office / home / unknown
   ↓
hyprctl keyword
```

---

## Design Notes

A few useful principles came out of this setup.

### Do not identify physical monitors by connector

A connector such as `DP-3` is discovered dynamically.

Physical monitor identity comes from EDID instead.

This makes the setup less dependent on docks, ports, or connector numbering.

### Keep the event watcher simple

`hyprmon.sh` only answers:

> When should the monitor configuration be reevaluated?

It does not contain monitor policy.

### Keep monitor policy in the profile script

`monitor-profile.sh` answers:

> Given the monitors currently connected, what should the desktop look like?

This keeps IPC handling separate from layout decisions.

### Provide a generic fallback

A new or temporary monitor does not need to be added to the script before it becomes usable.

Unknown monitors automatically use their preferred resolution and are placed to the right of the laptop.

### Use systemd for persistent desktop automation

The watcher is a long-running process and benefits from proper lifecycle management, automatic restart, and journald integration.

---

## Dependencies

The implementation relies on:

```text
Hyprland
bash
jq
socat
edid-decode
systemd --user
```

Useful verification commands:

```bash
command -v hyprctl
command -v jq
command -v socat
command -v edid-decode
```

