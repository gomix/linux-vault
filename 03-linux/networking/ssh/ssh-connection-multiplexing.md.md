---
tags:
  - ssh
  - networking
  - performance
---

# SSH Connection Multiplexing 

SSH connection multiplexing allows multiple SSH sessions to share a single underlying TCP connection.

The first SSH session establishes and authenticates the connection normally. Subsequent sessions to the same destination reuse that authenticated connection, avoiding another TCP connection, key exchange, and authentication process.

This is especially useful when repeatedly using:

- `ssh`
- `scp`
- `sftp`
- `rsync` over SSH
- Scripts that execute several SSH commands
    

The feature is configured entirely on the **SSH client**. It does not require changes to `sshd` on the remote system.

## How It Works

The first SSH connection becomes the **master connection** and creates a local Unix socket.

Additional SSH clients connect to that socket and request a new logical session through the already-established connection.

Three SSH client options control this behavior:

- `ControlMaster` enables connection sharing.
    
- `ControlPath` defines the Unix socket location.
    
- `ControlPersist` keeps the master connection alive after the initial session closes.
    

## Configuration

Create a private directory for the control sockets:

```bash
mkdir -p ~/.ssh/controlmasters
chmod 700 ~/.ssh/controlmasters
```

Add the following configuration to `~/.ssh/config`:

```sshconfig
Host *
    ControlMaster auto
    ControlPath ~/.ssh/controlmasters/%C
    ControlPersist 30m
```

Ensure the configuration file has appropriate permissions:

```bash
chmod 600 ~/.ssh/config
```

### Configuration Options

#### `ControlMaster auto`

```sshconfig
ControlMaster auto
```

SSH first looks for an existing master connection.

- If a master exists, SSH reuses it.
    
- If one does not exist, SSH establishes a normal connection and makes it the master.
    
- If multiplexing cannot be used, SSH falls back to a regular connection.
    

#### `ControlPath`

```sshconfig
ControlPath ~/.ssh/controlmasters/%C
```

This defines the Unix socket used to communicate with the master connection.

`%C` generates a hash based on the connection parameters, including the local host, remote host, remote port, and remote user.

Using `%C` avoids Unix socket path-length problems that can occur with longer values such as:

```sshconfig
ControlPath ~/.ssh/controlmasters/%r@%h:%p
```

The control socket must be stored in a directory that other users cannot modify.

#### `ControlPersist 30m`

```sshconfig
ControlPersist 30m
```

This keeps the master connection running in the background for 30 minutes after the last SSH session closes.

Other possible values include:

```sshconfig
ControlPersist 10m
ControlPersist 1h
ControlPersist yes
```

When set to `yes`, the master remains active until it is explicitly stopped or the client system is restarted.

## Host-Specific Configuration

Multiplexing can be enabled only for selected systems:

```sshconfig
Host ser9
    HostName ser9.example.com
    User gizmo

    ControlMaster auto
    ControlPath ~/.ssh/controlmasters/%C
    ControlPersist 30m
```

This is preferable when multiplexing should not apply to every SSH destination.

## Verify the Effective Configuration

Use `ssh -G` to display the configuration SSH will use:

```bash
ssh -G ser9 |
    grep -E '^(controlmaster|controlpath|controlpersist) '
```

Expected output:

```text
controlmaster auto
controlpath /home/gizmo/.ssh/controlmasters/...
controlpersist 1800
```

The duration may be displayed in seconds.

## Create the Master Connection

Open a normal SSH session:

```bash
ssh ser9
```

The first connection performs the regular key exchange and authentication.

After exiting the session, `ControlPersist` keeps the master connection running in the background:

```bash
exit
```

A control socket should now exist:

```bash
ls -l ~/.ssh/controlmasters/
```

## Check the Master Connection

Use the SSH control command:

```bash
ssh -O check ser9
```

Expected output:

```text
Master running (pid=12345)
```

