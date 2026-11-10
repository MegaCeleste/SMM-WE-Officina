"""资源名映射 port/tables/asset_names.json：各类资源的名字列表（yyp resources 顺序）。

列表下标 = 该类资源在 yyp 里的出现序号。注意：这不一定等于 GMS 运行时的资源编号
（GMS 编译时如何分配 object/sprite 编号未在仓库内确认），见 docs/batch0-notes.md。
"""
from __future__ import annotations

import sys

from gmlib import TABLES, resources, write_json

KINDS = ["objects", "sprites", "sounds", "rooms", "paths", "shaders", "scripts", "extensions", "notes"]


def main() -> int:
    out: dict[str, object] = {}
    counts: dict[str, int] = {}
    for k in KINDS:
        names = [n for _, n, _ in resources(k)]
        out[k] = names
        counts[k] = len(names)
    write_json(TABLES / "asset_names.json", {"counts": counts, **out})
    print(f"asset_names: {counts}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
