#!/usr/bin/env bash
set -euo pipefail

# Try thermal zone first (fast + works on most machines)
if [[ -r /sys/class/thermal/thermal_zone0/temp ]]; then
  v=$(cat /sys/class/thermal/thermal_zone0/temp)
  echo $(( v / 1000 ))
  exit 0
fi

# Fallback to lm_sensors if available
if command -v sensors >/dev/null 2>&1; then
  # Best-effort parse
  sensors 2>/dev/null | awk '/\+?[0-9]+(\.[0-9]+)?°C/ {gsub(/[+°C]/,"",$2); print int($2); exit}'
  exit 0
fi

echo 0
