#!/usr/bin/env bash
set -euo pipefail

if ! playerctl status >/dev/null 2>&1; then
  echo 0
  exit 0
fi

pos="$(playerctl position 2>/dev/null || echo 0)"
len_us="$(playerctl metadata mpris:length 2>/dev/null || echo 0)"

if [[ -z "${len_us:-}" || "$len_us" -le 0 ]]; then
  echo 0
  exit 0
fi

len="$(echo "scale=6; $len_us/1000000" | bc -l)"
if [[ "$(echo "$len <= 0" | bc -l)" -eq 1 ]]; then
  echo 0
  exit 0
fi

p="$(echo "scale=4; $pos / $len" | bc -l)"
# clamp
if [[ "$(echo "$p < 0" | bc -l)" -eq 1 ]]; then p=0; fi
if [[ "$(echo "$p > 1" | bc -l)" -eq 1 ]]; then p=1; fi
echo "$p"
