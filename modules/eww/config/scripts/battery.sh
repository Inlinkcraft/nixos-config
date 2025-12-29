#!/usr/bin/env bash
set -euo pipefail

if ! command -v acpi >/dev/null 2>&1; then
  echo ""
  exit 0
fi

line="$(acpi -b | head -n1 || true)"
pct="$(echo "$line" | grep -oE '[0-9]+%' | head -n1 || true)"
st="$(echo "$line" | awk -F': ' '{print $2}' | awk -F', ' '{print $1}' || true)"

if [[ -z "${pct:-}" ]]; then
  echo ""
else
  echo "${pct} • ${st}"
fi

