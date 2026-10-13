# Fedora + MangoWC · Koru Fern

**English** | [简体中文](README.zh-CN.md)

A coordinated Koru Fern desktop for Fedora and MangoWC: green-charcoal backgrounds, soft yellow highlights, fern-green accents, and readable text. It covers the compositor, launcher, terminals, editor, file manager, notifications, lock screen, cursor, and Fcitx5 candidate panel.

The palette comes from **WallyHao's [koru-nixos-dotfiles](https://github.com/WallyHao/koru-nixos-dotfiles)**. This repository adapts it to Fedora using native configuration files; NixOS and Home Manager are not required.

![Koru Fern palette](docs/palette.svg)

| Role | Colors |
| --- | --- |
| Background / raised surface | `#171E1A` / `#222D26` |
| Text / secondary text | `#D2DCD0` / `#A5B3A2` |
| Yellow highlight / fern accent | `#E6D87A` / `#8FBF88` |
| Border / selection | `#425347` / `#334936` |

The source palette is pinned to [Koru commit b276a4a](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/system/theme.nix). Full semantic and ANSI colors are in [system/theme.json](system/theme.json); attribution and licenses are in [CREDITS.md](CREDITS.md).

## Components

| Component | Repository path | Contents |
| --- | --- | --- |
| MangoWC | `home/mango/` | Compositor settings, bindings, window rules, display setup, and session scripts |
| Bibata cursor | `assets/cursors/Bibata-Modern-Koru/` | Recolored cursors with original sizes, hotspots, animations, aliases, and license |
| Rofi | `home/rofi/` | Launcher configuration and theme |
| Ghostty | `home/ghostty/` | Terminal configuration, palette, and cursor animation shader |
| Alacritty | `home/alacritty/` | Terminal configuration and palette |
| Helix | `home/helix/` | Editor settings, language configuration, and syntax theme |
| Yazi | `home/yazi/` | Interface theme, file icons, and syntax-preview palette |
| Btop | `home/btop/` | Monitor settings and graph theme |
| SwayNC | `home/swaync/` | Notification configuration, stylesheet, sounds, and scripts |
| Swaylock | `home/swaylock/` | Lock-screen configuration and colors |
| Fcitx5 | `home/fcitx5/`, `assets/fcitx5/koru-fern/` | Classic UI reference configuration and standalone candidate-panel theme |

Main surfaces are opaque and square. Mango window animations and the Ghostty cursor shader remain enabled. Fonts, Rime schemas, dictionaries, learned input data, and legacy themes are not bundled.

## Layout

Directory roles follow upstream Koru, with Fedora-native files inside:

```text
home/       Application configuration and themes
system/     Shared Koru Fern palette
assets/     Cursor and Fcitx5 theme resources
hosts/      Reference display, font, and session settings
lib/        Deployment mapping and exported-file checksums
scripts/    Home-path rendering and cursor recoloring
licenses/   Third-party licenses
docs/       Palette preview and validation records
```

## Before installing

The reference environment is **Fedora 44, MangoWC 0.18.0, and Fcitx5 5.1.23 with Rime**. Review these assumptions before applying the configuration:

| Setting | Reference value | Configuration |
| --- | --- | --- |
| Display | `eDP-1`, 3200×2000, 165 Hz, scale 2 | `home/mango/monitor.conf` |
| Xft DPI | 192 | `home/mango/autostart.sh` |
| Backlight device | `intel_backlight` | `home/mango/scripts/brightness.sh` |
| Ghostty / Alacritty font | Jetbrains Maple Mono, 16 / 13 | Each terminal's configuration |
| Rofi font | HarmonyOS Sans bold, 18 | `home/rofi/config.rasi` |
| Fcitx5 reference font | HarmonyOS Sans, 12; menu 10 | `home/fcitx5/conf/classicui.conf` |

Install the fonts separately or choose fonts available on your system. Terminal and launcher icons need suitable icon glyphs. Keep your own input-method font and DPI settings when applying only the Fcitx5 theme.

Install the applications you intend to use. Session helpers include `xrdb`, `dconf`, `wl-clipboard`, `cliphist`, `flock`, `wlsunset`, `brightnessctl`, `wpctl`, `playerctl`, `grim`, `slurp`, `jq`, `wlr-randr`, and SoX's `play`. `satty`, `swayosd-server`, `sway-audio-idle-inhibit`, and `xfce-polkit` are optional; the startup script skips unavailable services. Review distribution-specific paths in the scripts.

## Install selected components

Clone the repository and review the settings and bindings:

```sh
git clone https://github.com/Atlantmois/fedora-mango-koru-fern-dotfiles.git
cd fedora-mango-koru-fern-dotfiles
```

Render home-directory placeholders into a new output directory:

