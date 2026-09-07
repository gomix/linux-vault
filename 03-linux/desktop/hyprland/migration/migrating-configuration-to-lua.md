# Hyprland - Migrating Configuration to Lua

## Tags

#linux #fedora #hyprland #wayland #uwsm #lua #configuration #migration

## Context

Hyprland is moving away from the traditional Hyprlang configuration format used in `hyprland.conf`.

Recent Hyprland releases introduce a Lua-based configuration API, while the legacy Hyprlang format is being deprecated. This note documents the migration of an existing modular Hyprland configuration from:

```text
~/.config/hypr/hyprland.conf
~/.config/hypr/hyprland.conf.d/*.conf
```

to:

```text
~/.config/hypr/hyprland.lua
~/.config/hypr/hyprland/*.lua
```

The graphical session is started with **UWSM**, so the migration also involves separating environment variables and session startup responsibilities from Hyprland itself.

---

# Original Configuration Structure

The original `hyprland.conf` was primarily an entry point that sourced several configuration fragments:

```ini
# Order matters
source = ~/.config/hypr/hyprland.conf.d/env.conf
source = ~/.config/hypr/hyprland.conf.d/programs.conf
source = ~/.config/hypr/hyprland.conf.d/monitors.conf
source = ~/.config/hypr/hyprland.conf.d/input.conf
source = ~/.config/hypr/hyprland.conf.d/general.conf
source = ~/.config/hypr/hyprland.conf.d/decoration.conf
source = ~/.config/hypr/hyprland.conf.d/animations.conf
source = ~/.config/hypr/hyprland.conf.d/layout.conf
source = ~/.config/hypr/hyprland.conf.d/rules.conf
source = ~/.config/hypr/hyprland.conf.d/misc.conf
source = ~/.config/hypr/hyprland.conf.d/keybinds.conf
source = ~/.config/hypr/hyprland.conf.d/autostart.conf
```

The modular organization was preserved during the Lua migration.

---

# New Lua Structure

The resulting structure is:

```text
~/.config/hypr/
├── hyprland.lua
├── hyprland/
│   ├── animations.lua
│   ├── autostart.lua
│   ├── decoration.lua
│   ├── general.lua
│   ├── input.lua
│   ├── keybinds.lua
│   ├── layout.lua
│   ├── misc.lua
│   ├── monitors.lua
│   ├── programs.lua
│   └── rules.lua
├── scripts/
├── systemd/
└── waybar/
```

The main entry point becomes:

```lua
require("hyprland.programs")
require("hyprland.monitors")
require("hyprland.input")
require("hyprland.general")
require("hyprland.decoration")
require("hyprland.animations")
require("hyprland.layout")
require("hyprland.rules")
require("hyprland.misc")
require("hyprland.keybinds")
require("hyprland.autostart")
```

For example:

```lua
require("hyprland.general")
```

resolves to:

```text
~/.config/hypr/hyprland/general.lua
```

---

# Environment Variables and UWSM

Because the Hyprland session is started with UWSM, environment variables should no longer be managed from the Hyprland configuration.

The old configuration contained:

```ini
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
env = PATH,$HOME/bin:/usr/local/bin:/usr/bin
env = GDK_SCALE,1
env = GDK_DPI_SCALE,1
env = QT_AUTO_SCREEN_SCALE_FACTOR,0
env = QT_SCALE_FACTOR,1
```

These variables were moved into UWSM configuration.

General session variables:

```bash
# ~/.config/uwsm/env

export XCURSOR_SIZE=24
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Optional scaling overrides
# export GDK_SCALE=1
# export GDK_DPI_SCALE=1
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_SCALE_FACTOR=1
```

Hyprland-specific variables:

```bash
# ~/.config/uwsm/env-hyprland

export HYPRCURSOR_SIZE=24
```

The distinction is:

```text
~/.config/uwsm/env
```

for general graphical-session variables, and:

```text
~/.config/uwsm/env-hyprland
```

for Hyprland/Aquamarine-specific variables.

Changes to these files require starting a new graphical session. A simple:

