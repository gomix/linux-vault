Useful for cli users to know if there is the need to restart after and upgrade task.

```bash
$ sudo dnf needs-restarting -r
Updating and loading repositories:
Repositories loaded.
No core libraries or services have been updated since boot-up.
Reboot should not be necessary.

$ echo $?
0            ; <--no need for reboot
```
Be aware you probably will not get the same result checking with a regular user:
```bash
$ dnf needs-restarting -r
Updating and loading repositories:
Repositories loaded.
Core libraries or services have been updated since boot-up:
  * amd-gpu-firmware
  * amd-ucode-firmware
  * atheros-firmware
  * brcmfmac-firmware
  * cirrus-audio-firmware
  * glibc
  * intel-audio-firmware
  * intel-gpu-firmware
  * intel-vsc-firmware
  * iwlegacy-firmware
  * iwlwifi-dvm-firmware
  * iwlwifi-mld-firmware
  * iwlwifi-mvm-firmware
  * kernel
  * kernel-core
  * kernel-headers
  * kernel-modules
  * kernel-modules-core
  * kernel-modules-extra
  * kernel-tools
  * kernel-tools-libs
  * libertas-firmware
  * libjxl
  * libxcrypt-devel
  * linux-firmware
  * linux-firmware-whence
  * mt7xxx-firmware
  * nvidia-gpu-firmware
  * nxpwireless-firmware
  * python3-perf
  * qcom-wwan-firmware
  * realtek-firmware
  * rpm-sequoia
  * systemd
  * tiwilink-firmware

Reboot is required to fully utilize these updates.
More information: https://access.redhat.com/solutions/27943

$ echo $?
1      ;Reboot recommended
```
