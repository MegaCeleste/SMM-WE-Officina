"""第 0 批导入/生成脚本的公共函数。

约定：只读 original/openwe-ref/，只写 port/。所有输出按确定顺序生成，
内容不变时不重写文件（避免触发 Godot 无意义的重新导入）。
"""
from __future__ import annotations

import json
import os
import re
from pathlib import Path
from typing import Any, Iterator

ROOT = Path(__file__).resolve().parent.parent
ORIG = ROOT / "original" / "openwe-ref"
PORT = ROOT / "port"
TABLES = PORT / "tables"
ASSETS = PORT / "assets"
YYP = ORIG / "SMM_WE.yyp"


def _strip_trailing_commas(text: str) -> str:
    """去掉 GMS .yy 里 `,}` / `,]` 形式的尾随逗号（字符串内部不动）。"""
    out: list[str] = []
    i = 0
    n = len(text)
    in_str = False
    while i < n:
        c = text[i]
        if in_str:
            out.append(c)
            if c == "\\" and i + 1 < n:
                out.append(text[i + 1])
                i += 2
                continue
            if c == '"':
                in_str = False
            i += 1
            continue
        if c == '"':
            in_str = True
            out.append(c)
            i += 1
            continue
        if c == ",":
            j = i + 1
            while j < n and text[j] in " \t\r\n":
                j += 1
            if j < n and text[j] in "}]":
                i += 1  # 丢掉这个逗号
                continue
        out.append(c)
        i += 1
    return "".join(out)


def load_yy(path: Path) -> Any:
    raw = path.read_bytes().decode("utf-8-sig")
    try:
        return json.loads(raw)
    except json.JSONDecodeError:
        return json.loads(_strip_trailing_commas(raw))


_yyp_cache: Any = None


def yyp() -> Any:
    global _yyp_cache
    if _yyp_cache is None:
        _yyp_cache = load_yy(YYP)
    return _yyp_cache


def resources(kind: str) -> list[tuple[int, str, str]]:
    """按 yyp resources 顺序返回 (该类型内序号, 名字, 相对路径)。kind 为 id.path 的第一段。"""
    res: list[tuple[int, str, str]] = []
    for r in yyp()["resources"]:
        p: str = r["id"]["path"]
        if p.split("/")[0] == kind:
            res.append((len(res), r["id"]["name"], p))
    return res


def folder_of(yy: Any) -> str | None:
    par = yy.get("parent")
    if isinstance(par, dict) and "path" in par:
        p: str = par["path"]
        if p.startswith("folders/"):
            p = p[len("folders/"):]
        if p.endswith(".yy"):
            p = p[:-3]
        return p
    return None


def ref_name(v: Any) -> str | None:
    if isinstance(v, dict):
        return v.get("name")
    return None


def rel(p: Path) -> str:
    return p.relative_to(ORIG).as_posix()


def write_bytes_if_changed(path: Path, data: bytes) -> bool:
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists() and path.read_bytes() == data:
        return False
    path.write_bytes(data)
    return True


def write_json(path: Path, obj: Any) -> bool:
    text = json.dumps(obj, ensure_ascii=False, indent=1) + "\n"
    return write_bytes_if_changed(path, text.encode("utf-8"))


def gml_files() -> Iterator[Path]:
    """objects/ scripts/ rooms/ extensions/ 下所有 .gml，按路径排序。"""
    for sub in ("objects", "scripts", "rooms", "extensions"):
        base = ORIG / sub
        files = sorted(base.rglob("*.gml"), key=lambda p: p.as_posix())
        yield from files


def read_text(path: Path) -> str:
    return path.read_bytes().decode("utf-8-sig", errors="replace")


_COMMENT_STR_RE = re.compile(
    r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\\n])*"|\'(?:\\.|[^\'\\\n])*\'|@"[^"]*"',
    re.S,
)


def mask_comments_and_strings(src: str) -> str:
    """把注释替换为空格、字符串内容替换为空格（保留引号与换行），使行号不变。"""

    def rep(m: re.Match[str]) -> str:
        s = m.group(0)
        if s.startswith("//") or s.startswith("/*"):
            return re.sub(r"[^\n]", " ", s)
        q = s[0] if s[0] != "@" else '"'
        inner = s[1:-1] if s[0] != "@" else s[2:-1]
        prefix = s[0] if s[0] != "@" else '@"'
        return prefix + re.sub(r"[^\n]", " ", inner) + q

    return _COMMENT_STR_RE.sub(rep, src)
