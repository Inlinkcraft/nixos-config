#!/usr/bin/env bash
set -euo pipefail
if playerctl status >/dev/null 2>&1; then
  t="$(playerctl metadata --format '{{title}}' 2>/dev/null || true)"
  echo "${t:-Nothing playing}"
else
  echo "Nothing playing"
fi
