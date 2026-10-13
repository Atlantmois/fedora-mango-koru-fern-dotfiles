# 配色及资源来源

## Koru Fern 配色

作者与上游：**WallyHao**，[koru-nixos-dotfiles](https://github.com/WallyHao/koru-nixos-dotfiles)。参考提交：`b276a4a61197b7831fbbe2e44af418a3b19ae768`。

- [system/theme.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/system/theme.nix)：语义色与 ANSI 色板的直接来源。
- [home/fcitx5.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/fcitx5.nix)：核对上游实际候选框主题及强调色；Fedora 版本采用直角纯色绘制并保留本机几何尺寸。
- [home/cursor-theme.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/cursor-theme.nix)：Bibata 重着色思路与深色填充 / 蕨绿色描边来源。
- [home/niri.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/niri.nix)：滚动布局及部分键位参考，已按 MangoWC 实际能力和本机习惯适配。

本仓库是 Fedora/MangoWC 的独立适配，不属于上游 Koru 项目。上游原本使用 NixOS/Niri；本仓库没有复制其 Nix 系统部署、Rime 方案、字体字号或输入协议设置。完整色板另存于 `system/theme.json`，便于核对来源。

## 其他资源

| 资源 | 上游 / 作者 | 本仓库中的处理 |
| --- | --- | --- |
| Mango 配置基础 | [DreamMaoMao/mango-config](https://github.com/DreamMaoMao/mango-config)，原本地基础提交 `a08f0e303ee7e75d0ef6ea92701a27001441b4b2` | 保留现有启动、工具与通知资源，适配 Koru Fern 视觉及个人键位 |
| Bibata 光标 | [ful1e5/Bibata_Cursor v2.0.7](https://github.com/ful1e5/Bibata_Cursor/releases/tag/v2.0.7)，Abdulkaiz Khatri 与上游贡献者 | 以 Bibata-Modern-Amber 为基础重着色，保留尺寸、动画、热点与别名；GPL 许可位于光标目录 `LICENSE` |
| Ghostty 光标轨迹 | [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders)，Sahaj Bhatt | 保留已有本地修改；MIT 许可位于 `home/ghostty/shaders/LICENSE` |
| Yazi 图标规则 | [sxyazi/yazi](https://github.com/sxyazi/yazi) | 本机原有默认图标规则，按 Koru 色板重着色；MIT 许可见 `licenses/Yazi-MIT.txt` |

字体仅按名称引用，不分发字体文件。历史 Kanso Ink 主题、备份和其他作者的旧主题不收录。

## 光标重建

基础资源：[Bibata-Modern-Amber.tar.xz](https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Amber.tar.xz)，SHA-256：

```text
58b7ac00ed3cb45acb6b917cb9807a553873f1cca5c91348c4abaebe638e5884
```

上游设计与构建源文件：[Bibata_Cursor v2.0.7 source](https://github.com/ful1e5/Bibata_Cursor/tree/v2.0.7)。本仓库的重着色源代码：`scripts/recolor-cursor.py`。

```sh
# 下载并校验以上固定版本，解压后运行：
python3 scripts/recolor-cursor.py /path/to/Bibata-Modern-Amber /tmp/Bibata-Modern-Koru
```

脚本以预乘 Alpha 空间替换填充和描边，保留 Xcursor 元数据，不缩放图像。它复制仓库所附的许可与主题描述到输出目录。

## 许可说明

第三方资源保留各自原作者与许可。光标与着色器的完整许可随对应目录分发。本仓库没有为整套配置声明一个统一的 MIT/GPL 许可，也不把上游配色或第三方资源重新署名为原创。
