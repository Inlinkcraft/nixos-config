#!/usr/bin/env bash
set -euo pipefail

if ! command -v brightnessctl >/dev/null 2>&1; then
  echo 0
  exit 0
fi

brightnessctl -m | awk -F, '{gsub(/%/,"",$4); print $4}'
