---
tags:
  - linux
  - audio
  - pipewire
  - pulseaudio
  - pactl
  - audio-routing
---
# pactl

`pactl` is a command-line utility originally designed for **PulseAudio**.

On modern Linux systems using **PipeWire**, `pactl` usually works through the `pipewire-pulse` compatibility layer.

It is especially useful for listing and controlling:

- sinks
- sources
- audio streams
- default devices
- volume
- mute state
- PulseAudio-compatible modules

---

## Basic information

Show server information:

```bash
pactl info
````

Useful fields include:

```text
Server Name
Server Version
Default Sink
Default Source
```

On a PipeWire system, the server name typically indicates PipeWire compatibility.

---

## List sinks

Short format:

```bash
pactl list short sinks
```

Example output:

```text
42  alsa_output.pci-0000_00_1f.3.analog-stereo  PipeWire  s32le 2ch 48000Hz  RUNNING
```

Detailed output:

```bash
pactl list sinks
```

Useful properties include:

```text
Name
Description
State
Volume
Mute
Monitor Source
Properties
Ports
Active Port
```

---

## List sources

Short format:

```bash
pactl list short sources
```

Detailed output:

```bash
pactl list sources
```

Sources normally represent:

* microphones
* capture devices
* monitor sources associated with sinks

---

## List active playback streams

```bash
pactl list short sink-inputs
```

Detailed information:

```bash
pactl list sink-inputs
```

A `sink-input` represents an application playback stream connected to a sink.

Examples:

* browser audio
* music player
* video player
* conferencing application

---

## List recording streams

```bash
pactl list short source-outputs
```

Detailed information:

```bash
pactl list source-outputs
```

A `source-output` represents an application recording or capture stream.

---

## Default sink

Show the current default sink:

```bash
pactl get-default-sink
```

Set the default sink:

```bash
pactl set-default-sink <SINK_NAME>
```

Example:

```bash
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
```

---

## Default source

Show the current default source:

```bash
pactl get-default-source
```

Set the default source:

```bash
pactl set-default-source <SOURCE_NAME>
```

---

## Volume

Get sink volume:

```bash
pactl get-sink-volume <SINK>
```

Example:

```bash
pactl get-sink-volume @DEFAULT_SINK@
```

Set volume:

```bash
pactl set-sink-volume @DEFAULT_SINK@ 50%
```

Increase volume:

```bash
pactl set-sink-volume @DEFAULT_SINK@ +5%
```

Decrease volume:

```bash
pactl set-sink-volume @DEFAULT_SINK@ -5%
```

---

## Mute

Check mute state:

```bash
pactl get-sink-mute @DEFAULT_SINK@
```

Mute:

```bash
pactl set-sink-mute @DEFAULT_SINK@ 1
```

Unmute:

```bash
pactl set-sink-mute @DEFAULT_SINK@ 0
```

Toggle:

```bash
pactl set-sink-mute @DEFAULT_SINK@ toggle
```

---

## Move an application stream

List playback streams:

```bash
pactl list short sink-inputs
```

Move a stream to another sink:

```bash
pactl move-sink-input <SINK_INPUT_ID> <SINK>
```

Example:

```bash
pactl move-sink-input 125 alsa_output.usb-Generic_USB_Audio-00.analog-stereo
```

This is useful for moving application audio between outputs without restarting the application.

---

## Monitor sources

Each sink normally provides a corresponding monitor source.

Example:

```text
alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
```

Monitor sources can be used to capture the audio currently being played through a sink.

List them with:

```bash
pactl list short sources
```

---

## Modules

List loaded modules:

```bash
pactl list short modules
```

Load a module:

```bash
pactl load-module <MODULE>
```

Unload a module:

```bash
pactl unload-module <MODULE_ID>
```

Example:

```bash
pactl load-module module-null-sink sink_name=virtual_sink
```

This can be useful for creating virtual audio devices and more advanced routing setups.

> On PipeWire systems, module behavior is provided through the PulseAudio compatibility layer and may differ from native WirePlumber/PipeWire configuration.

---

## Quick troubleshooting workflow

Check the audio server:

```bash
pactl info
```

List sinks:

```bash
pactl list short sinks
```

List sources:

```bash
pactl list short sources
```

List playback streams:

```bash
pactl list short sink-inputs
```

Check default devices:

```bash
pactl get-default-sink
pactl get-default-source
```

For more detailed information:

```bash
pactl list sinks
pactl list sources
```

---

## `pactl` vs `wpctl`

| Tool      | Typical use                                 |
| --------- | ------------------------------------------- |
| `pactl`   | PulseAudio-compatible control and scripting |
| `wpctl`   | Native WirePlumber control                  |
| `pw-cli`  | Low-level PipeWire object inspection        |
| `pw-dump` | Full PipeWire object dump                   |

For modern PipeWire systems, `wpctl` is generally preferable for native WirePlumber operations, while `pactl` remains very useful for concise listings, scripting, and PulseAudio-compatible workflows.

## See also

TBD



