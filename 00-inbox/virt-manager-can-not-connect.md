Environment: Fedora 43
Running virt-manager from a regular user can't connect to the running `libvirtd` service:

```
$ sudo usermod -aG libvirt $USER
```