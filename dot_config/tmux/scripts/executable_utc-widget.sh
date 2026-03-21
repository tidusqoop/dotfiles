#!/usr/bin/env bash

# UTC time widget for tmux status bar (tokyo-night-tmux style)

PLUGIN_DIR="$HOME/.config/tmux/plugins/tokyo-night-tmux"
THEMES_SH="$PLUGIN_DIR/src/themes.sh"

# Graceful exit if plugin is not installed
[[ ! -f "$THEMES_SH" ]] && exit 0

source "$THEMES_SH"

utc_time="$(TZ=UTC date +"%H:%M")"

echo "$RESET#[fg=${THEME[foreground]},bg=${THEME[bblack]}] 󰔟 ${utc_time}Z "
