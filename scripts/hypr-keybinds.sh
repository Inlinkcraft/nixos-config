#!/usr/bin/env bash
# Usage: hypr-keybinds.sh switch|move N

action="$1"   # "switch" or "move"
num="$2"      # 1..9

# Get focused monitor name
focused_monitor=$(hyprctl activewindow | awk -F 'Monitor: ' '{print $2}' | awk '{print $1}')

# Get monitor index (to calculate workspace base)
outputs=( $(hyprctl monitors | awk '/ID/ {print $3}') )
for idx in "${!outputs[@]}"; do
    if [ "${outputs[$idx]}" == "$focused_monitor" ]; then
        monitor_idx="$idx"
        break
    fi
done

# Calculate workspace number for this monitor
base=$(( (monitor_idx + 1) * 10 + 1 ))
workspace=$((base + num - 1))

# Execute
if [ "$action" == "switch" ]; then
    hyprctl dispatch workspace "$workspace"
elif [ "$action" == "move" ]; then
    hyprctl dispatch movetoworkspace "$workspace"
fi

