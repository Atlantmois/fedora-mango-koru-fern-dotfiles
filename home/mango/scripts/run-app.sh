#!/bin/sh
# Keep these application overrides local to Mango and its child applications.
unset QT_WAYLAND_FORCE_DPI QT_QPA_PLATFORMTHEME
export QT_QPA_PLATFORM='wayland;xcb'
exec "$@"
