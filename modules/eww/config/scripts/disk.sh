#!/usr/bin/env bash
set -euo pipefail
df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}'