```sh
python3 scripts/render.py --output rendered
```

The output directory must not already exist. The script replaces `@HOME@` with your home directory and preserves executable permissions and relative symlinks. It only prepares files; it does not install or reload anything. Use `--home /home/target-user` to prepare files for another user.

Back up the target configuration and copy only the components you want from `rendered/.config/` and `rendered/.local/`. For example, to apply the complete Alacritty configuration:

```sh
if [ -d ~/.config/alacritty ]; then
    cp -a ~/.config/alacritty ~/.config/alacritty.backup-$(date +%Y%m%d-%H%M%S)
fi
mkdir -p ~/.config/alacritty
cp -a rendered/.config/alacritty/. ~/.config/alacritty/
```

This also applies font and window settings. To use only the colors, copy the theme file and import it from your existing configuration instead. Reload or reopen the affected application.

[lib/deployment.json](lib/deployment.json) lists every destination. Rofi and SwayNC deploy under `~/.config/mango/`, matching Mango's launch commands. For Mango, copy the rendered Mango directory with its Rofi and SwayNC subdirectories, and install the Bibata cursor under `~/.local/share/icons/`. Review startup commands before starting the session. Do not enable unrendered path templates or overwrite your entire `~/.config` tree.

The Mango cursor uses a dedicated Dconf profile. Keep `cursor/dconf-profile`, `cursor/koru-cursor.db`, and `cursor/dconf.d/` together. After editing cursor settings, rebuild the database from the deployed Mango directory:

```sh
dconf compile cursor/koru-cursor.db cursor/dconf.d
```

### Fcitx5: apply the theme only

This theme targets **Classic UI**. Confirm which UI your Fcitx5 session uses first; GNOME Kimpanel may draw its own candidate panel.

Keep your input method, Rime configuration, shortcuts, fonts, candidate direction, paging, preedit behavior, and DPI settings. `home/fcitx5/conf/classicui.conf` is a reference file, **not a replacement for your own configuration**.

Copy the theme and back up the existing Classic UI configuration:

```sh
mkdir -p ~/.local/share/fcitx5/themes
cp -a assets/fcitx5/koru-fern ~/.local/share/fcitx5/themes/
if [ -f ~/.config/fcitx5/conf/classicui.conf ]; then
    cp -a ~/.config/fcitx5/conf/classicui.conf \
        ~/.config/fcitx5/conf/classicui.conf.backup-$(date +%Y%m%d-%H%M%S)
fi
```

In `~/.config/fcitx5/conf/classicui.conf`, set or add only these entries:

```ini
Theme=koru-fern
DarkTheme=koru-fern
```

Reload Classic UI without restarting the input method:

```sh
gdbus call --session --dest org.fcitx.Fcitx5 --object-path /controller \
  --method org.fcitx.Fcitx.Controller1.ReloadAddonConfig classicui
```

The panel uses native solid fills with no shadow or blur; its only images are two 8×8 PNG menu icons. Some applications cache theme resources, so reopen them if a reload does not update the appearance. Check Chinese input, candidate selection, placement, and scaling in the applications you use.

## Restore a previous configuration

Restore the affected application's configuration from your backup, then reload or reopen it. For Fcitx5, restore your saved `classicui.conf`, or set `Theme` and `DarkTheme` to your previous theme name and run the reload command above. Keep the previous theme's resources installed until you are satisfied with the new theme.

## Key bindings

| Binding | Action |
| --- | --- |
| `Super+Space` | Launcher |
| `Super+H/J/K/L` | Window focus |
| `Super+U/I` | Workspace switching |
| `Super+R` | Column-width presets |
| `Super+Shift+S` | Screenshot |
| `Super+V` | Clipboard history |
| `Super+Alt+L` | Lock screen |
| `Super+Alt+R` | Reload Mango |

See [home/mango/bind.conf](home/mango/bind.conf) for all bindings.

## GNOME and compatibility

The dedicated cursor profile is selected by the Mango session. Application configurations, including Fcitx5's user configuration, are shared across desktop sessions. **The Fcitx5 theme is not isolated from GNOME.** Classic UI fallback or client-rendered panels can use it in either session; GNOME Kimpanel may render its own panel.

Fcitx5 was checked in native Wayland, GTK3, GTK4/Nautilus, Qt6, and GTK3/XWayland paths in the reference environment. Candidate selection, paging, placement, and rollback were tested. See [the validation record (Chinese)](docs/fcitx5-validation.md). These results do not establish compatibility with every application or long-term performance. GNOME login-session behavior was not tested.

XWayland cursor scaling can still produce a softer cursor than native Wayland. Installing a theme does not resolve that rendering-path difference. Keep scaling and input-protocol settings appropriate to your system.
