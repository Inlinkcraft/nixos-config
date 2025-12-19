#!/usr/bin/env bash
set -euo pipefail

########################################
# IMPORTANT CONTRACT
########################################
# This script MUST NOT:
# - call wal
# - touch ~/.cache/wal
# - reload global apps
#
# It may ONLY:
# - tweak compositor settings
# - change cursors
# - apply per-theme preferences
########################################

# Example: Hyprland tweaks
hyprctl keyword general:border_size 3
hyprctl keyword decoration:rounding 12

# Example: cursor
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"

# Example: GTK accent (optional)
# gsettings set org.gnome.desktop.interface accent-color 'rgb(120,160,255)'

echo "Theme hook applied for: ${WAL_THEME:-unknown}"
