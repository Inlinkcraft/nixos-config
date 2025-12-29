#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-state}"

case "$cmd" in
  state)
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then echo on; else echo off; fi
    ;;
  toggle)
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
      bluetoothctl power off >/dev/null
    else
      bluetoothctl power on >/dev/null
    fi
    ;;
esac

