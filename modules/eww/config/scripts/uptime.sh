#!/usr/bin/env bash
set -euo pipefail
uptime -p | sed 's/^up //'
