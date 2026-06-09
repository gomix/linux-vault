# Installing

## RHEL 9.8

```bash
$ sudo subscription-manager repos --enable=rhel-9-for-x86_64-extensions-rpms
$ sudo dnf install goose-redhat

$ goose --version
 1.23.2

$ goose info
goose Version:
  Version:                  1.23.2

Paths:
Config dir:              /root/.config/goose                              
Config yaml:             /root/.config/goose/config.yaml                  
Sessions DB (sqlite):    /root/.local/share/goose/sessions/sessions.db    
Logs dir:                /root/.local/state/goose/logs 
```
## Using `RHEL-command-line-assistant` model

No need to configure anything, just use.

goose run

### Non interactive session mode

```bash
$ goose run -t 'What is the current OS version and kernel release?'
starting session | provider: rhel_cla model: RHEL-command-line-assistant
    session id: 20260609_2
    working directory: /root
To determine the current OS version and kernel release on a Red Hat Enterprise Linux system, you can use the following commands:

For the OS version:

cat /etc/redhat-release

For the kernel release:

uname -r
```

### Interactive session mode

```
$ goose s     
starting session | provider: rhel_cla model: RHEL-command-line-assistant
    session id: 20260609_3
    working directory: /home/gizmo

goose is running! Enter your instructions, or try asking what goose can do.

⚠️ This tool uses AI technology. Do not include any personal information or other sensitive information in your input. Interactions may be used to improve Red Hat's products or services.

Context: ○○○○○○○○○○ 0% (0/128000 tokens)
( O)> can you modify the configuration of the os?
I cannot directly modify the configuration of an operating system. My role is to provide information and guidance related to Red Hat Enterprise Linux, RHEL, and other Red Hat products, as well as general Linux topics. I can help you understand how to modify your OS configuration, explain relevant tools and commands, or troubleshoot issues.

What specific configuration changes are you interested in making?

⏱️  Elapsed time: 16.06s
Always review AI-generated content prior to use.
Context: ●○○○○○○○○○ 5% (6274/128000 tokens)
( O)> I mean if you can directly edit a configuration file on the OS
No, I cannot directly edit configuration files on your operating system. I am an AI assistant and do not have direct access to your system or its files.

However, I can provide you with instructions, commands, and best practices for editing configuration files on Red Hat Enterprise Linux. Just tell me which configuration file or what kind of change you're looking to make, and I'll do my best to guide you.

⏱️  Elapsed time: 10.73s
Always review AI-generated content prior to use.
Context: ●○○○○○○○○○ 5% (6414/128000 tokens)
( O)> exit
Closing session. Session ID: 20260609_3
```

> You can use other providers/models, go with `goose configure` command

References
* [Optimize the RHEL command-line assistant tasks by using goose-redhat](https://access.redhat.com/articles/7142302)
* https://goose-docs.ai/