If no master connection exists, the command reports an error similar to:

```text
Control socket connect(...): No such file or directory
```

## Confirm That a Connection Is Reused

Run a second connection with verbose output:

```bash
ssh -v ser9 true
```

The output should contain messages similar to:

```text
auto-mux: Trying existing master
mux_client_request_session: master session id
```

These messages confirm that SSH is communicating with the existing master instead of creating a new TCP connection.

For more detail:

```bash
ssh -vv ser9 true
```

## Compare Connection Times

Measure the first connection:

```bash
time ssh ser9 true
```

Immediately execute it again:

```bash
time ssh ser9 true
```

The second command should be considerably faster because it avoids repeating the connection setup, key exchange, and authentication.

## Start a Master Explicitly

A master connection can also be created without opening an interactive shell:

```bash
ssh -MNf ser9
```

Options used:

- `-M` enables master mode.
    
- `-N` prevents execution of a remote command.
    
- `-f` moves SSH to the background after authentication.
    

Verify it with:

```bash
ssh -O check ser9
```

## Stop the Master Connection

Terminate the master connection manually:

```bash
ssh -O exit ser9
```

Expected output:

```text
Exit request sent.
```

Verify that it has stopped:

```bash
ssh -O check ser9
```

## Using Multiplexing with `rsync`

No additional `rsync` configuration is required. Because `rsync` invokes SSH as its transport, it automatically uses the SSH client configuration:

```bash
rsync -aAXHv \
    --delete \
    --numeric-ids \
    --info=progress2 \
    /home/"$USER"/ \
    ser9:/home/"$USER"/
```

If a master connection to `ser9` already exists, `rsync` reuses it.

This is particularly useful when running several backup or synchronization commands consecutively.

## Important Considerations

### Connections must represent the same destination

A master connection is associated with a particular combination of:

- Remote hostname
    
- Remote username
    
- Remote SSH port
    
- Local client
    

For example, these may produce separate master connections:

```bash
ssh ser9
ssh gizmo@192.168.1.20
```

Even if both names ultimately reach the same machine, SSH may treat them as different destinations.

Using a consistent host alias from `~/.ssh/config` prevents this problem.

### Configuration changes may not take effect immediately

An existing master connection continues using the settings with which it was originally established.

After modifying relevant SSH options, close the existing master:

```bash
ssh -O exit ser9
```

Then establish a new connection.

### Protect the control socket

Anyone capable of accessing the control socket may potentially open additional sessions through the authenticated master connection.

For this reason:

```bash
chmod 700 ~/.ssh/controlmasters
```

The directory must never be writable by other users.

### Multiplexing is not terminal persistence

Connection multiplexing does not preserve a shell session or a running interactive application after disconnection.

For persistent terminal sessions, use a tool such as:

```bash
tmux
```

or:

```bash
screen
```

SSH multiplexing preserves and reuses the **network connection**; `tmux` preserves the **terminal session**.

## Recommended Configuration

```sshconfig
Host *
    ServerAliveInterval 30
    ServerAliveCountMax 3

    ControlMaster auto
    ControlPath ~/.ssh/controlmasters/%C
    ControlPersist 30m
```

`ServerAliveInterval` and `ServerAliveCountMax` are separate from multiplexing. They help SSH detect connections that have become unresponsive.

## Quick Verification Procedure

```bash
ssh ser9
```

Close the interactive session:

```bash
exit
```

Confirm that the master remains active:

```bash
ssh -O check ser9
```

Verify that a new session reuses it:

```bash
ssh -v ser9 true 2>&1 |
    grep -E 'auto-mux|mux_client'
```

Finally, stop the master:

```bash
ssh -O exit ser9
```

## Reference

- [OpenSSH `ssh_config(5)` manual](https://man.openbsd.org/ssh_config)
    
- [OpenSSH `ssh(1)` manual](https://man.openbsd.org/ssh)

```

```