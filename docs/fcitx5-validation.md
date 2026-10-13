# Fcitx5 验证记录

2026-10-13，本机 Fedora 44 / MangoWC 0.18.0 / Fcitx5 5.1.23 + Rime，3200×2000、Scale=2、Xft DPI 192。

实际启用的界面是 Classic UI。只把 `classicui.conf` 的 `Theme`、`DarkTheme` 从 `mellow-graphite-obsidian-lite` 改为 `koru-fern`，没有重启 Fcitx5。保留字体、候选方向、分页、快捷键、预编辑、Rime 配置和输入协议。

| 路径 / 应用 | 检查结果 |
| --- | --- |
| 原生 Wayland text-input-v3 → Fcitx wayland_v2 前端 | 中文候选显示、空格提交、数字选择和翻页正常 |
| GTK3 / Wayland，Fcitx D-Bus 输入模块 | 候选显示、提交、定位正常 |
| GTK4 / Nautilus | 重新打开测试窗口后主题生效，中文提交正常 |
| Qt6 / Fcitx 配置工具搜索框 | 候选显示、选择和中文提交正常 |
| GTK3 / XWayland | 候选选择、翻页、跨输入框和光标位置变化正常 |

同一 XWayland 输入框比较 Koru → 原主题 → Koru：候选框均为 **162×372 物理像素**，位置均为 **(59,152)**。验证原主题可以恢复，未观察到这次切换造成的大小或定位变化。

短时压力检查：30 个输入/提交循环、240 对按键事件，用时 13.72 秒；Fcitx5 CPU 时间增加 1.43 秒，约占一核 10.42%；D-Bus 往返中位数 0.695 ms，最大 1.226 ms；RSS 从 103292 KiB 到 103312 KiB，增加 20 KiB。该数据仅描述这次短时检查。

主题资源共 2244 字节，只有两个 8×8 PNG 菜单图标，其他元素使用纯色绘制。GTK 客户端解析器要求所有字段置于节内；主题保留隐式 `SupportedScale=1`，不写节外字段。

字体为 HarmonyOS Sans 12 / 菜单 10，垂直候选列表；`PerScreenDPI=True`、Wayland DPI 默认 0、分数缩放默认开启。当前版本没有有效 `ScaleWithDPI` 项。

GNOME 未登录测试。Fcitx5 配置共享，没有会话级主题隔离。部分应用会缓存主题，切换后需要重新打开；这些结果不代表所有 GTK、Qt、XWayland 应用都经过测试，也不是长期性能保证。
