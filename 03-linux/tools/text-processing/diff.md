---
tags:
  - linux
  - cli
  - text-processing
  - comparison
  - diff
---


# diff

`diff` is a command-line utility used to compare files and directories and report the differences between them.

It is commonly used to:

- Compare two configuration files.
- Compare directory trees between systems or environments.
- Review changes between different versions of files.
- Troubleshoot configuration drift.
- Generate patches that can later be applied with tools such as `patch`.

## Basic syntax

```
diff [OPTIONS] FILE1 FILE2
```

## Comparing directories

`diff` can recursively compare the contents of two directory trees using the `-r` option.

```
diff -r directory1/ directory2/
diff -rq directory1/ directory2/
```

### Excludes

```
%> diff -rq --exclude=.git ~/backup/.config/hypr/ ~/.config/hypr/
Only in /home/gizmo/backup/.config/hypr/: .gitignore
Only in /home/gizmo/.config/hypr/: hypridle.conf
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/autostart.conf and /home/gizmo/.config/hypr/hyprland.conf.d/autostart.conf differ     
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/decoration.conf and /home/gizmo/.config/hypr/hyprland.conf.d/decoration.conf differ   
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/env.conf and /home/gizmo/.config/hypr/hyprland.conf.d/env.conf differ
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/general.conf and /home/gizmo/.config/hypr/hyprland.conf.d/general.conf differ         
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/input.conf and /home/gizmo/.config/hypr/hyprland.conf.d/input.conf differ
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/keybinds.conf and /home/gizmo/.config/hypr/hyprland.conf.d/keybinds.conf differ       
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/layout.conf and /home/gizmo/.config/hypr/hyprland.conf.d/layout.conf differ
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/misc.conf and /home/gizmo/.config/hypr/hyprland.conf.d/misc.conf differ
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/monitors.conf and /home/gizmo/.config/hypr/hyprland.conf.d/monitors.conf differ       
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/programs.conf and /home/gizmo/.config/hypr/hyprland.conf.d/programs.conf differ       
Files /home/gizmo/backup/.config/hypr/hyprland.conf.d/rules.conf and /home/gizmo/.config/hypr/hyprland.conf.d/rules.conf differ
Files /home/gizmo/backup/.config/hypr/hyprlock.conf and /home/gizmo/.config/hypr/hyprlock.conf differ
Only in /home/gizmo/.config/hypr/: hyprpaper.conf
Only in /home/gizmo/backup/.config/hypr/: icons
Only in /home/gizmo/.config/hypr/scripts: hyprlock-lock.sh
Only in /home/gizmo/.config/hypr/scripts: hyprlock-unlock.sh
Files /home/gizmo/backup/.config/hypr/scripts/monitor-profile.sh and /home/gizmo/.config/hypr/scripts/monitor-profile.sh differ
Only in /home/gizmo/backup/.config/hypr/scripts: movewin_to_monitor.sh
Only in /home/gizmo/.config/hypr/scripts: obsbot-reset.sh
Files /home/gizmo/backup/.config/hypr/scripts/toggle_waybar.sh and /home/gizmo/.config/hypr/scripts/toggle_waybar.sh differ
Files /home/gizmo/backup/.config/hypr/scripts/toggle_ytmdesktop.sh and /home/gizmo/.config/hypr/scripts/toggle_ytmdesktop.sh differ         
Only in /home/gizmo/backup/.config/hypr/: systemd
Only in /home/gizmo/backup/.config/hypr/: upgrading
Files /home/gizmo/backup/.config/hypr/waybar/config.jsonc and /home/gizmo/.config/hypr/waybar/config.jsonc differ
Only in /home/gizmo/backup/.config/hypr/waybar: icons
Files /home/gizmo/backup/.config/hypr/waybar/style.css and /home/gizmo/.config/hypr/waybar/style.css differ
```

