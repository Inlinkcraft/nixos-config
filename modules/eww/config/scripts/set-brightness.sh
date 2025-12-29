#!/usr/bin/env bash
set -euo pipefail
v="${1:-50}"
v="${v%.*}"
[[ "$v" =~ ^[0-9]+$ ]] || v=50
brightnessctl set "${v}%"

