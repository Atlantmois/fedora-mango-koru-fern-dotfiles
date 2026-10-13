# Fedora + MangoWC · Koru Fern

[English](README.md) | **简体中文**

适用于 Fedora 与 MangoWC 的 Koru Fern 桌面配置：深绿灰背景、柔和黄色重点、蕨绿色辅助强调和清晰文字。涵盖合成器、启动器、终端、编辑器、文件管理器、通知、锁屏、光标及 Fcitx5 候选框。

配色源自 **WallyHao 的 [koru-nixos-dotfiles](https://github.com/WallyHao/koru-nixos-dotfiles)**。本仓库以原生配置文件将其适配到 Fedora，不需要 NixOS 或 Home Manager。

![Koru Fern 色板](docs/palette.svg)

| 角色 | 色值 |
| --- | --- |
| 背景 / 浮起表面 | `#171E1A` / `#222D26` |
| 主文字 / 次级文字 | `#D2DCD0` / `#A5B3A2` |
| 黄色重点 / 蕨绿色强调 | `#E6D87A` / `#8FBF88` |
| 边框 / 选区 | `#425347` / `#334936` |

参考色板固定为 [Koru 提交 b276a4a](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/system/theme.nix)。完整语义色和 ANSI 色见 [system/theme.json](system/theme.json)，来源与许可见 [CREDITS.zh-CN.md](CREDITS.zh-CN.md)。

## 包含的组件

| 组件 | 仓库路径 | 内容 |
| --- | --- | --- |
| MangoWC | `home/mango/` | 合成器设置、快捷键、窗口规则、屏幕配置及会话脚本 |
| Bibata 光标 | `assets/cursors/Bibata-Modern-Koru/` | 重着色光标，保留原始尺寸、热点、动画、别名及许可 |
| Rofi | `home/rofi/` | 启动器配置及主题 |
| Ghostty | `home/ghostty/` | 终端配置、色板及光标动画着色器 |
| Alacritty | `home/alacritty/` | 终端配置及色板 |
| Helix | `home/helix/` | 编辑器设置、语言配置及语法主题 |
| Yazi | `home/yazi/` | 界面主题、文件图标及语法预览色板 |
| Btop | `home/btop/` | 监控设置及图表主题 |
| SwayNC | `home/swaync/` | 通知配置、样式、声音及脚本 |
| Swaylock | `home/swaylock/` | 锁屏配置及配色 |
| Fcitx5 | `home/fcitx5/`、`assets/fcitx5/koru-fern/` | Classic UI 参考配置及独立候选框主题 |

主要界面采用不透明背景和直角。Mango 窗口动画与 Ghostty 光标着色器保持启用。仓库不包含字体文件、Rime 方案、词库、学习数据或旧主题。

## 仓库结构

目录职责参照上游 Koru，内部使用 Fedora 原生配置：

```text
home/       应用配置与主题
system/     统一 Koru Fern 色板
assets/     光标与 Fcitx5 主题资源
hosts/      参考屏幕、字体及会话设置
lib/        部署映射与导出文件校验清单
scripts/    家目录路径渲染与光标重着色工具
licenses/   第三方许可
docs/       色板预览与验证记录
```

## 安装前

参考环境为 **Fedora 44、MangoWC 0.18.0、Fcitx5 5.1.23 + Rime**。应用配置前，请检查以下假设：

| 设置 | 参考值 | 配置位置 |
| --- | --- | --- |
| 屏幕 | `eDP-1`，3200×2000，165 Hz，缩放 2 | `home/mango/monitor.conf` |
| Xft DPI | 192 | `home/mango/autostart.sh` |
| 背光设备 | `intel_backlight` | `home/mango/scripts/brightness.sh` |
| Ghostty / Alacritty 字体 | Jetbrains Maple Mono，16 / 13 | 各终端配置 |
| Rofi 字体 | HarmonyOS Sans bold，18 | `home/rofi/config.rasi` |
| Fcitx5 参考字体 | HarmonyOS Sans，12；菜单 10 | `home/fcitx5/conf/classicui.conf` |

请单独安装字体，或选择系统已有字体。终端及启动器图标需要相应图标字形。仅应用 Fcitx5 主题时，保留自己的输入法字体与 DPI 设置。

安装需要使用的应用。会话辅助工具包括 `xrdb`、`dconf`、`wl-clipboard`、`cliphist`、`flock`、`wlsunset`、`brightnessctl`、`wpctl`、`playerctl`、`grim`、`slurp`、`jq`、`wlr-randr` 及 SoX 的 `play`。`satty`、`swayosd-server`、`sway-audio-idle-inhibit`、`xfce-polkit` 为可选工具，启动脚本会跳过不可用的服务。请检查脚本中与发行版有关的程序路径。

## 按组件安装

克隆仓库，并检查设置和快捷键：

```sh
git clone https://github.com/Atlantmois/fedora-mango-koru-fern-dotfiles.git
cd fedora-mango-koru-fern-dotfiles
```

将家目录占位符渲染到新的输出目录：

```sh
python3 scripts/render.py --output rendered
```

输出目录必须尚不存在。脚本将 `@HOME@` 替换为你的家目录，并保留可执行权限和相对符号链接。它只准备文件，不执行安装或重载。为其他用户准备文件时，可使用 `--home /home/target-user`。

备份目标配置，从 `rendered/.config/` 和 `rendered/.local/` 中只复制需要的组件。例如，应用完整 Alacritty 配置：

```sh
if [ -d ~/.config/alacritty ]; then
    cp -a ~/.config/alacritty ~/.config/alacritty.backup-$(date +%Y%m%d-%H%M%S)
fi
mkdir -p ~/.config/alacritty
cp -a rendered/.config/alacritty/. ~/.config/alacritty/
```

这也会应用字体和窗口设置。如仅需配色，请复制主题文件，并在自己的配置中导入它。随后重载或重新打开相关应用。

[lib/deployment.json](lib/deployment.json) 列出所有目标位置。Rofi 和 SwayNC 部署在 `~/.config/mango/` 下，与 Mango 启动命令一致。安装 Mango 时，将渲染后的 Mango 目录及其中的 Rofi、SwayNC 子目录一起复制，并将 Bibata 光标安装到 `~/.local/share/icons/`。启动会话前检查启动命令。不要启用尚未渲染的路径模板，也不要覆盖整个 `~/.config` 目录。

Mango 光标使用专用 Dconf profile。请保留 `cursor/dconf-profile`、`cursor/koru-cursor.db` 和 `cursor/dconf.d/` 的配套关系。修改光标设置后，在已部署的 Mango 目录中重建数据库：

```sh
dconf compile cursor/koru-cursor.db cursor/dconf.d
```

### Fcitx5：仅应用主题

此主题面向 **Classic UI**。应用前先确认 Fcitx5 会话实际使用的界面，GNOME Kimpanel 可能自行绘制候选框。

保留自己的输入法、Rime 配置、快捷键、字体、候选方向、分页、预编辑行为及 DPI 设置。`home/fcitx5/conf/classicui.conf` 是参考文件，**不能直接替换自己的配置**。

复制主题，并备份已有 Classic UI 配置：

```sh
mkdir -p ~/.local/share/fcitx5/themes
cp -a assets/fcitx5/koru-fern ~/.local/share/fcitx5/themes/
if [ -f ~/.config/fcitx5/conf/classicui.conf ]; then
    cp -a ~/.config/fcitx5/conf/classicui.conf \
        ~/.config/fcitx5/conf/classicui.conf.backup-$(date +%Y%m%d-%H%M%S)
fi
```

在 `~/.config/fcitx5/conf/classicui.conf` 中，只设置或添加以下两项：

```ini
Theme=koru-fern
DarkTheme=koru-fern
```

重载 Classic UI，无需重启输入法：

```sh
gdbus call --session --dest org.fcitx.Fcitx5 --object-path /controller \
  --method org.fcitx.Fcitx.Controller1.ReloadAddonConfig classicui
```

候选框使用原生纯色绘制，无阴影或模糊，仅包含两个 8×8 PNG 菜单图标。部分应用会缓存主题资源，重载后外观未更新时可重新打开应用。请在常用应用中检查中文输入、候选选择、定位及缩放。

## 恢复原配置

从自己的备份恢复相关应用配置，然后重载或重新打开应用。对于 Fcitx5，恢复备份的 `classicui.conf`，或将 `Theme`、`DarkTheme` 改回自己的原主题名称，再执行上面的重载命令。确认新主题适用前，保留原主题资源。

## 快捷键

| 快捷键 | 操作 |
| --- | --- |
| `Super+Space` | 启动器 |
| `Super+H/J/K/L` | 聚焦窗口 |
| `Super+U/I` | 切换工作区 |
| `Super+R` | 列宽预设 |
| `Super+Shift+S` | 截图 |
| `Super+V` | 剪贴板历史 |
| `Super+Alt+L` | 锁屏 |
| `Super+Alt+R` | 重载 Mango |

完整绑定见 [home/mango/bind.conf](home/mango/bind.conf)。

## GNOME 与兼容性

专用光标 profile 由 Mango 会话选用。应用配置及 Fcitx5 用户配置由桌面会话共享。**Fcitx5 主题没有与 GNOME 隔离。** Classic UI 回退或客户端绘制的候选框可能在两个会话中使用本主题，GNOME Kimpanel 则可能自行绘制候选框。

Fcitx5 已在参考环境的原生 Wayland、GTK3、GTK4/Nautilus、Qt6 及 GTK3/XWayland 路径中检查候选选择、分页、定位和回滚，详见 [验证记录](docs/fcitx5-validation.md)。这些结果不代表所有应用的兼容性或长期性能保证。GNOME 登录会话行为未经测试。

XWayland 光标缩放仍可能比原生 Wayland 模糊，安装主题不会消除这一渲染路径差异。请保留适合自己系统的缩放及输入协议设置。