```bash
hyprctl reload
```

does not recreate the UWSM environment.

---

# Programs Module

The original Hyprlang variables:

```ini
$browser = google-chrome-stable
$fileManager = nautilus
$terminal = kitty --single-instance
$pkm = flatpak run md.obsidian.Obsidian
$ytm = flatpak run app.ytmdesktop.ytmdesktop
```

were converted into a reusable Lua module:

```lua
local programs = {
    browser = "google-chrome-stable",
    fileManager = "nautilus",
    terminal = "kitty --single-instance",
    pkm = "flatpak run md.obsidian.Obsidian",
    ytm = "flatpak run app.ytmdesktop.ytmdesktop",
}

return programs
```

Other modules can then import it with:

```lua
local programs = require("hyprland.programs")
```

This replaces Hyprlang-style global variables with an explicit Lua module dependency.

---

# Input Configuration

The original configuration:

```ini
input {
    kb_layout = us,cz
    kb_variant = intl,qwerty
    kb_options = ctrl:swapcaps

    repeat_delay = 180
    repeat_rate = 60

    follow_mouse = 2
    sensitivity = 0

    touchpad {
        natural_scroll = false
    }
}
```

became:

```lua
hl.config({
    input = {
        kb_layout = "us,cz",
        kb_variant = "intl,qwerty",
        kb_options = "ctrl:swapcaps",

        repeat_delay = 180,
        repeat_rate = 60,

        follow_mouse = 2,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})
```

Unused example device configuration was removed rather than migrated.

---

# General Configuration

The original:

```ini
general {
    gaps_in = 0
    gaps_out = 0

    border_size = 2

    col.active_border = rgba(8b0000ff)
    col.inactive_border = rgba(444444aa)

    resize_on_border = false
    allow_tearing = false

    layout = master
}
```

became:

```lua
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,

        border_size = 2,

        col = {
            active_border = "rgba(8b0000ff)",
            inactive_border = "rgba(444444aa)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "master",
    },
})
```

Nested Hyprlang namespaces naturally become nested Lua tables.

---

# Decoration Configuration

The decoration configuration was migrated directly:

```lua
hl.config({
    decoration = {
        rounding = 1,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})
```

---

# Animations

Animations require more than a simple nested configuration-table conversion.

The original configuration:

```ini
animations {
    enabled = yes
}

bezier = fast, 0.25, 0.1, 0.25, 1.0

animation = windows, 1, 2, fast
animation = windowsOut, 1, 2, fast
animation = border, 1, 2, fast
animation = fade, 1, 2, fast
animation = workspaces, 1, 2, fast
```

starts with:

```lua
hl.config({
    animations = {
        enabled = true,
    },
})
```

The Bézier curve and individual animation entries are then represented through the Lua animation/curve API.

This is one of the areas where a mechanical text conversion from Hyprlang to Lua is not sufficient.

---

# Master Layout

The configuration uses the `master` layout.

The default/base configuration is:

```lua
hl.config({
    master = {
        new_status = "slave",
        mfact = 0.60,
        orientation = "center",

        allow_small_split = false,
        slave_count_for_center_master = 0,
        center_master_fallback = "left",

        always_keep_position = true,
        smart_resizing = false,

        new_on_top = false,
        new_on_active = "none",
    },
})
```

Two monitor profiles are used:

```text
Home
    orientation = center
    mfact       = 0.60

Office
    orientation = left
    mfact       = 0.70
```

The static Lua configuration defines the default state.

Runtime profile switching remains the responsibility of `monitor-profile.sh`.

---

# Window Rules

Window rules change significantly in Lua.

For example:

```ini
windowrule = match:class ^(org.pulseaudio.pavucontrol)$, workspace 5 silent
```

becomes conceptually:

```lua
hl.window_rule({
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
    },

    workspace = "5 silent",
})
```

Matching criteria are grouped under:

```lua
match = {}
```

while the effects of the rule remain outside the `match` table.

Other migrated rules include:

