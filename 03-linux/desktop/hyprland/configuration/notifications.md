---
tags:
  - linux
  - hyprland
  - notifications
  - swaync
---
# Notifications

My Hyprland desktop uses **SwayNotificationCenter (`swaync`)** as the notification daemon.

## Configuration

The main configuration files are:

    ~/.config/swaync/config.json
    ~/.config/swaync/style.css

## Starting swaync

swaync is started from the Hyprland configuration:

    exec-once = swaync