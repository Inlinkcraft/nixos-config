#!/usr/bin/env bash

THEME="$1"

if [ -z "$THEME" ]; then
    echo "Usage: apply-theme <theme>"
    exit 1
fi

THEME_DIR="$HOME/Configuration/themes/$THEME"

if [ ! -d "$THEME_DIR" ]; then
    echo "Theme not found: $THEME"
    exit 1
fi

bash "$THEME_DIR/theme.sh"
