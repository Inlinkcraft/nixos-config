#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-get}"
val="${2:-}"

case "$cmd" in
  get)
    brightnessctl -m | cut -d, -f4 | tr -d '%'
    ;;
  set)
    brightnessctl set "${val}%" >/dev/null
    brightnessctl -m | cut -d, -f4 | tr -d '%'
    ;;
  max)
    brightnessctl set 100% >/dev/null
    echo 100
    ;;
  *)
    brightnessctl -m | cut -d, -f4 | tr -d '%'
    ;;
esac
