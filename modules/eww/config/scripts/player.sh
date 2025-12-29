#!/usr/bin/env bash
set -euo pipefail

field="${1:-status}"

have_player() {
  playerctl -l >/dev/null 2>&1
}

if ! have_player; then
  case "$field" in
    status) echo "Stopped" ;;
    *) echo "" ;;
  esac
  exit 0
fi

case "$field" in
  status) playerctl status 2>/dev/null || echo "Stopped" ;;
  title)  playerctl metadata --format '{{title}}' 2>/dev/null || echo "" ;;
  artist) playerctl metadata --format '{{artist}}' 2>/dev/null || echo "" ;;
  art)
    url="$(playerctl metadata --format '{{mpris:artUrl}}' 2>/dev/null || true)"
    if [[ "$url" == file://* ]]; then
      echo "${url#file://}"
    else
      echo ""
    fi
    ;;
esac

