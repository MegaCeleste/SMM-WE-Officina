"""object 表 port/tables/objects.json。

每个 object：yyp 顺序号、父 object、sprite、mask、visible、persistent、solid、文件夹、
事件列表（类型、编号、碰撞目标、对应 .gml 是否存在）、磁盘上实际存在的 .gml。

yy 里缺 collisionObjectId 的碰撞事件（清单 §6.1，3 个 object）按“目标是自身”记录，
并加 "collision_target_inferred": true 标记（port-plan §9 Q7）。
"""
from __future__ import annotations

import sys
from typing import Any

from gmlib import ORIG, TABLES, folder_of, load_yy, ref_name, resources, write_json

EVENT_TYPES = {
    0: "Create", 1: "Destroy", 2: "Alarm", 3: "Step", 4: "Collision", 5: "Keyboard",
    6: "Mouse", 7: "Other", 8: "Draw", 9: "KeyPress", 10: "KeyRelease", 11: "Trigger",
    12: "CleanUp", 13: "Gesture", 14: "PreCreate",
}


def main() -> int:
    objs: dict[str, Any] = {}
    anomalies: list[dict[str, Any]] = []
    lst = resources("objects")
    names = {n for _, n, _ in lst}
    for idx, name, path in lst:
        y = load_yy(ORIG / path)
        obj_dir = (ORIG / path).parent
        disk = sorted(p.name for p in obj_dir.glob("*.gml"))
        events: list[dict[str, Any]] = []
        used: set[str] = set()
        for ev in y.get("eventList", []):
            et = int(ev["eventType"])
            en = int(ev["eventNum"])
            tname = EVENT_TYPES.get(et, f"Type{et}")
            e: dict[str, Any] = {"type": et, "type_name": tname, "num": en}
            if et == 4:
                if "collisionObjectId" in ev:
                    target = ref_name(ev["collisionObjectId"])
                    e["collision_target"] = target
                    if target is None:
                        anomalies.append({"object": name, "kind": "collision_null_target", "detail": "collisionObjectId 为 null"})
                else:
                    e["collision_target"] = name
                    e["collision_target_inferred"] = True
                    anomalies.append({"object": name, "kind": "collision_missing_target", "detail": f"yy 缺 collisionObjectId，按目标=自身记录（磁盘有 Collision_{name}.gml: {('Collision_' + name + '.gml') in disk}）"})
                fname = f"Collision_{e['collision_target']}.gml"
            else:
                fname = f"{tname}_{en}.gml"
            e["file"] = fname
            e["file_exists"] = fname in disk
            if not e["file_exists"]:
                anomalies.append({"object": name, "kind": "event_without_file", "detail": f"yy 登记 {tname} {en}，磁盘无 {fname}"})
            if ev.get("isDnD"):
                e["isDnD"] = True
            used.add(fname)
            events.append(e)
        extra = [f for f in disk if f not in used]
        for f in extra:
            anomalies.append({"object": name, "kind": "gml_without_event", "detail": f"磁盘有 {f} 但 yy 未登记对应事件"})
        parent = ref_name(y.get("parentObjectId"))
        if parent is not None and parent not in names:
            anomalies.append({"object": name, "kind": "unknown_parent", "detail": parent})
        objs[name] = {
            "index": idx,
            "parent": parent,
            "sprite": ref_name(y.get("spriteId")),
            "mask": ref_name(y.get("spriteMaskId")),
            "visible": y.get("visible"),
            "persistent": y.get("persistent"),
            "solid": y.get("solid"),
            "managed": y.get("managed"),
            "physicsObject": y.get("physicsObject"),
            "properties": y.get("properties"),
            "overriddenProperties": y.get("overriddenProperties"),
            "folder": folder_of(y),
            "events": events,
            "gml_files": disk,
        }
        if y.get("properties") or y.get("overriddenProperties"):
            anomalies.append({"object": name, "kind": "object_properties", "detail": "有 object variables（properties/overriddenProperties）"})

    write_json(TABLES / "objects.json", {"count": len(objs), "objects": objs})
    write_json(TABLES / "import_report_objects.json", {"anomaly_count": len(anomalies), "anomalies": anomalies})
    print(f"objects: {len(objs)} (yyp {len(lst)}), 异常 {len(anomalies)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
