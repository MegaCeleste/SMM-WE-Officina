"""global 变量清单 port/tables/globals.json（只做清单，不生成 GDScript）。

扫描 objects/ scripts/ rooms/ extensions/ 下全部 .gml（先把注释和字符串内容置空再匹配），
抽出所有 `global.<名>`：
- refs：引用次数（含读写）
- files：涉及文件数
- first_assignment：按“文件路径字典序 + 行号”找到的第一处赋值（`=`，不含 `==`；含 `global.x[i] = `）。
  注意这是静态顺序，不是运行时执行顺序。
- assignment_count / compound_count：普通赋值次数 / 复合赋值（+= -= *= /= ++ --）次数
- inferred_type：对所有普通赋值右值逐个分类后合并：
  number / string / array / resource:<种类> / ds_map / ds_list / font / bool / 不确定
"""
from __future__ import annotations

import re
import sys
from collections import Counter
from typing import Any

from gmlib import ORIG, TABLES, gml_files, mask_comments_and_strings, read_text, rel, resources, write_json

REF_RE = re.compile(r"\bglobal\s*\.\s*([A-Za-z_]\w*)")
ASSIGN_RE = re.compile(r"\bglobal\s*\.\s*([A-Za-z_]\w*)\s*(\[[^\]]*\](?:\s*\[[^\]]*\])?)?\s*(=)(?!=)")
COMPOUND_RE = re.compile(r"\bglobal\s*\.\s*([A-Za-z_]\w*)\s*(?:\[[^\]]*\])?\s*(\+=|-=|\*=|/=|\|=|&=|\^=|\+\+|--)")
PRE_INC_RE = re.compile(r"(\+\+|--)\s*global\s*\.\s*([A-Za-z_]\w*)")
NUM_RE = re.compile(r"^-?\s*(\d+(\.\d*)?|\.\d+|\$[0-9A-Fa-f]+|0x[0-9A-Fa-f]+)$")

NUM_FUNCS = {"real", "floor", "ceil", "round", "abs", "min", "max", "irandom", "random", "irandom_range", "random_range",
             "clamp", "sqrt", "sign", "point_distance", "point_direction", "lengthdir_x", "lengthdir_y", "string_length",
             "ds_list_size", "ds_map_size", "array_length", "array_length_1d", "get_timer", "current_time", "keyboard_check",
             "ds_map_find_value", "audio_play_sound", "instance_number", "date_current_datetime", "string_pos", "ord", "make_colour_rgb",
             "make_color_rgb", "file_text_open_read", "file_text_open_write", "file_text_read_real", "variable_global_get"}
STR_FUNCS = {"string", "string_copy", "string_upper", "string_lower", "string_replace", "string_replace_all", "chr", "ansi_char",
             "file_text_read_string", "get_string", "filename_name", "filename_path", "string_format", "keyboard_string",
             "program_directory", "working_directory", "game_save_id", "scr_language", "string_char_at", "string_delete",
             "string_insert", "json_encode", "base64_encode", "md5_string_utf8", "sha1_string_utf8", "environment_get_variable",
             "game_project_name", "temp_directory"}


def load_macros() -> dict[str, str]:
    out: dict[str, str] = {}
    for p in gml_files():
        for line in read_text(p).splitlines():
            m = re.match(r"^\s*#macro\s+(\w+)\s+(.*)$", line)
            if m:
                out[m.group(1)] = m.group(2).strip()
    return out


