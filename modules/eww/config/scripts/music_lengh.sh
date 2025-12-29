#!/usr/bin/env bash
set -euo pipefail
if ! playerctl status >/dev/null 2>&1; then
  echo "0:00"
  exit 0
fi

len_us="$(playerctl metadata mpris:length 2>/dev/null || echo 0)"
sec=$((len_us / 1000000))
min=$((sec / 60))
rem=$((sec % 60))
printf "%d:%02d\n" "$min" "$rem"
