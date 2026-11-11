"""第 2 批：生成 autoload `G`（port/globals/g.gd）：原版全部 global.* 变量（port-plan §3.1）。

只读 port/tables/globals.json（第 0 批从原码抽出的变量清单），只写 port/globals/g.gd。

类型规则（与 tools/gml2gd.py 的 global_kind 一致，转换出的代码按这个类型写字面量和 match 分支）：
- number → float，初值 0.0
- string → String，初值 ""
- bool   → bool，初值 false
- font / resource:* → int，初值 -1（资源编号、字体编号）
- array / ds_list → Array，初值 []（ds_list 按 port-plan §3.1 映射成 Array）
- 其余（不确定、混合）→ 不带类型，初值 null

GML 里读一个从没赋过值的 global 是运行时错误；这里统一给了初值，所以这类错误在移植版里不会出现。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gmlib import PORT, TABLES, write_bytes_if_changed  # noqa: E402
from gml2gd import GD_RESERVED, NODE_MEMBERS  # noqa: E402

TYPES = {
    "number": ("float", "0.0"),
    "string": ("String", '""'),
    "bool": ("bool", "false"),
    "font": ("int", "-1"),
    "resource:sound": ("int", "-1"),
    "array": ("Array", "[]"),
    "ds_list": ("Array", "[]"),
}


# 类型推断错了的变量：强制不带类型（第 3 批：save_changes 推断成 number，实际存关卡文件名）
UNTYPED = {"save_changes"}


def main() -> int:
    g = json.loads((TABLES / "globals.json").read_text(encoding="utf-8"))["globals"]
    lines = [
        "# 由 tools/gen_g.py 从 tables/globals.json 生成，不要手改。",
        "# 原版的全部 global.* 变量（autoload G）。类型规则见 tools/gen_g.py 的说明。",
        "extends Node",
        "",
    ]
    bad = []
    for name in sorted(g):
        if name in GD_RESERVED or name in NODE_MEMBERS:
            bad.append(name)
            continue
        lt = g[name].get("likely_type")
        if lt in TYPES and name not in UNTYPED:
            t, v = TYPES[lt]
            lines.append(f"var {name}: {t} = {v}")
        else:
            lines.append(f"var {name} = null  # 类型不确定：{g[name].get('inferred_type')}")
    if bad:
        print("gen_g: 这些 global 和 Node 成员或 GDScript 保留字撞名，需要改名规则：", bad)
        return 1
    lines.append("")
    write_bytes_if_changed(PORT / "globals" / "g.gd", "\n".join(lines).encode("utf-8"))
    print(f"gen_g: {len(g)} 个 global → port/globals/g.gd")
    return 0


if __name__ == "__main__":
    sys.exit(main())
