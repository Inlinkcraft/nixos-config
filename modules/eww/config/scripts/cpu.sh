#!/usr/bin/env bash
set -euo pipefail

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/eww"
mkdir -p "$cache_dir"
prev="$cache_dir/cpu_prev"

read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
idle_all=$((idle + iowait))
total=$((user + nice + system + idle + iowait + irq + softirq + steal))

usage=0
if [[ -f "$prev" ]]; then
  read -r p_total p_idle < "$prev" || true
  totald=$((total - p_total))
  idled=$((idle_all - p_idle))
  if (( totald > 0 )); then
    usage=$(( (1000 * (totald - idled) / totald + 5) / 10 ))
  fi
fi

printf "%s %s\n" "$total" "$idle_all" > "$prev"
echo "$usage"
