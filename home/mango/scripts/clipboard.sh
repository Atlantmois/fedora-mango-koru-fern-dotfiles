#!/bin/bash
set -euo pipefail
selection=$(cliphist list | "$HOME/.config/mango/scripts/run-app.sh" rofi -config "$HOME/.config/mango/rofi/config.rasi" -dmenu -display-columns 2 -p '剪贴板') || exit 0
[[ -n "$selection" ]] || exit 0
decoded=$(mktemp)
trap 'rm -f "$decoded"' EXIT
printf '%s\n' "$selection" | cliphist decode > "$decoded"
wl-copy < "$decoded"
