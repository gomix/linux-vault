# Identifying Keys and Events
## Recommended Tools
* wev
* libinput

## 1. `wev` (la mejor opción en Wayland)

-Instálalo:

```bash
sudo dnf install wev
```

Ejecuta:

```bash
wev
```

Luego presiona teclas y verás algo así:

```text
key: serial: 148; time: 26435; key: 38; state: 1 (pressed)
sym: a (97), utf8: 'a'
```

Muy útil porque muestra:

- keycode    
- keysym
- estado pressed/released
- UTF-8 generado

Para combinaciones Hyprland (`SUPER`, `ALT`, etc.) funciona excelente.

---
## 2. `libinput debug-events` (nivel más bajo)

Esto muestra eventos del dispositivo input directamente:

```bash
sudo libinput debug-events
```

Ejemplo:

```text
event3  KEYBOARD_KEY     +1.23s KEY_A (30) pressed
```

Ventajas:

- Ve teclas incluso antes del compositor
- Útil para debugging hardware
   

Desventajas:

- Más ruidoso
- Necesita sudo

---

## 3. Ver bindings activos de Hyprland

Para verificar cómo Hyprland interpreta tus binds:

```bash
hyprctl binds
```

Muy útil si quieres confirmar:

```ini
bind = SUPER, TAB, cyclenext
```

o detectar conflictos.

---

## 4. Detectar keycodes exactos

Con `wev`:

```text
key: 133
```

Ese `133` normalmente es:

- Left Super
    

Ejemplos comunes:

|Tecla|Keycode Linux|
|---|---|
|Super_L|133|
|Alt_L|64|
|Ctrl_L|37|
|Enter|36|
|Tab|23|

---

## 5. Para debugging específico de Hyprland

Puedes monitorear eventos live:

```bash
socat - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock
```

Y verás eventos internos del compositor.

---

## Tu caso práctico (SUPER+TAB)

Te recomiendo:

```bash
wev
```

Presiona:

- `SUPER`
- `TAB`
- `ALT+TAB`
- `SUPER+TAB`

y observa:

- qué keysym genera
- si hay repeat
- si alguna tecla no llega correctamente

Eso te ayuda mucho cuando un bind no funciona o colisiona con algo en Hyprland o en aplicaciones como kitty.