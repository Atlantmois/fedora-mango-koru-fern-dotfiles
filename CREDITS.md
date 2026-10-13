# Attribution and licenses

**English** | [简体中文](CREDITS.zh-CN.md)

## Koru Fern palette

Author and upstream: **WallyHao**, [koru-nixos-dotfiles](https://github.com/WallyHao/koru-nixos-dotfiles). Reference commit: `b276a4a61197b7831fbbe2e44af418a3b19ae768`.

- [system/theme.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/system/theme.nix): source of the semantic and ANSI colors.
- [home/fcitx5.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/fcitx5.nix): reference for the candidate-panel theme and highlights. The Fedora adaptation uses square solid fills and preserves the reference configuration's panel geometry.
- [home/cursor-theme.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/cursor-theme.nix): reference for recoloring Bibata with a dark fill and fern-green outline.
- [home/niri.nix](https://github.com/WallyHao/koru-nixos-dotfiles/blob/b276a4a61197b7831fbbe2e44af418a3b19ae768/home/niri.nix): reference for scrolling layouts and some bindings, adapted to MangoWC's capabilities.

This repository is an independent Fedora/MangoWC adaptation, not part of upstream Koru. Upstream uses NixOS/Niri. Its Nix system deployment, Rime schemas, font sizes, and input-protocol settings are not imported here. The complete palette is recorded in [system/theme.json](system/theme.json).

## Other resources

| Resource | Upstream / author | Adaptation and license |
| --- | --- | --- |
| Mango configuration base | [DreamMaoMao/mango-config](https://github.com/DreamMaoMao/mango-config), base commit `a08f0e303ee7e75d0ef6ea92701a27001441b4b2` | Session helpers and notification resources, adapted with Koru Fern styling and custom bindings |
| Bibata cursor | [ful1e5/Bibata_Cursor v2.0.7](https://github.com/ful1e5/Bibata_Cursor/releases/tag/v2.0.7), Abdulkaiz Khatri and contributors | Recolored Bibata-Modern-Amber; original sizes, animations, hotspots, and aliases retained. GPL license included in the cursor directory |
| Ghostty cursor trail | [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders), Sahaj Bhatt | Includes custom modifications; MIT license in `home/ghostty/shaders/LICENSE` |
| Yazi icon rules | [sxyazi/yazi](https://github.com/sxyazi/yazi) | Default icon rules recolored with Koru colors; MIT license in `licenses/Yazi-MIT.txt` |

Fonts are referenced by name and are not distributed. Legacy Kanso Ink themes, backups, and other previous themes are not included.

## Rebuilding the cursor

Base archive: [Bibata-Modern-Amber.tar.xz](https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Amber.tar.xz). SHA-256:

```text
58b7ac00ed3cb45acb6b917cb9807a553873f1cca5c91348c4abaebe638e5884
```

Upstream design and build sources: [Bibata_Cursor v2.0.7](https://github.com/ful1e5/Bibata_Cursor/tree/v2.0.7). The recoloring source is [scripts/recolor-cursor.py](scripts/recolor-cursor.py).

After downloading, verifying, and extracting the pinned archive, run:

```sh
python3 scripts/recolor-cursor.py /path/to/Bibata-Modern-Amber /tmp/Bibata-Modern-Koru
```

The script transfers fill and outline colors in premultiplied alpha space, preserves Xcursor metadata, and does not resize images. It copies the included license and theme descriptions into the output directory.

## License scope

Third-party resources retain their authorship and licenses. Complete cursor and shader licenses are distributed with their respective directories. This repository does not declare a single MIT or GPL license for the entire collection or claim authorship of the upstream palette and third-party resources.
