#!/usr/bin/env bash
# X resources belong to this Mango XWayland server, never to GNOME.
set -eu
case ":${XDG_CURRENT_DESKTOP:-}:" in
    *:mango:*) ;;
    *) exit 0 ;;
esac
[[ -n ${MANGO_INSTANCE_SIGNATURE:-} && -n ${DISPLAY:-} ]] || exit 0
theme=${XCURSOR_THEME:-Bibata-Modern-Koru}
logical_size=${XCURSOR_SIZE:-24}
# Tested on Mango 0.18.0 at output scale 2: XWayland's 24px cursor surface
# is enlarged to 48px by the compositor. A 48px Xcursor becomes 96px.
# Keep environment-free X11 clients at the same apparent size. The current
# XWayland rendering path still upscales; this script cannot remove that blur.
printf 'Xcursor.theme: %s\nXcursor.size: %s\n' "$theme" "$logical_size" | xrdb -merge
