#!/usr/bin/env python3
"""Render home-path templates to a separate directory; never install them."""
from pathlib import Path
import argparse
import json
import shutil

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, default=Path('rendered'))
parser.add_argument('--home', type=Path, default=Path.home())
args = parser.parse_args()
home = str(args.home)
if not args.home.is_absolute() or any(c in home for c in '\n\r\0'):
    parser.error('--home must be an absolute path without control characters')
if args.output.exists():
    parser.error('--output must be a new directory')
repo = Path(__file__).resolve().parents[1]
args.output.mkdir(parents=True)
mapping = json.loads((repo / 'lib/deployment.json').read_text())
for source, target in mapping.items():
    shutil.copytree(repo / source, args.output / target, symlinks=True, dirs_exist_ok=True)
for root in (args.output / '.config', args.output / '.local'):
    for path in root.rglob('*'):
        if not path.is_file() or path.is_symlink():
            continue
        try:
            text = path.read_text(encoding='utf-8')
        except UnicodeDecodeError:
            continue
        if '@HOME@' in text:
            path.write_text(text.replace('@HOME@', home), encoding='utf-8')
print(f'Rendered configuration in {args.output}; no live configuration changed.')
