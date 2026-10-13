#!/bin/bash
set -euo pipefail
case "$1" in
    up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0 ;;
    down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- ;;
    mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    *) exit 2 ;;
esac