- suppressing application maximize requests
- special handling for XWayland dragging edge cases
- assigning YouTube Music Desktop App to workspace 5
- assigning EasyEffects to workspace 5
- assigning Pavucontrol to workspace 5

---

# Keybindings

Keybindings are one of the larger syntax changes.

A Hyprlang bind such as:

```ini
bind = $mainMod, W, exec, $browser
```

becomes a Lua bind using Hyprland's dispatcher API.

The shared programs module is imported with:

```lua
local programs = require("hyprland.programs")
```

Because the graphical session is managed by UWSM, GUI applications should normally be launched through:

```text
uwsm app -- <application>
```

For example:

```lua
hl.dsp.exec_cmd("uwsm app -- " .. programs.browser)
```

The old bind variants:

```text
bind
bindm
bindl
bindel
```

are represented in Lua through a common binding API and flags such as:

```text
mouse
locked
repeating
```

During migration, an existing binding conflict was also identified:

```text
SUPER + SHIFT + K
```

was assigned both to:

```text
move window up
```

and:

```text
switch keyboard layout
```

This should be resolved instead of reproducing the conflict in the Lua configuration.

---

# UWSM and Session Exit

The old configuration used:

```ini
bind = SUPER SHIFT, Q, exit
```

With a UWSM-managed session, session shutdown should instead be delegated to UWSM:

```bash
uwsm stop
```

This allows UWSM/systemd to tear down the graphical session and its associated services cleanly.

---

# Autostart under UWSM

The old configuration contained:

```ini
exec-once = waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css
exec-once = kitty --single-instance
exec-once = netbird-ui
```

These commands should not automatically be translated into Lua startup hooks.

For a UWSM-managed session, prefer:

1. `systemd --user` services
2. XDG autostart
3. UWSM-managed applications
4. Hyprland startup hooks only for processes that genuinely need to be tied directly to the compositor

---

# Waybar

A Waybar user service already existed, but the default unit did not use the custom configuration stored under:

```text
~/.config/hypr/waybar/
```

Instead of starting Waybar from Hyprland with:

```ini
exec-once = waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css
```

the existing service can be overridden:

```bash
systemctl --user edit waybar.service
```

with:

```ini
[Service]
ExecStart=
ExecStart=/usr/bin/waybar -c %h/.config/hypr/waybar/config.jsonc -s %h/.config/hypr/waybar/style.css
```

Then reload and restart it:

```bash
systemctl --user daemon-reload
systemctl --user restart waybar.service
```

The effective unit can be inspected with:

```bash
systemctl --user cat waybar.service
```

This keeps Waybar under systemd/UWSM lifecycle management rather than starting it directly from Hyprland.

---

# Monitor Management

This setup uses dynamic monitor profiles with EDID-based identification of external displays.

The current profiles detect:

```text
Office
    Samsung LS34A650U
    3440x1440

Home
    Samsung LS49C95xU
    5120x1440
```

The existing monitor script continues to use:

```text
wlr-randr
```

for physical output geometry.

This choice was retained because changing monitor geometry through Hyprland during hotplug had previously caused external outputs to remain at `0x0` after reconnect with some Aquamarine versions.

Responsibilities are therefore separated:

```text
monitors.lua
    static monitor/workspace configuration

monitor-profile.sh
    EDID detection
    physical output geometry
    dynamic workspace placement
    Office/Home layout profile
```

---

# Base monitors.lua

The Lua monitor configuration keeps only static behavior:

```lua
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    mode = "2160x1350@60",
    position = "0x0",
    scale = 1,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "eDP-1",
    default = true,
    persistent = true,
    layout = "master",
})

for ws = 2, 5 do
    hl.workspace_rule({
        workspace = tostring(ws),
        persistent = true,
        layout = "master",
    })
end
```

Workspaces 2-5 deliberately do not have a fixed external monitor or orientation here because those depend on whether the Office or Home display is connected.

---

# Dynamic Monitor Profiles

The old script dynamically injected Hyprlang syntax such as:

```bash
hyprctl keyword workspace \
    "2, monitor:DP-3, persistent:true, layout:master, layoutopt:orientation:left"
```

