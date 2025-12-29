#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-state}"

case "$cmd" in
  state)
    # on/off
    if nmcli -t -f WIFI g | grep -q enabled; then echo on; else echo off; fi
    ;;
  ssid)
    nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2; exit}'
    ;;
  toggle)
    if nmcli -t -f WIFI g | grep -q enabled; then
      nmcli r wifi off >/dev/null
    else
      nmcli r wifi on >/dev/null
    fi
    ;;
esac
