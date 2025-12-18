#!/usr/bin/env bash

WALLPAPER="$(dirname "$0")/wallhave-mdjrqy.jpg"

# set wallpaper
swww img "$WALLPAPER" --transition-type grow

# generate palette
wal -i "$WALLPAPER" \
    --contrast \
    --backend wal \
    --saturate 0.8

# reload apps
pkill -USR2 waybar || true
hyprctl reload
