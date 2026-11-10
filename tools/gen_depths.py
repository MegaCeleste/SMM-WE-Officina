"""depth 表 port/tables/object_depths.json。

解析 scripts/__global_object_depths/__global_object_depths.gml 中的
global.__objectDepths[i] = <数>; 与 global.__objectNames[i] = "<名>";
按 i 配对得到 名字→depth。

原版消费链（port-plan §1）：__global_object_depths.gml 末尾把表转成 global.__objectID2Depth，
object_get_depth() 读它，表里没有的 object 返回 0；instance_create() 用它作为新实例 depth。
"""
from __future__ import annotations

import re
import sys
from typing import Any

from gmlib import ORIG, TABLES, read_text, resources, write_json

SRC = ORIG / "scripts" / "__global_object_depths" / "__global_object_depths.gml"
DEPTH_RE = re.compile(r"^\s*global\.__objectDepths\[(\d+)\]\s*=\s*(-?\d+(?:\.\d+)?)\s*;?(?:\s*//\s*(\S+))?")
NAME_RE = re.compile(r'^\s*global\.__objectNames\[(\d+)\]\s*=\s*"([^"]*)"\s*;?')


def main() -> int:
    depths: dict[int, tuple[float, int, str | None]] = {}
    names: dict[int, tuple[str, int]] = {}
    anomalies: list[str] = []
    for ln, line in enumerate(read_text(SRC).splitlines(), 1):
        m = DEPTH_RE.match(line)
        if m:
            i = int(m.group(1))
            if i in depths:
                anomalies.append(f"__objectDepths[{i}] 重复赋值，行 {ln}")
            v = float(m.group(2))
            depths[i] = (v, ln, m.group(3))
            continue
        m = NAME_RE.match(line)
        if m:
            i = int(m.group(1))
            if i in names:
                anomalies.append(f"__objectNames[{i}] 重复赋值，行 {ln}")
            names[i] = (m.group(2), ln)
        elif "__objectDepths[" in line or "__objectNames[" in line:
            if "array_length" not in line and "asset_get_index" not in line and "__objectID2Depth" not in line:
                anomalies.append(f"未解析的行 {ln}: {line.strip()}")

    yyp_objs = [n for _, n, _ in resources("objects")]
    yyp_set = set(yyp_objs)
    table: dict[str, Any] = {}
    in_table_not_yyp: list[dict[str, Any]] = []
    for i in sorted(set(depths) | set(names)):
        if i not in depths or i not in names:
            anomalies.append(f"下标 {i} 只有 {'depth' if i in depths else 'name'}")
            continue
        d, dl, comment = depths[i]
        n, nl = names[i]
        if comment is not None and comment != n:
            anomalies.append(f"下标 {i} 的注释名 {comment} 与 __objectNames 的 {n} 不一致")
        dv: float | int = int(d) if d == int(d) else d
        if n in table:
            anomalies.append(f"名字 {n} 在表中出现多次（下标 {table[n]['array_index']} 与 {i}），原版循环后者覆盖前者")
        rec = {"depth": dv, "array_index": i, "src_depth_line": dl, "src_name_line": nl}
        if n not in yyp_set:
            in_table_not_yyp.append({"name": n, **rec})
            continue
        table[n] = rec
    not_in_table = [n for n in yyp_objs if n not in table]
    # 完整 名字→depth（yyp 中全部 object；不在表里的按 object_get_depth 逻辑为 0）
    full = {n: (table[n]["depth"] if n in table else 0) for n in yyp_objs}
    out = {
        "source": "scripts/__global_object_depths/__global_object_depths.gml",
        "array_entries": len(depths),
        "matched_yyp_objects": len(table),
        "depth_by_object": full,
        "table_entries": table,
        "in_table_not_in_yyp": in_table_not_yyp,
        "in_yyp_not_in_table": not_in_table,
        "note": "不在表里的 object：object_get_depth() 返回 0（scripts/object_get_depth/object_get_depth.gml:7-11）；表里有但 yyp 没有的名字，asset_get_index 返回 -1，被 __global_object_depths.gml:1605 的 objID >= 0 判断跳过",
        "anomalies": anomalies,
    }
    write_json(TABLES / "object_depths.json", out)
    print(f"depths: 表 {len(depths)} 项, 匹配 yyp {len(table)}, 表有 yyp 无 {len(in_table_not_yyp)}, yyp 有表无 {len(not_in_table)}, 异常 {len(anomalies)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
