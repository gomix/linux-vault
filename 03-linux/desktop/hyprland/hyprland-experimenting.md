This tech note is about experimenting with your hyprland configuration without touching configuration files.

## `smart_resizing`

```
$ hyprctl keyword master:smart_resizing true
ok
```

## Moving window to a monitor

```
; you are going to need the address of the window to be moved
$ hyprctl clients -j | jq -r '.[] | "\(.address) - \(.title)"'
0x55a9ef727910 - ~/.config/hypr
0x55a9ef5bb660 - hyprland-experimenting - linux-vault - Obsidian 1.12.7

; monitor name will be needed too
$ hyprctl monitors -j | jq -r .[].name
eDP-1
DP-3

; focus and move it
$ hyprctl dispatch focuswindow "address:0x55a9ef5bb660" ; hyprctl dispatch movewindow "mon:eDP-1"
ok
ok
```