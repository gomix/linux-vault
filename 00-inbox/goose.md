# Installing

## RHEL 9.8

```bash
$ sudo subscription-manager repos --enable=rhel-9-for-x86_64-extensions-rpms
$ sudo dnf install goose-redhat
# goose --version
 1.23.2
```
## Using `RHEL-command-line-assistant`model

No need to configure anything just use:

```bash
# goose run -t 'What is the current OS version and kernel release?'
starting session | provider: rhel_cla model: RHEL-command-line-assistant
    session id: 20260609_2
    working directory: /root
To determine the current OS version and kernel release on a Red Hat Enterprise Linux system, you can use the following commands:

For the OS version:

cat /etc/redhat-release

For the kernel release:

uname -r
```

> First stop, `goose` does not bring any model, you need to connect to one.

References
* https://access.redhat.com/articles/7142302
* https://goose-docs.ai/