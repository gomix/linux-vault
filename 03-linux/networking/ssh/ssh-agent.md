# ssh-agent

Keeps unlocked SSH private keys in memory so you can reuse them without re-entering their passphrases. SSH clients reach the agent through `SSH_AUTH_SOCK`.

```bash
eval "$(ssh-agent -s)"          # Start an agent if none is available
ssh-add -t 1h ~/.ssh/id_ed25519 # Load a key for one hour
ssh-add -l                     # List loaded keys
ssh-add -D                     # Remove all keys from the agent
```