"""room 表 port/tables/rooms.json。

每个 room：尺寸、persistent、创建代码、views 设置、图层（名字、类型、depth、可见性、
背景 sprite/颜色/平铺/偏移/速度、资源层的图块）、实例（object、坐标、缩放、旋转、颜色、
image_index/speed、所在层 depth、创建代码原文）、instanceCreationOrder，以及 room order。

颜色：yy 里是 ABGR 的 32 位整数，这里额外给出拆开的 r/g/b/a 便于核对。
"""
from __future__ import annotations

import sys
from typing import Any

from gmlib import ORIG, TABLES, folder_of, load_yy, read_text, ref_name, resources, write_json, yyp


def colour(v: Any) -> Any:
    if not isinstance(v, int):
        return v
    return {"raw": v, "r": v & 0xFF, "g": (v >> 8) & 0xFF, "b": (v >> 16) & 0xFF, "a": (v >> 24) & 0xFF}


def main() -> int:
    rooms: dict[str, Any] = {}
    anomalies: list[dict[str, Any]] = []
    order = [n["roomId"]["name"] for n in yyp()["RoomOrderNodes"]]
    lst = resources("rooms")
    for idx, name, path in lst:
        yy_path = ORIG / path
        rdir = yy_path.parent
        y = load_yy(yy_path)
        rs = y["roomSettings"]
        layers_out: list[dict[str, Any]] = []
        instances: dict[str, Any] = {}

        def walk(layers: list[Any], parent: str | None) -> None:
            for L in layers:
                rt = L["resourceType"]
                lo: dict[str, Any] = {
                    "name": L["name"],
                    "type": rt,
                    "depth": L.get("depth"),
                    "visible": L.get("visible"),
                    "userdefinedDepth": L.get("userdefinedDepth"),
                    "parent_layer": parent,
                }
                if rt == "GMRBackgroundLayer":
                    lo.update({
                        "sprite": ref_name(L.get("spriteId")),
                        "colour": colour(L.get("colour")),
                        "htiled": L.get("htiled"),
                        "vtiled": L.get("vtiled"),
                        "stretch": L.get("stretch"),
                        "x": L.get("x"),
                        "y": L.get("y"),
                        "hspeed": L.get("hspeed"),
                        "vspeed": L.get("vspeed"),
                        "animationFPS": L.get("animationFPS"),
                        "animationSpeedType": L.get("animationSpeedType"),
                        "userdefinedAnimFPS": L.get("userdefinedAnimFPS"),
                    })
                elif rt == "GMRAssetLayer":
                    assets = []
                    for a in L.get("assets", []):
                        ad = {k: a.get(k) for k in a if k not in ("resourceType", "resourceVersion")}
                        if "spriteId" in ad:
                            ad["spriteId"] = ref_name(ad["spriteId"])
                        if "colour" in ad:
                            ad["colour"] = colour(ad["colour"])
                        assets.append(ad)
                        if a.get("spriteId") is None:
                            anomalies.append({"room": name, "kind": "asset_without_sprite", "detail": f"资源层 {L['name']} 的 {a.get('name')} spriteId 为 null（{a.get('resourceType')}，u0..v1={a.get('u0')},{a.get('u1')},{a.get('v0')},{a.get('v1')}）"})
                    lo["assets"] = assets
                elif rt == "GMRInstanceLayer":
                    names_in_layer = []
                    for inst in L.get("instances", []):
                        iname = inst["name"]
                        code = None
                        code_file = None
                        if inst.get("hasCreationCode"):
                            cf = rdir / f"InstanceCreationCode_{iname}.gml"
                            code_file = cf.relative_to(ORIG).as_posix()
                            if cf.exists():
                                code = read_text(cf)
                            else:
                                anomalies.append({"room": name, "kind": "missing_creation_code", "detail": f"{iname} hasCreationCode=true 但缺 {code_file}"})
                        instances[iname] = {
                            "object": ref_name(inst.get("objectId")),
                            "x": inst.get("x"),
                            "y": inst.get("y"),
                            "scaleX": inst.get("scaleX"),
                            "scaleY": inst.get("scaleY"),
                            "rotation": inst.get("rotation"),
                            "colour": colour(inst.get("colour")),
                            "imageIndex": inst.get("imageIndex"),
                            "imageSpeed": inst.get("imageSpeed"),
                            "ignore": inst.get("ignore"),
                            "frozen": inst.get("frozen"),
                            "properties": inst.get("properties"),
                            "layer": L["name"],
                            "layer_depth": L.get("depth"),
                            "hasCreationCode": inst.get("hasCreationCode"),
                            "creation_code_file": code_file,
                            "creation_code": code,
                        }
                        names_in_layer.append(iname)
                    lo["instances"] = names_in_layer
                else:
                    anomalies.append({"room": name, "kind": "unknown_layer_type", "detail": rt})
                    lo["raw"] = {k: v for k, v in L.items() if k != "layers"}
                layers_out.append(lo)
                walk(L.get("layers", []), L["name"])

        walk(y.get("layers", []), None)
        creation_order = [c["name"] for c in y.get("instanceCreationOrder", [])]
        if set(creation_order) != set(instances):
            anomalies.append({"room": name, "kind": "creation_order_mismatch", "detail": f"instanceCreationOrder 与图层实例不一致: 仅在顺序中 {sorted(set(creation_order) - set(instances))}, 仅在图层中 {sorted(set(instances) - set(creation_order))}"})
        # 磁盘上多余的实例创建代码
        for f in sorted(rdir.glob("InstanceCreationCode_*.gml")):
            iname = f.stem[len("InstanceCreationCode_"):]
            if iname not in instances or not instances[iname]["hasCreationCode"]:
                anomalies.append({"room": name, "kind": "orphan_creation_code", "detail": f.relative_to(ORIG).as_posix()})
        ccf: str = y.get("creationCodeFile", "")
        room_code = None
        if ccf:
            p = ccf.replace("${project_dir}/", "")
            if (ORIG / p).exists():
                room_code = read_text(ORIG / p)
            else:
                anomalies.append({"room": name, "kind": "missing_room_creation_code", "detail": f"creationCodeFile={ccf}，磁盘无 {p}"})
        rooms[name] = {
            "index": idx,
            "room_order": order.index(name) if name in order else None,
            "width": rs.get("Width"),
            "height": rs.get("Height"),
            "persistent": rs.get("persistent"),
            "creationCodeFile": ccf,
            "creation_code": room_code,
            "inheritLayers": y.get("inheritLayers"),
            "parentRoom": ref_name(y.get("parentRoom")),
            "folder": folder_of(y),
            "viewSettings": y.get("viewSettings"),
            "views": y.get("views"),
            "physicsWorld": y.get("physicsSettings", {}).get("PhysicsWorld"),
            "layers": layers_out,
            "instanceCreationOrder": creation_order,
            "instances": instances,
        }
    write_json(TABLES / "rooms.json", {"count": len(rooms), "room_order": order, "rooms": rooms, "anomalies": anomalies})
    print(f"rooms: {len(rooms)} (yyp {len(lst)}), 实例 {sum(len(r['instances']) for r in rooms.values())}, 异常 {len(anomalies)}")
    for a in anomalies:
        print("  ", a)
    return 0


if __name__ == "__main__":
    sys.exit(main())
