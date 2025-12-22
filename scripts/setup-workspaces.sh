#!/usr/bin/env bash
# Wait for Hyprland to be ready
sleep 1

# Keep your special workspace
hyprctl keyword workspace special:dashboard

# Get all outputs
outputs=( $(hyprctl monitors | awk '/ID/ {print $3}') )

# Loop over outputs
for idx in "${!outputs[@]}"; do
    out="${outputs[$idx]}"
    # Workspace base: monitor 0 -> 11, monitor 1 -> 21, etc.
    base=$(( (idx + 1) * 10 + 1 ))
    for i in {0..8}; do
        ws=$((base + i))
        hyprctl keyword workspace "$ws,$out"
    done
done