def main() -> int:
    asset_kind: dict[str, str] = {}
    for kind in ("objects", "sprites", "sounds", "rooms", "paths", "shaders", "scripts"):
        for _, n, _ in resources(kind):
            asset_kind[n] = kind[:-1]
    macros = load_macros()
    builtin_consts = {"true": "bool", "false": "bool", "noone": "number", "pi": "number", "c_white": "number", "c_black": "number",
                      "c_red": "number", "c_yellow": "number", "c_blue": "number", "c_green": "number", "c_gray": "number", "c_grey": "number",
                      "c_lime": "number", "c_orange": "number", "c_aqua": "number", "c_fuchsia": "number", "c_silver": "number",
                      "fa_left": "number", "fa_center": "number", "fa_right": "number", "fa_top": "number", "fa_middle": "number",
                      "fa_bottom": "number", "undefined": "undefined", "vk_left": "number", "vk_right": "number", "vk_up": "number",
                      "vk_down": "number", "vk_space": "number", "vk_shift": "number", "vk_enter": "number", "vk_escape": "number",
                      "vk_control": "number", "vk_alt": "number", "vk_tab": "number", "vk_backspace": "number", "room": "resource:room",
                      "os_type": "number", "os_windows": "number", "os_android": "number", "id": "instance", "self": "instance",
                      "working_directory": "string", "program_directory": "string", "game_save_id": "string", "temp_directory": "string",
                      "keyboard_string": "string", "mouse_x": "number", "mouse_y": "number", "x": "number", "y": "number",
                      "current_time": "number", "room_width": "number", "room_height": "number", "room_speed": "number", "fps": "number"}

    def classify(rhs_masked: str, rhs_raw: str, indexed: bool) -> str:
        r = rhs_masked.strip().rstrip(";").strip()
        raw = rhs_raw.strip().rstrip(";").strip()
        if indexed:
            return "array"
        if not r:
            return "不确定"
        while r.startswith("(") and r.endswith(")") and r.count("(") == r.count(")"):
            r = r[1:-1].strip()
            raw = raw[1:-1].strip()
        if r.startswith("[") or r.startswith("array_create"):
            return "array"
        if r.startswith('"') or r.startswith("'") or r.startswith('@"'):
            # 字符串字面量，或以字符串开头的拼接
            return "string"
        if NUM_RE.match(r):
            return "number"
        if r in builtin_consts:
            return builtin_consts[r]
        if r in macros:
            mv = macros[r]
            return "number" if NUM_RE.match(mv) else "不确定"
        if re.fullmatch(r"[A-Za-z_]\w*", r) and r in asset_kind:
            return "resource:" + asset_kind[r]
        m = re.match(r"^([A-Za-z_]\w*)\s*\(", r)
        if m:
            fn = m.group(1)
            if fn == "ds_map_create" or fn == "json_decode" or fn == "LoadJSONFromFile":
                return "ds_map"
            if fn == "ds_list_create":
                return "ds_list"
            if fn in ("ds_grid_create",):
                return "ds_grid"
            if fn.startswith("font_add"):
                return "font"
            if fn in ("instance_create", "instance_create_depth", "instance_create_layer", "instance_find", "instance_nearest",
                      "instance_place", "instance_position", "collision_rectangle", "collision_point"):
                return "instance"
            if fn in ("sprite_add", "sprite_duplicate", "sprite_create_from_surface"):
                return "resource:sprite(动态)"
            if fn in ("surface_create",):
                return "surface"
            if fn in ("audio_play_sound",):
                return "number(音频句柄)"
            if fn in STR_FUNCS:
                if r.endswith(")") and re.fullmatch(r"\w+\s*\((?:[^()]|\([^()]*\))*\)", r):
                    return "string"
            if fn in NUM_FUNCS:
                if re.fullmatch(r"\w+\s*\((?:[^()]|\([^()]*\))*\)", r):
                    return "number"
        if re.fullmatch(r"global\s*\.\s*\w+", r):
            return "alias:" + re.sub(r"\s", "", r)[len("global."):]
        # 纯数字算术
        if re.fullmatch(r"[\d\s.+\-*/()]+", r):
            return "number"
        return "不确定"

    refs: Counter[str] = Counter()
    files: dict[str, set[str]] = {}
    assigns: dict[str, list[dict[str, Any]]] = {}
    compound: Counter[str] = Counter()
    total_files = 0
    for p in gml_files():
        total_files += 1
        src = read_text(p)
        masked = mask_comments_and_strings(src)
        raw_lines = src.splitlines()
        rp = rel(p)
        for ln, mline in enumerate(masked.splitlines(), 1):
            if "global" not in mline:
                continue
            for m in REF_RE.finditer(mline):
                refs[m.group(1)] += 1
                files.setdefault(m.group(1), set()).add(rp)
            for m in COMPOUND_RE.finditer(mline):
                compound[m.group(1)] += 1
            for m in PRE_INC_RE.finditer(mline):
                compound[m.group(2)] += 1
            for m in ASSIGN_RE.finditer(mline):
                # 排除比较语境：赋值前面若是 if/while/&&/|| ( 等，GML 里 `if (a = b)` 也是比较
                before = mline[: m.start()].rstrip()
                is_cmp = bool(re.search(r"(\bif|\bwhile|\buntil|\breturn|&&|\|\||\band\b|\bor\b|[(,!=<>?:])$", before))
                name = m.group(1)
                rhs_m = mline[m.end():]
                raw_line = raw_lines[ln - 1] if ln - 1 < len(raw_lines) else ""
                rhs_raw = raw_line[m.end():] if len(raw_line) >= m.end() else rhs_m
                # 一行多语句时截到第一个分号
                cut = rhs_m.find(";")
                if cut >= 0:
                    rhs_m = rhs_m[:cut]
                    rhs_raw = rhs_raw[:cut]
                rec = {
                    "location": f"{rp}:{ln}",
                    "rhs": rhs_raw.strip(),
                    "indexed": m.group(2) is not None,
                    "comparison_context": is_cmp,
                }
                if not is_cmp:
                    rec["kind"] = classify(rhs_m, rhs_raw, m.group(2) is not None)
                assigns.setdefault(name, []).append(rec)

    out: dict[str, Any] = {}
    type_counter: Counter[str] = Counter()
    for name in sorted(refs, key=lambda s: s.lower()):
        al = [a for a in assigns.get(name, []) if not a["comparison_context"]]
        kinds = Counter(a["kind"] for a in al)
        resolved = {k for k in kinds if not k.startswith("alias:")}
        if not al:
            inferred = "不确定（无赋值）"
        elif len(resolved) == 1 and "不确定" not in resolved:
            inferred = next(iter(resolved))
        elif len(resolved) == 0:
            inferred = "不确定（仅由其他 global 赋值）"
        elif resolved == {"number", "bool"}:
            inferred = "number"
        else:
            known = sorted(k for k in resolved if k != "不确定")
            if len(known) == 1 and kinds["不确定"] > 0:
                inferred = f"不确定（已识别的赋值均为 {known[0]}，另有 {kinds['不确定']} 处无法判断）"
            else:
                inferred = "不确定（混合：" + ", ".join(f"{k}×{v}" for k, v in sorted(kinds.items())) + "）"
        type_counter[inferred.split("（")[0] if inferred.startswith("不确定") else inferred] += 1
        first = al[0] if al else None
        out[name] = {
            "refs": refs[name],
            "files": len(files[name]),
            "assignment_count": len(al),
            "compound_count": compound[name],
            "first_assignment": {"location": first["location"], "rhs": first["rhs"]} if first else None,
            "assignment_kinds": dict(sorted(kinds.items())),
            "inferred_type": inferred,
            "likely_type": (sorted(k for k in resolved if k != "不确定")[0] if len([k for k in resolved if k != "不确定"]) == 1 else None),
        }
        cmp_only = [a["location"] for a in assigns.get(name, []) if a["comparison_context"]]
        if cmp_only:
            out[name]["comparison_eq_sites"] = cmp_only[:10]

    write_json(TABLES / "globals.json", {
        "count": len(out),
        "total_refs": sum(refs.values()),
        "scanned_gml_files": total_files,
        "type_summary": dict(sorted(type_counter.items())),
        "note": "first_assignment 为按文件路径字典序的第一处静态赋值，不代表运行时先后。`if (global.x = 1)` 这类比较语境不计入赋值，列在 comparison_eq_sites。",
        "globals": out,
    })
    print(f"globals: {len(out)} 个名字, 引用 {sum(refs.values())} 处, 扫描 {total_files} 个 .gml, 类型分布 {dict(type_counter)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
