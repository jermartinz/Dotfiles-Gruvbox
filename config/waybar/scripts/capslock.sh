#!/usr/bin/env bash
# Detecta CAPS leyendo los LEDs del sistema (0=off, 1=on)
# Requiere: bash; no necesita root.

is_on=0
for f in /sys/class/leds/*capslock*/brightness; do
  [ -r "$f" ] || continue
  v="$(cat "$f" 2>/dev/null || echo 0)"
  if [ "$v" -gt 0 ]; then
    is_on=1
    break
  fi
done

if [ "$is_on" -eq 1 ]; then
  # Activo -> muestra texto
  echo " CAPS"
else
  # Inactivo -> no muestra nada
  echo ""
fi
