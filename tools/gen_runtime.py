"""第 1 批：生成运行时用的两份文件（读 port/tables，不读 original/）。

- port/gm/a.gd            class_name A：全部资源名常量（object/sprite/sound/room/path/shader → int）
- port/tables/runtime.json 兼容层启动时读的精简表（只留运行时用得到的字段）

编号 = 该类资源在 yyp 里的出现序号（即各表的 index）。这不是 GMS 运行时的真实编号，
原版代码里出现的裸数字资源 ID 不能直接拿来查这张表（见 docs/batch0-notes.md §3）。
"""
from __future__ import annotations

import json
import sys

from gmlib import PORT, TABLES, write_bytes_if_changed, write_json


def _load(name: str):
    return json.loads((TABLES / name).read_text(encoding="utf-8"))


def main() -> int:
    names = _load("asset_names.json")
    objects = _load("objects.json")["objects"]
    sprites = _load("sprites.json")["sprites"]
    sounds = _load("sounds.json")["sounds"]
    rooms = _load("rooms.json")
    depths = _load("object_depths.json")["depth_by_object"]

    spr_idx = {n: i for i, n in enumerate(names["sprites"])}
    obj_idx = {n: i for i, n in enumerate(names["objects"])}

    # ---- a.gd ----
    lines = [
        "# 由 tools/gen_runtime.py 生成，不要手改。",
        "# 全部资源名常量。编号是 yyp 顺序，不是 GMS 运行时编号。",
        "class_name A",
        "",
    ]
    seen: dict[str, str] = {}
    for kind in ("objects", "sprites", "sounds", "rooms", "paths", "shaders"):
        lines.append(f"# ---- {kind} ({len(names[kind])}) ----")
        for i, n in enumerate(names[kind]):
            if n in seen:
                print(f"gen_runtime: 资源名重复 {n}（{seen[n]} / {kind}）")
                return 1
            seen[n] = kind
            lines.append(f"const {n}: int = {i}")
        lines.append("")
    write_bytes_if_changed(PORT / "gm" / "a.gd", "\n".join(lines).encode("utf-8"))

    # ---- runtime.json ----
    rt_objects = []
    shadow_exclusions = []
    composite_draws = {
        "obj_persistent", "obj_levelmanager", "obj_editormanager", "obj_cursor",
        "obj_lava_water", "obj_lave_draw",  # Fluid strips form one continuous surface.
    }
    for n in names["objects"]:
        o = objects[n]
        assert o["index"] == obj_idx[n], n
        folder = o["folder"]
        interface = folder.startswith(("Objects/UI/", "Objects/Editor Res "))
        transition = folder == "Objects/Interactive/Special/Transitions"
        if interface or transition or n in composite_draws:
            shadow_exclusions.append(o["index"])
        rt_objects.append([
            n,
            obj_idx.get(o["parent"], -1) if o["parent"] else -1,
            spr_idx.get(o["sprite"], -1) if o["sprite"] else -1,
            spr_idx.get(o["mask"], -1) if o["mask"] else -1,
            1 if o["visible"] else 0,
            1 if o["persistent"] else 0,
            depths.get(n, 0),
        ])
    rt_sprites = []
    for n in names["sprites"]:
        s = sprites[n]
        assert s["index"] == spr_idx[n], n
        rt_sprites.append([
            n, s["frames"], s["width"], s["height"], s["xorigin"], s["yorigin"],
            s["bbox_left"], s["bbox_top"], s["bbox_right"], s["bbox_bottom"],
            s["collisionKind"], s["playbackSpeed"], s["playbackSpeedType"],
            s["collisionTolerance"],
        ])
    rt_sounds = []
    for n in names["sounds"]:
        s = sounds[n]
        rt_sounds.append([n, s["file"], s["volume"]])
    rt_rooms = []
    for n in rooms["room_order"]:
        r = rooms["rooms"][n]
        insts = []
        for iname in r["instanceCreationOrder"]:
            it = r["instances"][iname]
            insts.append({
                "name": iname,
                "object": obj_idx[it["object"]],
                "x": it["x"], "y": it["y"],
                "scaleX": it["scaleX"], "scaleY": it["scaleY"],
                "rotation": it["rotation"],
                "imageIndex": it["imageIndex"], "imageSpeed": it["imageSpeed"],
                "colour": it["colour"]["raw"],
                "depth": it["layer_depth"],
                "hasCreationCode": it["hasCreationCode"],
            })
        missing = set(r["instances"]) - set(r["instanceCreationOrder"])
        if missing:
            print(f"gen_runtime: {n} 有实例不在 instanceCreationOrder 里：{sorted(missing)}")
            return 1
        rt_rooms.append({
            "name": n, "width": r["width"], "height": r["height"],
            "persistent": r["persistent"],
            "instances": insts,
            # 全部图层（实例图层只留名字和 depth，实例本身在 instances 里）：layer_get_all 要列出它们
            "layers": [{k: v for k, v in l.items() if k != "instances"} for l in r["layers"]],
        })
    write_json(TABLES / "runtime.json", {
        "objects": rt_objects, "sprites": rt_sprites, "sounds": rt_sounds, "rooms": rt_rooms,
        "sprite_shadow_exclusions": shadow_exclusions,
    })
    print(f"gen_runtime: objects {len(rt_objects)}, sprites {len(rt_sprites)}, "
          f"sounds {len(rt_sounds)}, rooms {len(rt_rooms)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
