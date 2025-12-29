#!/usr/bin/env bash
set -euo pipefail

total=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
avail=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)

if [[ -z "${total:-}" || "$total" -eq 0 ]]; then
  echo 0
  exit 0
fi

used=$((total - avail))
echo $(( (100 * used) / total ))

