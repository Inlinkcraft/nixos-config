#!/usr/bin/env bash
set -euo pipefail
playerctl status 2>/dev/null || echo "Stopped"