After moving the primary configuration to Lua, this mixes two configuration models and is undesirable.

The new approach applies dynamic rules through Hyprland's Lua runtime API.

Conceptually:

```lua
hl.workspace_rule({
    workspace = "2",
    monitor = "DP-3",
    persistent = true,
    layout = "master",

    layout_opts = {
        orientation = "left",
    },
})
```

The Office profile is intended to produce:

```text
workspace 1 -> eDP-1
workspace 2 -> DP-3
workspace 3 -> DP-3
workspace 4 -> DP-3
workspace 5 -> DP-3

orientation -> left
mfact       -> 0.70
```

The Home profile is intended to produce:

```text
workspace 1 -> eDP-1
workspace 2 -> external
workspace 3 -> external
workspace 4 -> external
workspace 5 -> external

orientation -> center
mfact       -> 0.60
```

The monitor script therefore handles only hardware-dependent runtime state, while `monitors.lua` remains declarative.

---

# Migration Procedure

Before switching to the Lua entry point, the old configuration was retained:

```bash
mv ~/.config/hypr/hyprland.conf \
   ~/.config/hypr/hyprland.conf.pre-lua
```

The old fragments were also kept temporarily:

```text
~/.config/hypr/hyprland.conf.d/
```

They remain useful as a migration reference but are no longer part of the active configuration.

The Lua configuration was then loaded with:

```bash
hyprctl reload full-reset
```

A full reset is useful when switching configuration engines.

For normal changes after migration, use:

```bash
hyprctl reload
```

---

# Validation

The first validation command is:

```bash
hyprctl configerrors
```

An empty result means Hyprland is not reporting configuration parsing/runtime errors.

Additional useful checks are:

```bash
hyprctl monitors
```

```bash
hyprctl workspaces
```

```bash
hyprctl workspacerules
```

```bash
hyprctl getoption master:orientation
```

```bash
hyprctl getoption master:mfact
```

A useful caveat:

```bash
hyprctl getoption master:orientation
```

reports the global Master configuration. Individual workspaces can have their own `layout_opts.orientation`, so the global value is not necessarily the effective orientation for every workspace.

---

# Migration Lessons

This migration is not simply:

```text
.conf -> .lua
```

It is also an opportunity to improve the configuration architecture.

## Static Hyprland configuration

Use Lua modules for:

```text
general
input
decoration
animations
layout
rules
bindings
monitors
```

## Environment

Use UWSM:

```text
~/.config/uwsm/env
~/.config/uwsm/env-hyprland
```

## Session Applications

Prefer:

```text
systemd --user
XDG autostart
uwsm app
```

over unconditional Hyprland `exec-once` entries.

## Dynamic Hardware State

Keep hardware-dependent runtime behavior separate from static declarative configuration.

In this setup:

```text
Lua configuration
    declarative base state

monitor-profile.sh
    dynamic EDID-driven state
```

This creates a cleaner boundary than injecting Hyprlang configuration strings dynamically from shell scripts.

---

# Current Migration Status

```text
Environment       migrated to UWSM
Programs          migrated to Lua
Monitors          migrated to Lua
Input             migrated to Lua
General           migrated to Lua
Decoration        migrated to Lua
Animations        migrated to Lua
Master layout     migrated to Lua
Window rules      migrated to Lua
Misc              migrated to Lua
Keybindings       migrated to Lua
Waybar startup    moved toward systemd/UWSM
Monitor profiles  being adapted to the Lua runtime API
```

The old Hyprlang configuration can remain temporarily as:

```text
hyprland.conf.pre-lua
hyprland.conf.d/
```

until the Lua configuration has been exercised through all important scenarios:

```text
laptop only
office monitor
home monitor
hotplug
monitor disconnect/reconnect
session restart
suspend/resume
```

Only after those tests are successful should the old configuration be archived or removed.

---

# References

- Hyprland Wiki — Configuration  
  https://wiki.hypr.land/Configuring/

- Hyprland Wiki — Master Layout  
  https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
