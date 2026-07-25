fwupdmgr - firmware update manager client utility

Why i am writing about it?

Motivation
USB Switch not working conecting directly USB-A - USB-C to my laptop.
I need to verify firmware of my ThinkPad.

```
; after updating them...
$ fwupdmgr get-devices
LENOVO 21E9S0PK1F
│
├─0670:00 04F3:3150:
│     Device ID:          1deb68aaada5acf7b8e3ee880f4f74ae867021d8
│     Current version:    0x0003
│     Bootloader Version: 0x0001
│     Vendor:             Elan (HIDRAW:0x04F3)
...
...
...

%> fwupdmgr get-history
LENOVO 21E9S0PK1F
│
├─Prometheus:
│ │   Device ID:          65a54fb6ce182f0e75edf0e43047d547a0d61f0e
│ │   Previous version:   10.01.3273255
│ │   Update State:       Success
│ │   Last modified:      2023-12-13 08:38:37
│ │   GUID:               8088f861-6318-5b1e-9ce4-fbddbedb09ac
│ │   Device Flags:       • Supported on remote server
│ │                       • Reported to remote server
│ │                       • Cryptographic hash verification is available
│ │                       • Updatable
│ │                       • Signed Payload
│ │
...
...
...

```