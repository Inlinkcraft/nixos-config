#!/usr/bin/env bash
set -euo pipefail

if ! command -v nmcli >/dev/null 2>&1; then
  echo "No nmcli"
  exit 0
fi

ssid="$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2; exit}')"
if [[ -n "${ssid:-}" ]]; then
  echo "Wi-Fi • ${ssid}"
else
  state="$(nmcli -t -f WIFI g 2>/dev/null | head -n1 || true)"
  echo "Wi-Fi • ${state:-off}"
fi
