---
tags:
  - monitors
  - windows
---
## Moving all windows to designated monitor

This is actually a need for me because changing constantly external monitors means that certain apps do not redraw themselves properly, so my workaround is to move them all to the laptop monitor, then disconnect external monitor. 

Next time i connect an external monitor, i can move them back without needing to restart the app.

My active monitors:
```
$ hyprctl monitors -j | jq -r .[].name 
eDP-1
DP-3
```

Script with default target monitor set to eDP-1.

`scripts/movewin_to_monitor.sh`

```bash
#!/usr/bin/env bash

set -euo pipefail

TARGET="${1:-eDP-1}"

# Verify monitor exists
if ! hyprctl monitors -j | jq -e --arg m "$TARGET" '.[] | select(.name == $m)' >/dev/null; then
    echo "Error: monitor '$TARGET' not found."
    exit 1
fi

hyprctl clients -j |
jq -r '.[].address' |
while read -r addr; do
    hyprctl dispatch focuswindow "address:$addr"
    sleep 0.05
    hyprctl dispatch movewindow "mon:$TARGET"
done
```