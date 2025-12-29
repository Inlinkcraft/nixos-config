#!/usr/bin/env bash
set -euo pipefail
v="${1:-0}"
v="${v%.*}"
[[ "$v" =~ ^[0-9]+$ ]] || v=0
pamixer --set-volume "$v"
