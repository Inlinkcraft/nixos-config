#!/usr/bin/env bash
set -euo pipefail
if ! playerctl status >/dev/null 2>&1; then
  echo "0:00"
  exit 0
fi

sec="$(playerctl position 2>/dev/null | cut -d. -f1 || echo 0)"
min=$((sec / 60))
rem=$((sec % 60))
printf "%d:%02d\n" "$min" "$rem"
