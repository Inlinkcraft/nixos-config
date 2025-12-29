#!/usr/bin/env bash
set -euo pipefail
pamixer --get-volume 2>/dev/null || echo 0

