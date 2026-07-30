---
tags:
  - keyboard
  - keybindings
---
# Identifying Keys and Events

## Recommended Tools
* wev
* libinput

## 1. `wev` best  option for Wayland

```bash
sudo dnf install wev
```

Run it:

```bash
wev
```

Press keys and watch:

```text
key: serial: 148; time: 26435; key: 38; state: 1 (pressed)
sym: a (97), utf8: 'a'
```

Very useful , it outputs:

- keycode    
- keysym
- state pressed/released
- generated UTF-8

---
## 2. `libinput debug-events` , lower level

It shows device events directly:

```bash
sudo libinput debug-events
```

Example:

```text
event3  KEYBOARD_KEY     +1.23s KEY_A (30) pressed
```

Advantages:

- Before compositor capture.
- Useful for hardware debugging.
   
Disadvantages:

- Noisy.
- Needs `sudo`.

---

## 3. Wayland Active Bindings

To verify how Hyprland interprets your binds:

```bash
hyprctl binds
```

Very useful to verify:

```ini
bind = SUPER, TAB, cyclenext
```

Or for detecting conflicts.

---

## 4. Detect exact keycodes

With `wev`:

```text
key: 133
```

`133` normally is:

- Left Super

Common examples:

| Tecla   | Keycode Linux |
| ------- | ------------- |
| Super_L | 133           |
| Alt_L   | 64            |
| Ctrl_L  | 37            |
| Enter   | 36            |
| Tab     | 23            |

---

## 5. Debugging on Hyprland

Monitoring events:

```bash
socat - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock
```
