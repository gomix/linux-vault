---
tags:
  - bluetooth
---
# Sencor SSB 4450BS

The Sencor SSB 4450BS is a compact 2.1-channel soundbar designed primarily for TVs. It supports Bluetooth wireless audio and wired connections through HDMI ARC, Optical, AUX, and USB media playback.

## Specifications

- **Manufacturer:** Sencor
- **Model:** SSB 4450BS
- **Type:** 2.1 Channel Soundbar
- **Maximum Power Consumption:** 50 W
- **Country of Design:** Czech Republic (Sencor EU)
- **Manufactured in:** China

## Connectivity

- HDMI ARC
- Bluetooth
- Optical (Toslink)
- AUX input
- USB (media playback)

## Linux Notes

- The USB port is **not** detected as a USB Audio Class (UAC) device under Linux.
- When connected to a Linux PC via USB, no new audio device appears.
- Designed primarily for TV use through HDMI ARC rather than as a USB sound device.

Encender/ Detectar/Pair

```
$ bluetoothctl 
[NEW] Media /org/bluez/hci0 
	SupportedUUIDs: 0000110a-0000-1000-8000-00805f9b34fb
	SupportedUUIDs: 0000110b-0000-1000-8000-00805f9b34fb
Agent registered
[CHG] Controller D0:65:78:7C:22:38 Pairable: yes
hci0 new_settings: powered bondable ssp br/edr le secure-conn wide-band-speech ll-privacy 
[bluetoothctl]> power on
Changing power on succeeded
[bluetoothctl]> agent on
Agent is already registered
[bluetoothctl]> default-agent
Default agent request successful
[bluetoothctl]> scan on
SetDiscoveryFilter success
Discovery started
[CHG] Controller D0:65:78:7C:22:38 Discovering: yes
[bluetoothctl]> devices
[NEW] Device FE:1A:CD:4C:D6:75 SSB 4450BS                                   <<< DETECTED
[bluetoothctl]> connect FE:1A:CD:4C:D6:75
Attempting to connect to FE:1A:CD:4C:D6:75
[CHG] Device FE:1A:CD:4C:D6:75 Connected: yes
[CHG] Device FE:1A:CD:4C:D6:75 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device FE:1A:CD:4C:D6:75 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device FE:1A:CD:4C:D6:75 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device FE:1A:CD:4C:D6:75 ServicesResolved: yes
[CHG] Device 02:D6:AD:C9:BD:2F RSSI: 0xffffffbc (-68)
[CHG] Device FE:1A:CD:4C:D6:75 Bonded: yes
[CHG] Device FE:1A:CD:4C:D6:75 Paired: yes
[NEW] Endpoint /org/bluez/hci0/dev_FE_1A_CD_4C_D6_75/sep1 
[NEW] Endpoint /org/bluez/hci0/dev_FE_1A_CD_4C_D6_75/sep2 
[NEW] Transport /org/bluez/hci0/dev_FE_1A_CD_4C_D6_75/sep1/fd0 
Connection successful
[SSB 4450BS]> scan off
Discovery stopped
[SSB 4450BS]> 
```


