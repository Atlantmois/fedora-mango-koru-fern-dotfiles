#!/bin/bash
set -u
# This script belongs only to Mango, including when invoked manually.
case ":${XDG_CURRENT_DESKTOP:-}:" in
    *:mango:*) ;;
    *) exit 0 ;;
esac
unset QT_WAYLAND_FORCE_DPI QT_QPA_PLATFORMTHEME
export QT_QPA_PLATFORM='wayland;xcb'
config_dir="$HOME/.config/mango"
state_dir="$HOME/.local/state/mango"
mkdir -p "$state_dir"
# A valid compositor instance scopes the locks to this Mango session.
[[ -n "${MANGO_INSTANCE_SIGNATURE:-}" && -n "${XDG_RUNTIME_DIR:-}" ]] || exit 0
signature=${MANGO_INSTANCE_SIGNATURE##*/}
lock_prefix="$XDG_RUNTIME_DIR/$signature"
start_locked() {
    local name=$1
    shift
    if [[ "$1" == /* ]]; then
        [[ -x "$1" ]] || return
    else
        command -v "$1" >/dev/null 2>&1 || return
    fi
    # The session lock prevents duplicate calls; existing user services are reused.
    # Clipboard text and image watchers are separate roles of the same binary.
    if [[ "$name" != clipboard-* ]]; then
        local executable=${1##*/}
        if [[ ${#executable} -le 15 ]]; then
            pgrep -u "$UID" -x "$executable" >/dev/null && return 0
        else
            pgrep -u "$UID" -f "^(.*/)?$executable( |$)" >/dev/null && return 0
        fi
    fi
    flock -n "$lock_prefix-$name.lock" "$@" >> "$state_dir/$name.log" 2>&1 &
}

# Portal backends use the Fedora system services and Mango's packaged routing.
start_locked notify swaync -c "$config_dir/swaync/config.json" -s "$config_dir/swaync/style.css"
start_locked polkit /usr/libexec/xfce-polkit
start_locked audio-inhibit sway-audio-idle-inhibit
start_locked osd swayosd-server

echo 'Xft.dpi: 192' | xrdb -merge
# BEGIN Mango Koru cursor
"$config_dir/cursor/sync-xwayland.sh"
# END Mango Koru cursor
# Do not replace an existing input method or restart it during a UI refresh.
if ! pgrep -u "$UID" -x fcitx5 >/dev/null; then
    fcitx5 -d >> "$state_dir/ime.log" 2>&1
fi
# Keep the requested 4200K night light, with one startup definition.
start_locked nightlight wlsunset -T 4201 -t 4200

# Keep existing history watchers; do not duplicate them during a live refresh.
if ! pgrep -u "$UID" -f '^wl-paste --type text --watch cliphist store$' >/dev/null; then
    start_locked clipboard-text wl-paste --type text --watch cliphist store
fi
if ! pgrep -u "$UID" -f '^wl-paste --type image --watch cliphist store$' >/dev/null; then
    start_locked clipboard-image wl-paste --type image --watch cliphist store
fi
