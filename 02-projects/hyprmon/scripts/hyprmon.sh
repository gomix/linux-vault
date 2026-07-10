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
