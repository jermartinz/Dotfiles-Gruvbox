#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-2"
theme='style-6'

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options
shutdown='⏻'
reboot='󰑙'
lock=''
suspend=''
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "Uptime: $uptime" \
    -mesg "Uptime: $uptime" \
    -theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Ejecutar Comando
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    case "$1" in
    --shutdown)
      systemctl poweroff
      ;;
    --reboot)
      systemctl reboot
      ;;
    --suspend)
      mpc -q pause 2>/dev/null
      amixer set Master mute 2>/dev/null
      systemctl suspend
      ;;
    --logout)
      hyprctl dispatch exit
      ;;
    esac
  else
    exit 0
  fi
}

# Acciones
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$lock)
  if command -v hyprlock &>/dev/null; then
    hyprlock
  elif command -v swaylock &>/dev/null; then
    swaylock
  elif command -v i3lock &>/dev/null; then
    i3lock
  fi
  ;;
$suspend)
  run_cmd --suspend
  ;;
$logout)
  run_cmd --logout
  ;;
esac
