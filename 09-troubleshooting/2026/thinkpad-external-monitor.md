# ThinkPad external monitor not detected

## Context

- Fedora 44
- Hyprland
- ThinkPad X1 Nano Gen2
- External monitor connected through USB-C
- Internal display: `eDP-1`

## Symptoms

Hyprland does not detect the external monitor.

`hyprctl monitors all` only reports:

- `eDP-1`

The USB-C partner is detected, but the DRM DisplayPort connectors remain disconnected.

## Troubleshooting model

USB-C connection
    ↓
USB-C partner detection
    ↓
DisplayPort Alt Mode / Thunderbolt
    ↓
DRM connector
    ↓
Hyprland monitor detection

## Commands

### Hyprland

```bash
$ hyprctl monitors all -j | jq -r .[].name
eDP-1
```


```
$ for f in /sys/class/drm/card*-*/status; do
    printf '%-55s %s\n' "$f" "$(cat "$f")"
done
/sys/class/drm/card1-DP-1/status                        disconnected
/sys/class/drm/card1-DP-2/status                        disconnected
/sys/class/drm/card1-DP-3/status                        disconnected
/sys/class/drm/card1-DP-4/status                        disconnected
/sys/class/drm/card1-eDP-1/status                       connected


$ ls -l /sys/class/typec/
total 0
lrwxrwxrwx. 1 root root 0 Sep  7 12:58 port0 -> ../../devices/platform/USBC000:00/typec/port0
lrwxrwxrwx. 1 root root 0 Sep  7 12:58 port1 -> ../../devices/platform/USBC000:00/typec/port1
lrwxrwxrwx. 1 root root 0 Sep  8 08:27 port1-partner -> ../../devices/platform/USBC000:00/typec/port1/port1-partner
```

Disconnecting phisically and watching with dmesg.

```
sudo dmesg -w
[423962.295206] usb 3-3: new high-speed USB device number 102 using xhci_hcd
[423962.438807] usb 3-3: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.50
[423962.438814] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[423962.438815] usb 3-3: Product: 4-Port USB 2.0 Hub
[423962.438816] usb 3-3: Manufacturer: Generic
[423962.441659] hub 3-3:1.0: USB hub found
[423962.442922] hub 3-3:1.0: 4 ports detected
[423962.728091] usb 3-3.1: new high-speed USB device number 103 using xhci_hcd
[423962.814555] usb 3-3.1: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=89.32
[423962.814563] usb 3-3.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[423962.814565] usb 3-3.1: Product: USB2.0 Hub
[423962.816435] hub 3-3.1:1.0: USB hub found
[423962.817127] hub 3-3.1:1.0: 4 ports detected
[423962.894127] usb 3-3.2: new full-speed USB device number 104 using xhci_hcd
[423962.983985] usb 3-3.2: New USB device found, idVendor=046d, idProduct=c33c, bcdDevice=19.01
[423962.983995] usb 3-3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[423962.983997] usb 3-3.2: Product: G512 RGB MECHANICAL GAMING KEYBOARD
[423962.983998] usb 3-3.2: Manufacturer: Logitech
[423962.983999] usb 3-3.2: SerialNumber: 0E8335613830
[423962.993873] input: Logitech G512 RGB MECHANICAL GAMING KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.0/0003:046D:C33C.0043/input/input125
[423963.080717] hid-generic 0003:046D:C33C.0043: input,hidraw1: USB HID v1.11 Keyboard [Logitech G512 RGB MECHANICAL GAMING KEYBOARD] on usb-0000:00:14.0-3.2/input0
[423963.082324] input: Logitech G512 RGB MECHANICAL GAMING KEYBOARD Keyboard as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.1/0003:046D:C33C.0044/input/input126
[423963.095119] usb 3-3.1.1: new high-speed USB device number 105 using xhci_hcd
[423963.134091] hid-generic 0003:046D:C33C.0044: input,hiddev96,hidraw2: USB HID v1.11 Keyboard [Logitech G512 RGB MECHANICAL GAMING KEYBOARD] on usb-0000:00:14.0-3.2/input1
[423963.173859] usb 3-3.1.1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
[423963.173869] usb 3-3.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[423963.173870] usb 3-3.1.1: Product: USB 10/100/1000 LAN
[423963.173872] usb 3-3.1.1: Manufacturer: Realtek
[423963.173873] usb 3-3.1.1: SerialNumber: 001000001
[423963.246096] usb 3-3.3: new full-speed USB device number 106 using xhci_hcd
[423963.333643] usb 3-3.3: New USB device found, idVendor=046d, idProduct=c092, bcdDevice=73.00
[423963.333652] usb 3-3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[423963.333653] usb 3-3.3: Product: G203 LIGHTSYNC Gaming Mouse
[423963.333655] usb 3-3.3: Manufacturer: Logitech
[423963.333656] usb 3-3.3: SerialNumber: 14DDCF222165
[423963.341234] input: Logitech G203 LIGHTSYNC Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.3/3-3.3:1.0/0003:046D:C092.0045/input/input129
[423963.341750] hid-generic 0003:046D:C092.0045: input,hidraw3: USB HID v1.11 Mouse [Logitech G203 LIGHTSYNC Gaming Mouse] on usb-0000:00:14.0-3.3/input0
[423963.343059] input: Logitech G203 LIGHTSYNC Gaming Mouse Keyboard as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.3/3-3.3:1.1/0003:046D:C092.0046/input/input130
[423963.393786] r8152-cfgselector 3-3.1.1: reset high-speed USB device number 105 using xhci_hcd
[423963.395911] hid-generic 0003:046D:C092.0046: input,hiddev97,hidraw4: USB HID v1.11 Keyboard [Logitech G203 LIGHTSYNC Gaming Mouse] on usb-0000:00:14.0-3.3/input1
[423963.543001] usb 3-3.4: new high-speed USB device number 107 using xhci_hcd
[423963.645136] usb 3-3.4: New USB device found, idVendor=0458, idProduct=6007, bcdDevice=50.02
[423963.645145] usb 3-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[423963.645146] usb 3-3.4: Product: Genius Webcam
[423963.645148] usb 3-3.4: Manufacturer: KYE Systems corp.
[423963.645149] usb 3-3.4: SerialNumber: Genius Audio
[423963.648126] uvcvideo 3-3.4:1.0: Found UVC 1.00 device Genius Webcam (0458:6007)
[423963.691995] usb 3-3.1.2: new full-speed USB device number 108 using xhci_hcd
[423963.783254] usb 3-3.1.2: New USB device found, idVendor=04e8, idProduct=f649, bcdDevice= 0.00
[423963.783264] usb 3-3.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[423963.783266] usb 3-3.1.2: Product: Samsung Type-C Monitor
[423963.783268] usb 3-3.1.2: Manufacturer: Cypress Semiconductor
[423963.783269] usb 3-3.1.2: SerialNumber: 11AD1D0463982F1516070B00
[423963.799144] hid-generic 0003:04E8:F649.0047: hiddev98,hidraw5: USB HID v1.11 Device [Cypress Semiconductor Samsung Type-C Monitor] on usb-0000:00:14.0-3.1.2/input1
[423963.904447] r8152 3-3.1.1:1.0 enp0s20f0u3u1u1: renamed from eth0
[423966.804082] r8152 3-3.1.1:1.0 enp0s20f0u3u1u1: carrier on
[424021.727418] usb 3-3.1.2: USB disconnect, device number 108
```