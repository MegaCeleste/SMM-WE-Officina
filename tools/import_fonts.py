"""字体：复制 datafiles/ 里的 ttf 到 port/assets/fonts/，整理 font_add* 调用到 port/tables/fonts.json。

D3DX9_43.dll 不复制。
"""
from __future__ import annotations

import re
import sys
from typing import Any

from gmlib import ASSETS, ORIG, TABLES, gml_files, mask_comments_and_strings, read_text, rel, write_bytes_if_changed, write_json

TTF = ["font_as.ttf", "fontcjk.ttf"]
CALL_RE = re.compile(r"^\s*(?P<lhs>[\w.\[\]]+)\s*=\s*(?P<fn>font_add(?:_sprite_ext|_sprite)?)\s*\((?P<args>.*)\)\s*;?\s*$")


def split_args(s: str) -> list[str]:
    out: list[str] = []
    depth = 0
    cur = ""
    in_str = False
    for c in s:
        if in_str:
            cur += c
            if c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c in "([":
            depth += 1
        elif c in ")]":
            depth -= 1
        elif c == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
            continue
        cur += c
    if cur.strip():
        out.append(cur.strip())
    return out


def main() -> int:
    copied = []
    for f in TTF:
        src = ORIG / "datafiles" / f
        write_bytes_if_changed(ASSETS / "fonts" / f, src.read_bytes())
        copied.append(f"assets/fonts/{f}")

    calls: list[dict[str, Any]] = []
    unparsed: list[str] = []
    for p in gml_files():
        src = read_text(p)
        masked = mask_comments_and_strings(src)
        lines = src.splitlines()
        for ln, mline in enumerate(masked.splitlines(), 1):
            if not re.search(r"\bfont_add\w*\s*\(", mline):
                continue
            line = lines[ln - 1]
            m = CALL_RE.match(line)
            loc = f"{rel(p)}:{ln}"
            if not m:
                unparsed.append(f"{loc}: {line.strip()}")
                continue
            args = split_args(m.group("args"))
            e: dict[str, Any] = {"location": loc, "global": m.group("lhs"), "function": m.group("fn"), "args_raw": args, "source": line.strip()}
            if m.group("fn") == "font_add":
                # font_add(name, size, bold, italic, first, last)
                e.update({
                    "font_file": args[0].strip('"'),
                    "size": float(args[1]),
                    "bold": args[2],
                    "italic": args[3],
                    "first": args[4],
                    "last": args[5],
                })
            elif m.group("fn") == "font_add_sprite_ext":
                # font_add_sprite_ext(spr, string_map, prop, sep)
                e.update({"sprite": args[0], "string_map": args[1].strip('"'), "proportional": args[2], "separation": args[3]})
            calls.append(e)

    write_json(TABLES / "fonts.json", {"ttf_files": copied, "call_count": len(calls), "calls": calls, "unparsed": unparsed})
    print(f"fonts: 复制 {len(copied)} 个 ttf, font_add* 调用 {len(calls)} 处, 未解析 {len(unparsed)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
