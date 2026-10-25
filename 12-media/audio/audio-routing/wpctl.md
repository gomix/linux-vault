---
tags:
  - linux
  - audio
  - pipewire
  - wireplumber
  - wpctl
  - audio-routing
---
# wpctl

`wpctl` is the command-line tool provided by **WirePlumber** to inspect and control audio devices, nodes, streams, and parameters managed by **PipeWire**.

## Basic commands

### Show overall status

```bash
wpctl status
````

Displays:

* audio devices
* sinks / outputs
* sources / inputs
* active streams
* default devices
* PipeWire object IDs

---

### Inspect an object

```bash
wpctl inspect <ID>
```

Example:

```bash
wpctl inspect 52
```

Useful properties include:

```text
node.name
node.description
media.class
device.id
audio.channels
```

---

## Volume

### Get volume

```bash
wpctl get-volume @DEFAULT_AUDIO_SINK@
```

### Set volume

```bash
wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%
```

Increase volume:

```bash
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
```

Decrease volume:

```bash
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
```

### Toggle mute

```bash
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```

---

## Default device

### Set the default output

```bash
wpctl set-default <SINK_ID>
```

Example:

```bash
wpctl set-default 52
```

### Special identifiers

```text
@DEFAULT_AUDIO_SINK@
@DEFAULT_AUDIO_SOURCE@
@DEFAULT_SINK@
@DEFAULT_SOURCE@
```

---

## Listing sinks

`wpctl` does not provide a dedicated `list-sinks` subcommand.

The usual approach is:

```bash
wpctl status
```

and check the `Sinks` section:

```text
Audio
 ├─ Devices:
 ├─ Sinks:
 ├─ Sources:
 ├─ Filters:
 └─ Streams:
```

For a more script-friendly sink list, use:

```bash
pactl list short sinks
```

or:

```bash
pactl list sinks
```

Although `pactl` comes from the PulseAudio ecosystem, it works with PipeWire through `pipewire-pulse`.

---

## PipeWire inspection

For lower-level PipeWire inspection:

```bash
pw-cli ls Node
```

or:

```bash
pw-dump
```

Filter audio sinks:

```bash
pw-dump | jq '.[] | select(.info.props["media.class"] == "Audio/Sink")'
```

---

## Quick troubleshooting workflow

Start with:

```bash
wpctl status
```

Identify the sink ID and inspect it:

```bash
wpctl inspect <ID>
```

Check the default sink:

```bash
wpctl get-volume @DEFAULT_AUDIO_SINK@
```

Compare with:

```bash
pactl list short sinks
```

---

## Related tools

| Tool       | Purpose                                    |
| ---------- | ------------------------------------------ |
| `wpctl`    | Control and inspect WirePlumber / PipeWire |
| `pactl`    | PulseAudio-compatible audio management     |
| `pw-cli`   | Low-level PipeWire CLI                     |
| `pw-dump`  | Dump the complete PipeWire object state    |
| `pw-top`   | Monitor PipeWire nodes in real time        |
| `helvum`   | Graphical PipeWire patchbay                |
| `qpwgraph` | Graphical PipeWire graph manager           |

## See also

TBD