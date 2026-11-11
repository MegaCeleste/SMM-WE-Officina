"""第 2 批：生成脚本门面 `Scr`（port/scripts/scr.gd，class_name Scr）。

组织方式（port-plan §2、§3.1）：
- 每个原版脚本资源一个文件：port/scripts/<脚本资源名>.gd，`extends RefCounted`，里面是
  `static func 函数名(me: GMObject, …)`（第一个参数是调用者实例，见 docs/gml2gd-notes.md §3.5）。
- 本脚本扫描这些文件，在 scr.gd 里为每个 static func 生成同名转发函数，所以调用处统一写
  `Scr.函数名(self, …)`，和转换脚本的输出一致。没移植的脚本没有转发函数，调用处编译报错，
  不会静默跑空。
- 原版全部 `#macro`（object 和脚本里的都算，GML 的宏是全局的）和全部 `enum` 也生成在 scr.gd 里：
  `Scr.cs_big`、`Scr.e__BG.Index`。数字宏是 float 常量（与转换脚本一致）。

只读 original/（宏、枚举）和 port/scripts/，只写 port/scripts/scr.gd。
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gmlib import ORIG, PORT, mask_comments_and_strings, read_text, write_bytes_if_changed  # noqa: E402

SCRIPTS = PORT / "scripts"
FUNC_RE = re.compile(r"^static func (\w+)\((.*)\)\s*(->\s*([\w\[\]]+))?\s*:\s*$", re.M)


def split_params(s: str) -> list[str]:
    out, depth, cur = [], 0, ""
    for ch in s:
        if ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


def macro_value(v: str) -> tuple[str, str]:
    v = v.strip()
    if v.startswith('"'):
        return "String", v
    try:
        return "float", repr(float(v))
    except ValueError:
        raise SystemExit(f"gen_scr: 宏的值不是字面量：{v}")


def main() -> int:
    out = [
        "# 由 tools/gen_scr.py 生成，不要手改。",
        "# 脚本门面：原版的全部宏、枚举，以及 port/scripts/*.gd 里每个已移植脚本函数的转发。",
        "class_name Scr",
        "extends RefCounted",
        "",
    ]
    # ---- 宏 ----
    macros: dict[str, str] = {}
    for gml in sorted(list((ORIG / "objects").rglob("*.gml")) + list((ORIG / "scripts").rglob("*.gml"))):
        for m in re.finditer(r"^\s*#macro\s+(\w+)\s+(.*?)\s*$", read_text(gml), re.M):
            name, val = m.group(1), m.group(2)
            if name in macros and macros[name] != val:
                print(f"gen_scr: 宏 {name} 有两个不同的值：{macros[name]} / {val}")
                return 1
            macros[name] = val
    out.append(f"# ---- 宏（{len(macros)}） ----")
    for name, val in macros.items():
        t, v = macro_value(val)
        out.append(f"const {name}: {t} = {v}")
    out.append("")
    # ---- 枚举 ----
    enums: dict[str, str] = {}
    for gml in sorted((ORIG / "scripts").rglob("*.gml")) + sorted((ORIG / "objects").rglob("*.gml")):
        src = read_text(gml)
        masked = mask_comments_and_strings(src)
        for m in re.finditer(r"\benum\s+(\w+)\s*\{([^}]*)\}", masked):
            body = src[m.start(2):m.end(2)]
            body = re.sub(r"//[^\n]*", "", body)
            members = [x.strip() for x in body.split(",") if x.strip()]
            enums[m.group(1)] = ", ".join(members)
    out.append(f"# ---- 枚举（{len(enums)}） ----")
    for name, members in enums.items():
        out.append(f"enum {name} {{ {members} }}")
    out.append("")
    # ---- 脚本函数转发 ----
    files = sorted(p for p in SCRIPTS.glob("*.gd") if p.name != "scr.gd")
    out.append(f"# ---- 已移植脚本（{len(files)} 个文件） ----")
    seen: dict[str, str] = {}
    body: list[str] = []
    for p in files:
        mod = "_m_" + p.stem.lstrip("_")
        out.append(f'const {mod} = preload("res://scripts/{p.name}")')
        for m in FUNC_RE.finditer(read_text(p)):
            fname, params, ret = m.group(1), m.group(2), m.group(4)
            if fname.startswith("_") and fname == "_toplevel":
                continue
            if fname in seen:
                print(f"gen_scr: 函数 {fname} 在 {seen[fname]} 和 {p.name} 里都有")
                return 1
            seen[fname] = p.name
            ps = split_params(params)
            names = []
            for q in ps:
                if q.startswith("..."):
                    print(f"gen_scr: {p.name}:{fname} 用了可变参数，转发还没实现")
                    return 1
                names.append(re.split(r"[:=]", q)[0].strip())
            sig = f"static func {fname}({params})" + (f" -> {ret}" if ret else "") + ":"
            call = f"{mod}.{fname}({', '.join(names)})"
            body.append("")
            body.append(sig)
            body.append(f"\t{call}" if ret == "void" else f"\treturn {call}")
    out.extend(body)
    out.append("")
    write_bytes_if_changed(SCRIPTS / "scr.gd", "\n".join(out).encode("utf-8"))
    print(f"gen_scr: 宏 {len(macros)}、枚举 {len(enums)}、脚本函数 {len(seen)} → port/scripts/scr.gd")
    return 0


if __name__ == "__main__":
    sys.exit(main())
