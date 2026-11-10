"""sprite 导入：每个 sprite 的各帧拼成横向条带 PNG + 总元数据表。

输入：original/openwe-ref/sprites/<名>/<名>.yy 与 sprites/<名>/<帧GUID>.png
     （不使用 layers/ 子目录里的图）
输出：port/assets/sprites/<名>.png
     port/tables/sprites.json
     port/tables/import_report_sprites.json  （异常清单）
"""
from __future__ import annotations

import io
import sys
from typing import Any

from PIL import Image

from gmlib import ASSETS, ORIG, TABLES, folder_of, load_yy, ref_name, resources, write_bytes_if_changed, write_json

OUT_DIR = ASSETS / "sprites"


def main() -> int:
    sprites: dict[str, Any] = {}
    anomalies: list[dict[str, Any]] = []
    written = 0

    def anomaly(name: str, kind: str, detail: str) -> None:
        anomalies.append({"sprite": name, "kind": kind, "detail": detail})

    sprite_list = resources("sprites")
    expected_files = set()
    for idx, name, path in sprite_list:
        yy_path = ORIG / path
        if not yy_path.exists():
            anomaly(name, "missing_yy", path)
            continue
        y = load_yy(yy_path)
        if y.get("name") != name:
            anomaly(name, "name_mismatch", f"yy name={y.get('name')}")
        w = int(y["width"])
        h = int(y["height"])
        frames: list[str] = [f["name"] for f in y["frames"]]
        seq = y["sequence"]
        tracks = seq.get("tracks", [])

        # 关键帧顺序/长度检查（sequence 的 frames 轨道）
        kf_names: list[str] = []
        kf_lengths: list[float] = []
        kf_keys: list[float] = []
        for t in tracks:
            if t.get("resourceType") == "GMSpriteFramesTrack":
                for k in t["keyframes"]["Keyframes"]:
                    kf_names.append(k["Channels"]["0"]["Id"]["name"])
                    kf_lengths.append(float(k["Length"]))
                    kf_keys.append(float(k["Key"]))
        if len(tracks) != 1:
            anomaly(name, "track_count", f"sequence.tracks 数量={len(tracks)}")
        if kf_names != frames:
            anomaly(name, "keyframe_order", "sequence 关键帧顺序与 frames 不一致")
        if any(l != 1.0 for l in kf_lengths):
            anomaly(name, "keyframe_length", f"关键帧 Length 不全为 1: {kf_lengths}")
        if kf_keys != [float(i) for i in range(len(kf_keys))]:
            anomaly(name, "keyframe_key", f"关键帧 Key 不是 0..n-1: {kf_keys}")
        if float(seq.get("length", -1)) != float(len(frames)):
            anomaly(name, "sequence_length", f"sequence.length={seq.get('length')} 帧数={len(frames)}")
        if len(y.get("layers", [])) != 1:
            anomaly(name, "layer_count", f"layers={len(y.get('layers', []))}")
        if seq["events"]["Keyframes"] or seq["moments"]["Keyframes"]:
            anomaly(name, "sequence_events", "sequence 有 events/moments 关键帧")
        if len(frames) == 0:
            anomaly(name, "no_frames", "frames 为空")

        strip = Image.new("RGBA", (max(w * max(len(frames), 1), 1), max(h, 1)), (0, 0, 0, 0))
        for fi, guid in enumerate(frames):
            png = ORIG / "sprites" / name / f"{guid}.png"
            if not png.exists():
                anomaly(name, "missing_frame", f"帧 {fi} 缺文件 {png.relative_to(ORIG).as_posix()}，条带中留空")
                continue
            with Image.open(png) as im:
                im.load()
                if im.size != (w, h):
                    anomaly(name, "frame_size", f"帧 {fi} 尺寸 {im.size[0]}x{im.size[1]} 与 yy {w}x{h} 不一致，按左上角对齐贴入")
                if im.mode != "RGBA":
                    anomaly(name, "frame_mode", f"帧 {fi} 颜色模式 {im.mode}，已转 RGBA")
                    im2 = im.convert("RGBA")
                else:
                    im2 = im
                strip.paste(im2, (fi * w, 0))
        buf = io.BytesIO()
        strip.save(buf, format="PNG", optimize=False, compress_level=6)
        out_png = OUT_DIR / f"{name}.png"
        expected_files.add(out_png.name)
        if write_bytes_if_changed(out_png, buf.getvalue()):
            written += 1

        nine = y.get("nineSlice")
        sprites[name] = {
            "index": idx,
            "file": f"assets/sprites/{name}.png",
            "frames": len(frames),
            "width": w,
            "height": h,
            "origin": y.get("origin"),
            "xorigin": seq.get("xorigin"),
            "yorigin": seq.get("yorigin"),
            "bbox_left": y.get("bbox_left"),
            "bbox_top": y.get("bbox_top"),
            "bbox_right": y.get("bbox_right"),
            "bbox_bottom": y.get("bbox_bottom"),
            "bboxMode": y.get("bboxMode"),
            "collisionKind": y.get("collisionKind"),
            "collisionTolerance": y.get("collisionTolerance"),
            "playbackSpeed": seq.get("playbackSpeed"),
            "playbackSpeedType": seq.get("playbackSpeedType"),
            "playback": seq.get("playback"),
            "sequence_length": seq.get("length"),
            "timeUnits": seq.get("timeUnits"),
            "HTile": y.get("HTile"),
            "VTile": y.get("VTile"),
            "type": y.get("type"),
            "edgeFiltering": y.get("edgeFiltering"),
            "preMultiplyAlpha": y.get("preMultiplyAlpha"),
            "nineSlice_enabled": bool(nine.get("enabled")) if isinstance(nine, dict) else None,
            "textureGroup": ref_name(y.get("textureGroupId")),
            "folder": folder_of(y),
            "frame_guids": frames,
        }

    # 清理条带目录中不属于任何 sprite 的旧 png（只动本脚本的输出目录）
    stale = []
    if OUT_DIR.exists():
        for p in sorted(OUT_DIR.glob("*.png")):
            if p.name not in expected_files:
                stale.append(p.name)
                p.unlink()
                imp = p.with_suffix(".png.import")
                if imp.exists():
                    imp.unlink()

    write_json(TABLES / "sprites.json", {"count": len(sprites), "sprites": sprites})
    write_json(TABLES / "import_report_sprites.json", {"anomaly_count": len(anomalies), "anomalies": anomalies, "removed_stale_png": stale})
    print(f"sprites: {len(sprites)} (yyp {len(sprite_list)}), png 写入 {written}, 异常 {len(anomalies)}, 清理旧文件 {len(stale)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
