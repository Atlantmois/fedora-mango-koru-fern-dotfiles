# Fedora / MangoWC 本机配置

| 项目 | 当前配置 |
| --- | --- |
| 系统 / 合成器 | Fedora 44 / MangoWC 0.18.0 |
| 内屏 | `eDP-1`，3200×2000，165 Hz |
| Mango 缩放 / Xft DPI | 2.0 / 192 |
| 光标 | Bibata-Modern-Koru，24 逻辑像素 |
| Ghostty 字体 | Jetbrains Maple Mono，16 |
| Alacritty 字体 | Jetbrains Maple Mono，13 |
| Rofi 字体 | HarmonyOS Sans bold，18 |
| Fcitx5 / Rime | Fcitx5 5.1.23 + 既有 Rime 配置，Classic UI |
| Fcitx5 字体 / 菜单 | HarmonyOS Sans，12 / 10 |
| Fcitx5 候选方向 | 垂直 |
| Fcitx5 DPI | PerScreenDPI=True，ForceWaylandDPI 默认 0，分数缩放默认启用 |
| 夜灯 | 4200 K |
| 共存会话 | MangoWC 与 GNOME |

此文件记录配置假设，移植时先检查屏幕名、刷新率、缩放、背光设备 `intel_backlight` 和字体。Rime 方案、输入习惯与数据库由本机维护，不随此仓库部署。

Mango 的启动与光标 profile 具有会话限定；Fcitx5 和各应用用户配置由会话共享。Fcitx5 主题未与 GNOME 隔离，GNOME 登录态未在本次 Fcitx5 测试中验证。
