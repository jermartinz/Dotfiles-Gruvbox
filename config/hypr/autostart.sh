#!/bin/bash

sleep 1

pgrep -x dunst >/dev/null || dunst &

pgrep -f hyprpaper >/dev/null || hyprpaper &

pgrep -x waybar >/dev/null || waybar &

pgrep -f hyprsunset >/dev/null || hyprsunset &

pgrep -x nm-applet >/dev/null || nm-applet &
