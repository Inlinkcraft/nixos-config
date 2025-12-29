#!/usr/bin/env bash
set -euo pipefail
if playerctl status >/dev/null 2>&1; then
  a="$(playerctl metadata --format '{{artist}}' 2>/dev/null || true)"
  echo "${a:-}"
else
  echo ""
fi
