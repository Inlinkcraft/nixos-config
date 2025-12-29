#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-get}"
val="${2:-}"

case "$cmd" in
  get)  pamixer --get-volume ;;
  set)  pamixer --set-volume "$val" >/dev/null; pamixer --get-volume ;;
  mute) pamixer --toggle-mute >/dev/null; pamixer --get-volume ;;
  *)    pamixer --get-volume ;;
esac
