## Overview

This vault is designed for:

- durable technical knowledge
- reproducible Linux configurations
- troubleshooting history
- operational runbooks
- personal homelab documentation
- workshops and labs
- shell and automation workflows

The structure prioritizes:

1. fast capture
2. long-term maintainability
3. Git friendliness
4. offline-first usage
5. separation between stable knowledge and temporary investigations
# Root Structure

```text
~/linux-vault
│
├── 00-inbox/
├── 01-daily/
├── 02-projects/
├── 03-linux/
├── 04-automation/
├── 05-homelab/
├── 06-workshops/
├── 07-runbooks/
├── 08-troubleshooting/
├── 09-reference/
├── 10-templates/
├── 11-assets/
├── 12-archive/
│
├── .obsidian/
├── README.md
└── index.md
````

---

# [00-inbox/](00-inbox/README.md)

Capture area.
Everything lands here first.

---
# [01-daily/](01-daily/README.md)

Daily technical journal.

Useful for:

- troubleshooting timelines    
- learning tracking
- commands used during the day
- operational notes
- temporary findings

---
# [02-projects/](02-projects/README.md)

Active projects with lifecycle and ownership.

Examples:

```text
02-projects/
├── hyprland-setup/
├── fedora-reinstall/
├── homelab-network-redesign/
└── obsidian-workflow/
```

Typical internal structure:

```text
project-name/
├── README.md
├── notes/
├── diagrams/
├── snippets/
├── references/
└── tasks.md
```

---
# 03-linux/

Core Linux knowledge base.

Organized by technical domain.

```text
03-linux/
├── fedora/
├── hyprland/
├── vim/
├── shell/
├── systemd/
├── networking/
├── storage/
├── containers/
├── virtualization/
├── hardware/
└── troubleshooting/
```

Examples:

```text
03-linux/hyprland/
├── monitors.md
├── workspaces.md
├── waybar.md
├── clipboard.md
└── rules.md
```

---
# 04-automation/

Automation-specific content.

```text
04-automation/
├── ansible/
├── scripts/
├── ci-cd/
├── containerfiles/
├── automation-patterns/
└── taskwarrior/
```

Examples:

```text
04-automation/scripts/
├── backup-script.md
├── media-sync.md
└── workstation-bootstrap.md
```

---
# 05-homelab/

Personal infrastructure and local systems.

```text
05-homelab/
├── servers/
├── networking/
├── backup/
├── monitoring/
├── media/
├── fedora-workstation/
└── infrastructure/
```

Examples:

```text
05-homelab/networking/
├── vlan-layout.md
├── firewall-rules.md
└── wifi-coverage.md
```

---
# 06-workshops/

Reusable workshop and lab material.

```text
06-workshops/
├── linux/
├── automation/
├── virtualization/
├── containers/
└── networking/
```

Example:

```text
06-workshops/linux/
├── shell-basics/
├── vim-workshop/
└── systemd-intro/
```

---

# 07-runbooks/

Stable operational procedures.
Runbooks are not investigations.
They are repeatable procedures.

```text
07-runbooks/
├── linux/
├── networking/
├── backup/
├── virtualization/
├── containers/
└── recovery/
```

Examples:

```text
07-runbooks/linux/
├── recover-grub.md
├── troubleshoot-wayland.md
├── reset-networkmanager.md
└── debug-systemd.md
```

---
# 08-troubleshooting/

Temporary investigations and incidents.
Very important to keep separate from stable knowledge.

```text
08-troubleshooting/
└── 2026/
    ├── hyprland-paste-issue/
    ├── obsidian-wayland/
    ├── pipewire-audio/
    └── bluetooth-headset/
```

Typical structure:

```text
issue-name/
├── timeline.md
├── findings.md
├── logs.md
├── screenshots/
└── resolution.md
```

---
# 09-reference/

Quick reference material.

```text
09-reference/
├── commands/
├── cheatsheets/
├── snippets/
├── links/
└── glossary/
```

Examples:

```text
09-reference/commands/
├── systemctl.md
├── journalctl.md
├── podman.md
├── git.md
└── jq.md
```

---
# 10-templates/

Reusable note templates.

```text
10-templates/
├── daily-note.md
├── runbook.md
├── troubleshooting.md
├── workshop.md
└── project.md
```

---
# 11-assets/

Local assets and images.
Offline-first and Git-friendly.

```text
11-assets/
├── screenshots/
├── diagrams/
├── wallpapers/
├── pdfs/
└── images/
```

Naming convention example:

```text
2026-05-20-hyprland-layout.png
2026-05-20-waybar-config.png
```

---
# 12-archive/

Archived or deprecated content.
Never delete useful history.

```text
12-archive/
├── completed-projects/
├── old-notes/
└── deprecated-configs/
```

---
# Suggested Naming Convention

Use:

```text
kebab-case.md
```

Examples:

```text
hyprland-monitor-layouts.md
pipewire-bluetooth-debug.md
vim-text-objects.md
systemd-user-services.md
```

---

# Recommended Technical Note Structure

```md
# Title

## Context

## Problem

## Investigation

## Commands

## Findings

## Resolution

## References
```

---
# Suggested Tags

Keep tags minimal and functional.

Examples:

```text
#linux
#fedora
#hyprland
#vim
#automation
#homelab
#runbook
#troubleshooting
```

Avoid excessive tagging.

---

# Recommended Plugins

Recommended plugins:

- Obsidian Git 
- Advanced Tables
- Templater
- Dataview
- QuickAdd
- Excalidraw
- Tag Wrangler

Avoid excessive plugin usage.

---

# Git Recommendations

Suggested `.gitignore`:

```gitignore
.obsidian/workspace.json
.obsidian/cache
```

Version control recommended for:

```text
.obsidian/app.json
.obsidian/hotkeys.json
.obsidian/community-plugins.json
```

This improves reproducibility across systems.

---
# Main Philosophy

The vault should help answer:

- how did I solve this before?
- what command worked?
- how do I reproduce this configuration?
- what did I learn?
- what is still active?

The goal is operational usefulness, not building an infinite encyclopedia.