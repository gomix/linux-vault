---
tags:
  - linux
  - audio
  - pipewire
  - wireplumber
  - audio-routing
---

# Audio Routing

Notes related to Linux audio routing, device management, and the PipeWire audio stack.

## Overview

Modern Linux audio routing is commonly built around **PipeWire**, with **WirePlumber** acting as the session and policy manager.

The main components covered in this section are:

- **PipeWire** — multimedia server responsible for handling audio and video streams.
- **WirePlumber** — session manager responsible for device discovery, policies, profiles, and routing.
- **wpctl** — command-line interface provided by WirePlumber for inspecting and controlling PipeWire objects.
- **pactl** — PulseAudio command-line interface, also usable through PipeWire's PulseAudio compatibility layer.

## Architecture

A simplified view of the stack:

```text
Applications
     │
     ▼
PipeWire API / PulseAudio compatibility
     │
     ▼
   PipeWire
     │
     ├── Audio streams
     ├── Devices
     ├── Nodes
     └── Links
           │
           ▼
     WirePlumber
     Session / Policy Manager
           │
           ▼
        ALSA
           │
           ▼
      Audio Hardware