---
title: Force Kitty to Open URLs with a Specific Google Chrome Profile
tags:
  - linux
  - fedora
  - google-chrome
  - kitty
  - wayland
  - configuration
  - tips
---
# Force Kitty to Open URLs with a Specific Google Chrome Profile

## Problem

When using **Kitty**, clicking URLs launches Google Chrome using the wrong browser profile.

This typically happens when multiple Chrome profiles are configured. Instead of opening links in the desired profile, Chrome may reuse another running instance.

---

## Environment

- Fedora Linux
- Kitty terminal
- Google Chrome with multiple profiles

Example profiles:

| Chrome Directory | Profile         |
| ---------------- | --------------- |
| `Default`        | Gizmo @ Red Hat |
| `Profile 1`      | Guillermo       |

---

## Identify Available Chrome Profiles

To list Chrome profile directories:

```bash
ls ~/.config/google-chrome
```

To display the friendly names associated with each profile:

```bash
cat ~/.config/google-chrome/'Local State' | jq '.profile.info_cache'
```

Example output (relevant fields only):

```json
{
  "Default": {
    "name": "Gizmo @ Red Hat"
  },
  "Profile 1": {
    "name": "Guillermo"
  }
}
```

---

## Solution

Create a small wrapper script that always launches Chrome using the desired profile.

### Wrapper Script

Create:

```text
~/bin/open-url
```

Contents:

```bash
#!/usr/bin/env bash

exec google-chrome \
    --profile-directory="Default" \
    "$@"
```

Make it executable:

```bash
chmod +x ~/bin/open-url
```

---

## Configure Kitty

Edit:

```text
~/.config/kitty/kitty.conf
```

Add:

```conf
open_url_with ~/bin/open-url
```

Reload the configuration:

```bash
kitty @ load-config
```

or simply open a new Kitty window.

---
## Troubleshooting

If Chrome still opens links in an unexpected profile, verify:

```bash
cat ~/.config/google-chrome/'Local State' | jq '.profile.info_cache'
```

and confirm that the wrapper references the correct directory:

```bash
google-chrome --profile-directory="Default"
```

If multiple Chrome instances are already running, Chrome's remote instance mechanism may influence which existing window receives the URL. In most cases, using a wrapper with `open_url_with` is sufficient.

---