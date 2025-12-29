#!/usr/bin/env bash
set -euo pipefail

t=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
a=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
u=$((t - a))

echo $(( (100 * u) / t ))

