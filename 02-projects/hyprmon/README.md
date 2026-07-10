## Design Principle

Keep **HyprMon** simple.

HyprMon should remain a small shell-based helper that reacts to Hyprland monitor hotplug events and applies a known monitor profile.

The initial goal is not to replace full display managers like Kanshi, but to provide a transparent and easy-to-debug workflow tailored to a personal Hyprland setup.

## Architecture

* Systemd service Hyprland IPC listener captures monitors adding/removing events trigerring configuration script.
* monitor-profile script to configure monitors and layout.
## Installation

Download sources, three files:
* systemd/hyprmon.service
* scripts/hyprmon.sh
* scripts/monitor-profile.sh

```
$ mkdir -p ~/.config/systemd/user

$ cp systemd/hyprmon.service ~/.config/systemd/user/

$ systemctl --user daemon-reload
$ systemctl --user enable hyprmon.service
Created symlink '/home/ggomezsa/.config/systemd/user/default.target.wants/hyprmon.service' → '/home/ggomezsa/.config/systemd/user/hyprmon.service'.

$ systemctl --user start hyprmon.service
$ systemctl --user status hyprmon.service
%> systemctl --user status hyprmon.service 
● hyprmon.service - Hyprland Monitor Event Watcher
     Loaded: loaded (/home/ggomezsa/.config/systemd/user/hyprmon.service; enabled; preset: disabled)
    Drop-In: /usr/lib/systemd/user/service.d
             └─10-timeout-abort.conf
     Active: active (running) since Fri 2026-07-10 08:58:36 CEST; 7s ago
 Invocation: 7de1e46f4da048079f327b82f1cf546e
   Main PID: 438223 (bash)
      Tasks: 3 (limit: 38074)
     Memory: 1.5M (peak: 2.4M)
        CPU: 8ms
...
```