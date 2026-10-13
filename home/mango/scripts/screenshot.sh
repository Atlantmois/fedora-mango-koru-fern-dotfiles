#!/bin/bash
set -euo pipefail
geometry=$(slurp -b '#2E2A1E55' -c '#fb751bff') || exit 0
[[ -n "$geometry" ]] || exit 0
if command -v satty >/dev/null 2>&1; then
    grim -g "$geometry" -t ppm - | "$HOME/.config/mango/scripts/run-app.sh" satty -f -
else
    grim -g "$geometry" - | wl-copy --type image/png
    notify-send '截图' '已复制到剪贴板' || true
fi
