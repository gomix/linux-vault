Objetivo, escoger entre dos redes WiFi disponibles.

* Ubciación, mi escritorio, no puedo moverme más cerca del WiFi AP.

```
%> nmcli g
STATE      CONNECTIVITY  WIFI-HW  WIFI     WWAN-HW  WWAN     METERED      
connected  full          enabled  enabled  missing  enabled  no (guessed) 


%> nmcli c show --active
NAME                UUID                                  TYPE      DEVICE    
O2-Internet-5G-040  a9d6b41a-b59d-4dc1-b8d7-c1e697abf91e  wifi      wlp0s20f3 
lo                  1774e9ea-7d82-421a-9e83-b51011c2d003  loopback  lo 

%> nmcli d wifi list
IN-USE  BSSID              SSID                MODE   CHAN  RATE         SIGNAL  BARS  SECURITY  
        14:36:0E:D7:75:F1  O2-Internet-040     Infra  1     270 Mbit/s   60      ▂▄▆_  WPA2      
*       14:36:0E:D7:75:F2  O2-Internet-5G-040  Infra  52    1170 Mbit/s  29      ▂___  WPA2      
```

Primera observación, nivel de potencia de la señal versus potencial PHY rate muchísimo mayor.

## Datos RF exactos

Conectado a O2-Internet-5G-040 (5GHz)

```
%> iw dev wlp0s20f3 link
Connected to 14:36:0e:d7:75:f2 (on wlp0s20f3)
	SSID: O2-Internet-5G-040
	freq: 5260.0
	RX: 99197484 bytes (83120 packets)
	TX: 15244854 bytes (32029 packets)
	signal: -83 dBm
	rx bitrate: 40.5 MBit/s VHT-MCS 2 40MHz VHT-NSS 1
	tx bitrate: 65.0 MBit/s VHT-MCS 1 80MHz short GI VHT-NSS 1
	bss flags: short-slot-time
	dtim period: 1
	beacon int: 100
```

Conectado a O2-Internet-040 (2.4 GHz)

```
%> iw dev wlp0s20f3 link
Connected to 14:36:0e:d7:75:f1 (on wlp0s20f3)
	SSID: O2-Internet-040
	freq: 2412.0
	RX: 103239 bytes (346 packets)
	TX: 119638 bytes (275 packets)
	signal: -64 dBm
	rx bitrate: 78.0 MBit/s MCS 12
	tx bitrate: 65.0 MBit/s MCS 7
	bss flags: short-slot-time
	dtim period: 1
	beacon int: 100
```

| Métrica         |  O2 2.4 GHz |              O2 5 GHz |                                                        
|:--------------- |-----------: |---------------------: |
| Frecuencia      |    2412 MHz |              5260 MHz |
| Canal           |           1 |                    52 |
| **RSSI**        | **−64 dBm** |           **−83 dBm** |
| RX PHY actual   | **78 Mbps** |             40.5 Mbps |
| TX PHY actual   |     65 Mbps |               65 Mbps |
| RX mode         |     802.11n |              802.11ac |
| Ancho observado |           — | 40 MHz RX / 80 MHz TX |

