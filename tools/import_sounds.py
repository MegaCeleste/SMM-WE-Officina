"""sound 导入：复制音频文件到 port/assets/sounds/，生成 port/tables/sounds.json。

原工程里不少音频文件没有扩展名（yy 的 soundFile 就是无扩展名的文件名），
这里按文件头判断格式（OggS / RIFF-WAVE / ID3 或 MPEG 帧头），输出时补上正确扩展名，
因为 Godot 按扩展名选择导入器。
"""
from __future__ import annotations

import sys
from typing import Any

from gmlib import ASSETS, ORIG, TABLES, folder_of, load_yy, ref_name, resources, write_bytes_if_changed, write_json

OUT_DIR = ASSETS / "sounds"


def sniff(data: bytes) -> str | None:
    if data[:4] == b"OggS":
        return "ogg"
    if data[:4] == b"RIFF" and data[8:12] == b"WAVE":
        return "wav"
    if data[:3] == b"ID3" or (len(data) > 1 and data[0] == 0xFF and (data[1] & 0xE0) == 0xE0):
        return "mp3"
    return None


def main() -> int:
    table: dict[str, Any] = {}
    anomalies: list[dict[str, Any]] = []
    expected: set[str] = set()
    written = 0
    lst = resources("sounds")
    for idx, name, path in lst:
        yy_path = ORIG / path
        y = load_yy(yy_path)
        sf: str = y.get("soundFile", "")
        src = ORIG / "sounds" / name / sf
        entry: dict[str, Any] = {
            "index": idx,
            "soundFile": sf,
            "file": None,
            "format": None,
            "volume": y.get("volume"),
            "type": y.get("type"),
            "compression": y.get("compression"),
            "conversionMode": y.get("conversionMode"),
            "bitDepth": y.get("bitDepth"),
            "bitRate": y.get("bitRate"),
            "sampleRate": y.get("sampleRate"),
            "duration": y.get("duration"),
            "preload": y.get("preload"),
            "audioGroup": ref_name(y.get("audioGroupId")),
            "folder": folder_of(y),
        }
        if not src.is_file():
            anomalies.append({"sound": name, "kind": "missing_file", "detail": f"sounds/{name}/{sf} 不存在"})
            table[name] = entry
            continue
        data = src.read_bytes()
        fmt = sniff(data)
        ext = src.suffix.lower().lstrip(".")
        if fmt is None:
            anomalies.append({"sound": name, "kind": "unknown_format", "detail": f"无法识别文件头 {data[:12]!r}，按原扩展名 '{ext}' 复制"})
            fmt = ext or "bin"
        elif ext and ext != fmt:
            anomalies.append({"sound": name, "kind": "ext_mismatch", "detail": f"扩展名 .{ext} 但文件头是 {fmt}"})
        out_name = f"{name}.{fmt}"
        expected.add(out_name)
        if write_bytes_if_changed(OUT_DIR / out_name, data):
            written += 1
        entry["file"] = f"assets/sounds/{out_name}"
        entry["format"] = fmt
        others = sorted(p.name for p in (ORIG / "sounds" / name).iterdir() if p.name not in (sf, f"{name}.yy"))
        if others:
            anomalies.append({"sound": name, "kind": "extra_files", "detail": f"目录里还有 {others}"})
        table[name] = entry

    stale = []
    if OUT_DIR.exists():
        for p in sorted(OUT_DIR.iterdir()):
            if p.suffix != ".import" and p.name not in expected:
                stale.append(p.name)
                p.unlink()
                imp = p.with_name(p.name + ".import")
                if imp.exists():
                    imp.unlink()

    write_json(TABLES / "sounds.json", {"count": len(table), "sounds": table})
    write_json(TABLES / "import_report_sounds.json", {"anomaly_count": len(anomalies), "anomalies": anomalies, "removed_stale": stale})
    fmts: dict[str, int] = {}
    for e in table.values():
        fmts[str(e["format"])] = fmts.get(str(e["format"]), 0) + 1
    print(f"sounds: {len(table)} (yyp {len(lst)}), 写入 {written}, 格式 {fmts}, 异常 {len(anomalies)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
