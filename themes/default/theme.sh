#!/usr/bin/env bash

WALLPAPER="$(dirname "$0")/wallpaper.jpg"

# set wallpaper
swww img "$WALLPAPER" --transition-type grow

# generate palette
wal -i "$WALLPAPER" \
    --backend wal \
    --saturate 0.8

# reload apps
pkill -USR2 waybar || true
hyprctl reload
