#!/usr/bin/env bash
set -euo pipefail

if ! command -v sensors >/dev/null 2>&1; then
  echo 0
  exit 0
fi

t="$(
  sensors 2>/dev/null | awk '
    /Package id 0:/ {gsub(/[+°C]/,"",$4); print int($4); exit}
    /Tctl:/         {gsub(/[+°C]/,"",$2); print int($2); exit}
    /temp1:/        {gsub(/[+°C]/,"",$2); print int($2); exit}
  '
)"
echo "${t:-0}"
