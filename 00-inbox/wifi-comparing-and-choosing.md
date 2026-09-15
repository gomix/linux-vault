---
tags:
  - linux
  - networking
  - wifi
  - wireless
  - cli
  - troubleshooting
---

# WiFi Nets, compare and choose

Mission, choose between two available WiFi networks, my home office case.

* Location, my desk, i can not move closer to the WiFi AP.

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

First observation, signal strength favours 2.4 GHz net.
## RF exact data

### 5GHz net

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

### 2.4 GHz net

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

|     | Metric             |  O2 2.4 GHz |              O2 5 GHz |     |
| --- | :----------------- | ----------: | --------------------: | --- |
|     | Frequency          |    2412 MHz |              5260 MHz |     |
|     | Channel            |           1 |                    52 |     |
|     | **RSSI**           | **−64 dBm** |           **−83 dBm** |     |
|     | RX PHY             | **78 Mbps** |             40.5 Mbps |     |
|     | TX PHY             |     65 Mbps |               65 Mbps |     |
|     | RX mode            |     802.11n |              802.11ac |     |
|     | Observed Bandwidth |           — | 40 MHz RX / 80 MHz TX |     |

```
%> ip route l
default via 10.0.0.138 dev wlp0s20f3 proto dhcp src 10.0.0.44 metric 600 
10.0.0.0/24 dev wlp0s20f3 proto kernel scope link src 10.0.0.44 metric 600 
127.0.0.0/8 dev lo proto kernel scope link src 127.0.0.1 metric 30 
```

## ping tests

```
; connected to 2.4GHz net
%> ping -c 100 -i 0.2 -q 10.0.0.138
PING 10.0.0.138 (10.0.0.138) 56(84) bytes of data.

--- 10.0.0.138 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 19896ms
rtt min/avg/max/mdev = 1.079/4.885/15.112/2.867 ms

; connected to 5GHz net
%> ping -c 100 -i 0.2 -q 10.0.0.138
PING 10.0.0.138 (10.0.0.138) 56(84) bytes of data.

--- 10.0.0.138 ping statistics ---
100 packets transmitted, 99 received, 1% packet loss, time 19886ms
rtt min/avg/max/mdev = 1.040/6.811/203.686/20.684 ms, pipe 2
%> ping -c 100 -i 0.2 -q 10.0.0.138
PING 10.0.0.138 (10.0.0.138) 56(84) bytes of data.

--- 10.0.0.138 ping statistics ---
100 packets transmitted, 91 received, 9% packet loss, time 19939ms
rtt min/avg/max/mdev = 1.257/16.300/314.575/53.384 ms, pipe 2
```

* 5 GHz net has up to 9% packet loss !
## Upload/Download Tests with https://speed.cloudflare.com/:

```
; download
2.4 GHz   55.8 Mbps  ████████████████████
5 GHz     26.9 Mbps  ██████████

; upload, nearly identical
2.4 GHz   19.9 Mbps
5 GHz     19.5 Mbps
```

# Conclusions

* 5 GHz has a very poor coverage so potential is barely usable.
* 2.4 GHz is the clear winner.
* AP is the same, so 5 GHz reach is way more limited compared to 2.4 GHz net.