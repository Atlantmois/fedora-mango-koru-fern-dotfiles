#!/usr/bin/env python3
"""Recolor Bibata Modern Amber v2.0.7 without resizing Xcursor images."""
from pathlib import Path
import argparse
import shutil
import struct

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('source', type=Path)
parser.add_argument('output', type=Path)
args = parser.parse_args()
if not (args.source / 'cursors').is_dir():
    parser.error('source must be the extracted Bibata-Modern-Amber directory')
if args.output.exists():
    parser.error('output must be a new directory')
(args.output / 'cursors').mkdir(parents=True)
fill, outline = (0x12, 0x18, 0x13), (0x8F, 0xBF, 0x88)
cache = {0: 0}

def recolor(argb):
    if argb in cache:
        return cache[argb]
    alpha = argb >> 24
    if not alpha:
        return 0
    red, _, blue = ((argb >> shift) & 255 for shift in (16, 8, 0))
    border = blue / alpha
    body = max(0.0, (red - blue) / alpha)
    rgb = [min(alpha, round(alpha * (body * f + border * o) / 255))
           for f, o in zip(fill, outline)]
    value = (alpha << 24) | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2]
    cache[argb] = value
    return value

for path in sorted((args.source / 'cursors').iterdir()):
    target = args.output / 'cursors' / path.name
    if path.is_symlink():
        target.symlink_to(path.readlink())
        continue
    data = bytearray(path.read_bytes())
    if data[:4] != b'Xcur':
        raise ValueError(f'Not an Xcursor file: {path}')
    count = struct.unpack_from('<I', data, 12)[0]
    for index in range(count):
        kind, _, offset = struct.unpack_from('<III', data, 16 + 12 * index)
        if kind != 0xFFFD0002:
            continue
        header, _, _, _, width, height, xhot, yhot, _ = struct.unpack_from('<9I', data, offset)
        assert xhot < width and yhot < height
        start = offset + header
        pixels = struct.unpack_from(f'<{width * height}I', data, start)
        struct.pack_into(f'<{width * height}I', data, start, *(recolor(v) for v in pixels))
    target.write_bytes(data)

metadata = Path(__file__).resolve().parents[1] / 'assets/cursors/Bibata-Modern-Koru'
for name in ('index.theme', 'cursor.theme', 'README.md', 'LICENSE'):
    shutil.copy2(metadata / name, args.output / name)
print(f'Recolored cursors in {args.output}')
