"""第 5 批：路径表 port/tables/paths.json。

每个 path：编号（yyp 顺序，与 a.gd 的 pth_ 常量一致）、closed、kind（0 直线，1 平滑）、precision、
points（x、y、speed）。只读 original/，只写 port/tables/。
"""
from __future__ import annotations

import sys
from typing import Any

from gmlib import ORIG, TABLES, load_yy, resources, write_json


def main() -> int:
    out: dict[str, Any] = {}
    for idx, name, path in resources("paths"):
        y = load_yy(ORIG / path)
        out[name] = {
            "index": idx,
            "closed": bool(y["closed"]),
            "kind": int(y["kind"]),
            "precision": int(y["precision"]),
            "points": [[float(p["x"]), float(p["y"]), float(p["speed"])] for p in y["points"]],
        }
    write_json(TABLES / "paths.json", {"count": len(out), "paths": out})
    print(f"gen_paths: {len(out)} paths → port/tables/paths.json")
    return 0


if __name__ == "__main__":
    sys.exit(main())
