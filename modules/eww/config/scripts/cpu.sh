#!/usr/bin/env bash
set -euo pipefail

state="/tmp/eww_cpu.stat"

read -r _ user nice system idle iowait irq softirq steal _ _ < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idleall=$((idle + iowait))

if [[ -f "$state" ]]; then
  read -r ptotal pidle < "$state"
else
  ptotal=$total
  pidle=$idleall
fi

echo "$total $idleall" > "$state"

dt=$((total - ptotal))
di=$((idleall - pidle))

if (( dt <= 0 )); then
  echo 0
else
  echo $(( (100 * (dt - di)) / dt ))
fi
