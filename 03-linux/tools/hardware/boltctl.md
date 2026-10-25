**boltctl** is the command-line utility for managing Thunderbolt devices on Linux. It works with the boltd service to detect, authorize, and manage Thunderbolt peripherals according to the system's security policy. It can list connected devices, display their status, and authorize or forget trusted devices.

```bash
$ boltctl 
 ○ Lenovo ThinkPad Thunderbolt 3 Dock
   ├─ type:          peripheral
   ├─ name:          ThinkPad Thunderbolt 3 Dock
   ├─ vendor:        Lenovo
   ├─ uuid:          c6030000-0092-9c0e-03ad-2a3d1084f900
   ├─ generation:    Thunderbolt 3
   ├─ status:        disconnected
   ├─ authorized:    Tue 02 Apr 2024 06:40:37 AM UTC
   ├─ connected:     Tue 02 Apr 2024 06:40:37 AM UTC
   └─ stored:        Mon 19 Jun 2023 10:14:14 AM UTC
      ├─ policy:     iommu
      └─ key:        no

 ○ Lenovo ThinkPad Thunderbolt 3 Dock #2
   ├─ type:          peripheral
   ├─ name:          ThinkPad Thunderbolt 3 Dock
   ├─ vendor:        Lenovo
   ├─ uuid:          c1010000-0092-9c1e-839b-f085f0307902
   ├─ generation:    Thunderbolt 3
   ├─ status:        disconnected
   ├─ authorized:    Sat 06 Sep 2025 05:51:13 AM UTC
   ├─ connected:     Sat 06 Sep 2025 05:51:13 AM UTC
   └─ stored:        Wed 13 Sep 2023 03:41:12 PM UTC
      ├─ policy:     iommu
      └─ key:        no
```