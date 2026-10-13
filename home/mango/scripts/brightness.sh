#!/bin/bash
set -euo pipefail
case "$1" in
    up) brightnessctl -d intel_backlight set +10% ;;
    down) brightnessctl -d intel_backlight --min-value=1 set 10%- ;;
    bup) brightnessctl -d intel_backlight set +1% ;;
    bdown) brightnessctl -d intel_backlight --min-value=1 set 1%- ;;
    *) exit 2 ;;
esac
