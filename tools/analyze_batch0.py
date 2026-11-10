"""第 0 批统计（供 docs/batch0-notes.md 引用）。只读 original/ 与已生成的 port/tables/*.json。

输出：
- 标准输出：collisionKind / bboxMode / 播放速度分布、遮罩 sprite 统计、运行时 solid 赋值
- port/tables/mask_sprites.json：可能被用作碰撞遮罩的 sprite 清单及来源
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter, defaultdict
from typing import Any

from gmlib import ORIG, TABLES, gml_files, mask_comments_and_strings, read_text, rel, write_json

ASSIGN_RE = re.compile(r"(?P<prefix>[\w.\]\)]*\.)?\b(?P<var>mask_index|sprite_index)\s*=(?!=)\s*(?P<rhs>[A-Za-z_]\w*)?")
SOLID_RE = re.compile(r"(?P<prefix>[\w.\]\)]*\.)?(?<![\w])solid\s*(?P<op>=(?!=)|\+=|-=)")
CMP_BEFORE = re.compile(r"(\bif|\bwhile|\buntil|\breturn|&&|\|\||\band\b|\bor\b|[(,!=<>?:])\s*$")


def main() -> int:
    sprites = json.loads((TABLES / "sprites.json").read_text(encoding="utf-8"))["sprites"]
    objects = json.loads((TABLES / "objects.json").read_text(encoding="utf-8"))["objects"]

    ck = Counter(s["collisionKind"] for s in sprites.values())
    bm = Counter(s["bboxMode"] for s in sprites.values())
    ckbm = Counter((s["collisionKind"], s["bboxMode"]) for s in sprites.values())
    pst = Counter((s["playbackSpeedType"], s["playbackSpeed"]) for s in sprites.values())
    print("collisionKind:", dict(sorted(ck.items())))
    print("bboxMode:", dict(sorted(bm.items())))
    print("(collisionKind,bboxMode):", dict(sorted(ckbm.items())))
    print("(playbackSpeedType,playbackSpeed):", dict(sorted(pst.items(), key=lambda kv: (kv[0][0], kv[0][1]))))
    not_one = [n for n, s in sprites.items() if not (s["playbackSpeedType"] == 1 and s["playbackSpeed"] == 1.0)]
    print("非“每游戏帧 1 帧”的 sprite 数:", len(not_one))
    multi = [n for n in not_one if sprites[n]["frames"] > 1]
    print("  其中帧数>1 的:", len(multi))

    sources: dict[str, list[str]] = defaultdict(list)
    for name, o in objects.items():
        if o["sprite"]:
            sources[o["sprite"]].append(f"object_sprite:{name}" + ("" if o["mask"] else "(无mask)"))
        if o["mask"]:
            sources[o["mask"]].append(f"object_mask:{name}")

    code_assign: Counter[str] = Counter()
    nonliteral: list[str] = []
    solid_hits: list[str] = []
    for p in gml_files():
        src = read_text(p)
        masked = mask_comments_and_strings(src)
        rp = rel(p)
        owner = rp.split("/")[1] if rp.startswith("objects/") else None
        for ln, line in enumerate(masked.splitlines(), 1):
            for m in ASSIGN_RE.finditer(line):
                if CMP_BEFORE.search(line[: m.start("var") - (len(m.group("prefix")) if m.group("prefix") else 0)]):
                    continue
                rhs = m.group("rhs")
                var = m.group("var")
                code_assign[var] += 1
                if rhs and rhs in sprites:
                    tag = f"{var}{'(带前缀 ' + m.group('prefix') + ')' if m.group('prefix') else ''}@{rp}:{ln}"
                    if var == "sprite_index" and not m.group("prefix") and owner in objects and objects[owner]["mask"]:
                        tag += "(该 object 有 mask，不影响碰撞)"
                    sources[rhs].append(tag)
                else:
                    nonliteral.append(f"{rp}:{ln}: {src.splitlines()[ln - 1].strip()[:120]}")
            for m in SOLID_RE.finditer(line):
                before = line[: m.start()]
                if re.search(r"[\w]$", before):
                    continue
                solid_hits.append(f"{rp}:{ln}: {src.splitlines()[ln - 1].strip()[:120]}")

    def affects(tags: list[str]) -> bool:
        for t in tags:
            if t.startswith("object_mask:") or t.startswith("mask_index"):
                return True
            if t.startswith("object_sprite:") and t.endswith("(无mask)"):
                return True
            if t.startswith("sprite_index") and "不影响碰撞" not in t:
                return True
        return False

    mask_table: dict[str, Any] = {}
    for n in sorted(sources):
        mask_table[n] = {
            "collisionKind": sprites[n]["collisionKind"],
            "bboxMode": sprites[n]["bboxMode"],
            "frames": sprites[n]["frames"],
            "likely_collision": affects(sources[n]),
            "sources": sources[n],
        }
    all_ck = Counter(v["collisionKind"] for v in mask_table.values())
    strict_ck = Counter(v["collisionKind"] for v in mask_table.values() if v["likely_collision"])
    obj_only = {n for n, v in mask_table.items() if any(t.startswith("object_") and ("mask" in t.split(":")[0] or t.endswith("(无mask)")) for t in v["sources"])}
    obj_ck = Counter(sprites[n]["collisionKind"] for n in obj_only)
    print("被引用为 object sprite/mask 或代码赋给 mask_index/sprite_index 的 sprite:", len(mask_table), dict(sorted(all_ck.items())))
    print("  其中可能实际参与碰撞的:", sum(strict_ck.values()), dict(sorted(strict_ck.items())))
    print("  仅 object 的 mask 或 无mask object 的 sprite:", len(obj_only), dict(sorted(obj_ck.items())))
    prec_frames = sum(v["frames"] for v in mask_table.values() if v["likely_collision"] and v["collisionKind"] in (0, 4))
    print("  可能参与碰撞且为 precise(0/4) 的 sprite 帧总数:", prec_frames)
    print("代码中 mask_index/sprite_index 赋值次数:", dict(code_assign), "右值非 sprite 字面量的:", len(nonliteral))
    print("运行时 solid 赋值（内置变量）:", len(solid_hits))
    for s in solid_hits:
        print("   ", s)
    write_json(TABLES / "mask_sprites.json", {
        "note": "likely_collision=true：作为 object 的 mask、无 mask 的 object 的 sprite、代码赋给 mask_index，或赋给（无 mask 或目标不明的）sprite_index。静态推断，未覆盖通过脚本返回值/变量赋值的情况（见 nonliteral_assignments）。",
        "count": len(mask_table),
        "likely_collision_count": sum(1 for v in mask_table.values() if v["likely_collision"]),
        "by_collisionKind_all": {str(k): v for k, v in sorted(all_ck.items())},
        "by_collisionKind_likely": {str(k): v for k, v in sorted(strict_ck.items())},
        "sprites": mask_table,
        "nonliteral_assignments": nonliteral,
        "solid_assignments": solid_hits,
    })
    return 0


if __name__ == "__main__":
    sys.exit(main())
