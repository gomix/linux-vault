#!/usr/bin/env bash
set -euo pipefail

MONITORS_JSON="$(hyprctl monitors -j)"

h() { hyprctl "$@" >/dev/null; }

log() {
    logger -t hyprmon "$*"
}

EVENT="${1:-manual}"
log "started event=$EVENT"

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


# Laptop monitor
LAPTOP_NAME="eDP-1"

# Find external monitors detected by Hyprland
EXTERNAL_OUTPUTS="$(echo "$MONITORS_JSON" | jq -r '.[] | select(.name != "eDP-1") | .name')"

OFFICE_DP=""
HOME_DP=""

for output in $EXTERNAL_OUTPUTS; do
    echo "Checking output: $output"
    edid_text="$(get_edid_text "$output" || true)"
    echo "$edid_text" | grep -E 'Display Product Name|Model|Serial|LS34A650U|LS49C95xU|H4ZRA06381|HNTY300517' || true

    monitor_type="$(detect_monitor_type "$output")"
    echo "Detected type for $output: $monitor_type"

    case "$monitor_type" in
        office)
            OFFICE_DP="$output"
            log "office monitor detected output=$OFFICE_DP"
            ;;
        home)
            HOME_DP="$output"
            log "home monitor detected output=$HOME_DP"
            ;;
    esac
done

if [[ -n "$OFFICE_DP" ]]; then
    echo "Office monitor detected on $OFFICE_DP"

    h keyword monitor "${LAPTOP_NAME}, preferred, 0x0, 1" 
    h keyword monitor "${OFFICE_DP},3440x1440@100,2160x0,1,bitdepth,10" 

    h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true" 
    h keyword workspace "2, monitor:${OFFICE_DP}, default:true, persistent:true, layout:master, layoutopt:orientation:left" 
    h keyword workspace "3, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left" 
    h keyword workspace "4, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left" 
    h keyword workspace "5, monitor:${OFFICE_DP}, persistent:true, layout:master, layoutopt:orientation:left" 

elif [[ -n "$HOME_DP" ]]; then
    echo "Home monitor detected on $HOME_DP"

    h keyword monitor "${LAPTOP_NAME},preferred,0x0,1"
    #h keyword monitor "${HOME_DP},5120x1440@60,0x-1440,1,bitdepth,10"
    h keyword monitor "${HOME_DP},5120x1440@60,0x-1440,1,bitdepth,8"

    h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true" 
    h keyword workspace "2, monitor:${HOME_DP}, default:true, persistent:true, layout:master, layoutopt:orientation:center" 
    h keyword workspace "3, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center" 
    h keyword workspace "4, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center" 
    h keyword workspace "5, monitor:${HOME_DP}, persistent:true, layout:master, layoutopt:orientation:center" 

else
    echo "No known external monitor detected"
    log "no known external monitor detected"

    h keyword monitor "${LAPTOP_NAME},preferred,0x0,1" 

    h keyword workspace "1, monitor:${LAPTOP_NAME}, default:true, persistent:true, layout:master, layoutopt:orientation:left" 
    h keyword workspace "2, monitor:${LAPTOP_NAME}, persistent:true" 
    h keyword workspace "3, monitor:${LAPTOP_NAME}, persistent:true" 
    h keyword workspace "4, monitor:${LAPTOP_NAME}, persistent:true" 
    h keyword workspace "5, monitor:${LAPTOP_NAME}, persistent:true" 
fi

log "finished event=$EVENT"