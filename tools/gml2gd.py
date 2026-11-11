"""GML → GDScript 机械转换（port-plan §7 的 1b）。

用法（用 tools/.venv/Scripts/python.exe 运行）：
    gml2gd.py object obj_koopa [obj_xxx …] [--chain]   转换 object（--chain 连父类链一起转）
    gml2gd.py script scr_xxx [scr_yyy …]               转换脚本
    gml2gd.py stats                                    全工程试转并统计，不落盘

输出只写 port/_draft/（objects/、scripts/），不写 port/objects、port/scripts。
规则依据：docs/port-plan.md §3.2、§3.3；说明与统计见 docs/gml2gd-notes.md。

结构：词法分析（lex）→ 递归下降语法分析（Parser，产出 AST）→ 全工程预扫描
（Proj：资源名、脚本名、宏、枚举、兼容层 API、各 object 的实例变量赋值/读取）→
发射（Emitter：一个事件一个方法）。没把握的地方不猜：能编译的写法加行尾
`# TODO-GML: 类别(细节)`，不能转的整条语句注释掉并写 `pass  # TODO-GML: 类别`。
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter
from pathlib import Path
from typing import Any, Callable

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gmlib import ORIG, PORT, TABLES, read_text  # noqa: E402

DRAFT = PORT / "_draft"
GMDIR = PORT / "gm"

# ======================================================================
# 固定知识表（GML / GDScript / Godot 本身的事实，不是兼容层的函数表）
# ======================================================================

# GDScript 关键字、内置类型、常量，以及生成代码会用到的全局名：用作 GML 标识符时要改名
GD_RESERVED = set("""
if elif else for while match when break continue pass return class class_name extends is in as
self super signal func static const enum var breakpoint preload await yield assert void not and or
true false null trait namespace PI TAU INF NAN
int float bool String StringName NodePath Vector2 Vector2i Vector3 Vector3i Vector4 Vector4i Rect2
Rect2i Transform2D Transform3D Plane Quaternion AABB Basis Projection Color RID Object Callable
Signal Dictionary Array PackedByteArray PackedInt32Array PackedInt64Array PackedFloat32Array
PackedFloat64Array PackedStringArray PackedVector2Array PackedVector3Array PackedColorArray
PackedVector4Array Node Resource
GM A G Scr GMObject GMClass GMSprite GMCollision
""".split())

# Node / Object 的属性、方法、信号名（Godot 4.7.2 的 ClassDB 导出）。
# 子类声明同名成员是编译错误，所以 GML 实例变量撞名时改名（加 _v）。
NODE_MEMBERS = set("""
Process add_child add_sibling add_to_group add_user_signal atr atr_n auto_translate_mode call
call_deferred call_deferred_thread_group call_thread_safe callv can_auto_translate can_process
can_translate_messages cancel_free child_entered_tree child_exiting_tree child_order_changed connect
create_tween disconnect duplicate editor_description editor_description_changed editor_state_changed
emit_signal find_child find_children find_parent free get get_accessibility_element
get_auto_translate_mode get_child get_child_count get_children get_class get_editor_description
get_groups get_incoming_connections get_index get_indexed get_instance_id get_last_exclusive_window
get_meta get_meta_list get_method_argument_count get_method_list get_multiplayer_authority get_name
get_node get_node_and_resource get_node_or_null get_node_rpc_config get_orphan_node_ids get_owner
get_parent get_path get_path_to get_physics_process_delta_time get_physics_process_priority
get_process_delta_time get_process_mode get_process_priority get_process_thread_group
get_process_thread_group_order get_process_thread_messages get_property_list get_rpc_config
get_scene_file_path get_scene_instance_load_placeholder get_script get_signal_connection_list
get_signal_list get_tree get_tree_string get_tree_string_pretty get_viewport get_window has_meta
has_method has_node has_node_and_resource has_signal has_user_signal is_ancestor_of is_blocking_signals
is_class is_connected is_displayed_folded is_editable_instance is_greater_than is_in_group
is_inside_tree is_multiplayer_authority is_node_ready is_part_of_edited_scene is_physics_interpolated
is_physics_interpolated_and_enabled is_physics_processing is_physics_processing_internal
is_processing is_processing_input is_processing_internal is_processing_shortcut_input
is_processing_unhandled_input is_processing_unhandled_key_input is_queued_for_deletion
is_unique_name_in_owner move_child multiplayer name notification notify_deferred_thread_group
notify_property_list_changed notify_thread_safe owner physics_interpolation_mode
physics_process_priority print_orphan_nodes print_tree print_tree_pretty process_mode
process_physics_priority process_priority process_thread_group process_thread_group_order
process_thread_messages propagate_call propagate_notification property_can_revert
property_get_revert queue_accessibility_update queue_free ready remove_child remove_from_group
remove_meta remove_user_signal renamed replace_by replicated request_ready reset_physics_interpolation
rpc rpc_config rpc_id scene_file_path script set set_block_signals set_deferred
set_deferred_thread_group set_display_folded set_editable_instance set_editor_description
set_indexed set_meta set_multiplayer_authority set_name set_owner set_physics_interpolation_mode
set_physics_process set_physics_process_internal set_process set_process_input
set_process_internal set_process_mode set_process_priority set_process_shortcut_input
set_process_thread_group set_process_thread_group_order set_process_thread_messages
set_process_unhandled_input set_process_unhandled_key_input set_scene_file_path set_script
set_thread_safe set_translation_domain set_unique_name_in_owner to_string tr tr_n
translation_domain tree_entered tree_exited tree_exiting unique_name_in_owner update_configuration_warnings
script_changed property_list_changed
""".split())

# GML 的内置全局变量（不是实例变量）。兼容层 GM 里有同名 var 的才映射成 GM.<名>
GML_GLOBAL_VARS = set("""
room room_width room_height room_speed room_persistent room_caption room_first room_last
current_time current_year current_month current_day current_weekday current_hour current_minute
current_second fps fps_real delta_time mouse_x mouse_y mouse_button mouse_lastbutton keyboard_key
keyboard_lastkey keyboard_lastchar keyboard_string view_enabled view_current view_visible
view_camera view_xport view_yport view_wport view_hport view_surface_id view_xview view_yview
view_wview view_hview view_angle view_hborder view_vborder view_hspeed view_vspeed view_object
instance_count instance_id os_type os_device os_browser os_version working_directory
program_directory temp_directory game_save_id game_id game_display_name game_project_name
application_surface browser_width browser_height display_aa health lives score show_score
show_lives show_health caption_score caption_lives caption_health cursor_sprite async_load
event_type event_number event_object event_action debug_mode argument_relative background_color
background_colour background_showcolor background_showcolour error_occurred error_last secure_mode
gamemaker_pro gamemaker_registered gamemaker_version webgl_enabled iap_data
""".split())

# GML 内置常量的前缀（只在全工程没有被当实例变量赋值过时才按“兼容层没有的常量”处理）
GML_CONST_PREFIX = re.compile(
    r"^(c|vk|ev|bm|os|fa|mb|gp|ds_type|buffer|audio|pr|tf|cr|lb|ef|ps|pt|layerelementtype|asset|"
    r"display|surface|gpu|cmpfunc|cull|video|tm|kbv|timezone|text_type|path_action|bboxkind|"
    r"bboxmode|spritespeed|matrix|network|http|achievement|ty|fs|se|seq|gamespeed|phy|leaderboard|"
    r"iap|browser|device|lighttype|vertex|font_texture|steam|gamepad|tile|ov|of_challenge|dll|"
    r"button_type|input_type)_\w+$")

# GML 的内置实例变量里兼容层 GMObject 没有的（保留原名，标 TODO）
GML_INST_MISSING = set("""
solid path_index path_position path_positionprevious path_speed path_scale path_orientation
path_endaction timeline_index timeline_position timeline_speed timeline_running timeline_loop layer
in_sequence sequence_instance drawn_by_sequence on_ui_layer image_blend_mode
""".split())

# 数学函数：GML 名 → Godot 名（port-plan §3.3 第 6 条）
MATH_GODOT = {"abs": ("absf", 1), "floor": ("floorf", 1), "ceil": ("ceilf", 1),
              "sqrt": ("sqrt", 1), "sin": ("sin", 1), "cos": ("cos", 1),
              "clamp": ("clampf", 3), "lerp": ("lerpf", 3), "power": ("pow", 2)}
MATH_GM = {"round": "gm_round", "sign": "gm_sign", "string": "string"}

ASSIGN_OPS = {"=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>=", "??="}
KEYWORDS = {"if", "else", "while", "do", "until", "for", "repeat", "switch", "case", "default",
            "break", "continue", "with", "return", "exit", "var", "globalvar", "function", "enum",
            "and", "or", "not", "xor", "div", "mod", "new", "delete", "try", "catch", "finally",
            "throw", "static"}
WORD_OPS = {"and": "&&", "or": "||", "xor": "^^", "div": "div", "mod": "mod", "not": "!"}

OPS = sorted("""
<<= >>= ??= == != <> <= >= && || ^^ ++ -- += -= *= /= %= &= |= ^= << >> [| [? [# [@ [$ ??
{ } ( ) [ ] ; , . : ? + - * / % < > = ! ~ & | ^
""".split(), key=len, reverse=True)

# GML 二元运算的优先级（数字越大越紧）。条件里的单个 `=` 是比较。
BIN_LEVELS = [["??"], ["||"], ["^^"], ["&&"], ["|"], ["^"], ["&"], ["==", "!=", "<>", "="],
              ["<", "<=", ">", ">="], ["<<", ">>"], ["+", "-"], ["*", "/", "div", "%", "mod"]]
# GDScript 的优先级（数字越大越紧）
GD_PREC = {"or": 2, "and": 3, "not": 4, "cmp": 6, "|": 7, "^": 8, "&": 9, "<<": 10, ">>": 10,
           "+": 11, "-": 11, "*": 12, "/": 12, "%": 12, "neg": 13, "atom": 20, "tern": 1}

# 事件文件名 → 方法名（port-plan §3.2）
OTHER_EVENTS = {0: "_outside_room", 2: "_game_start", 3: "_game_end", 4: "_room_start",
                5: "_room_end", 7: "_animation_end", 8: "_path_end", 40: "_outside_view_0"}
ASYNC_OTHER = {60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76}


class ParseError(Exception):
    def __init__(self, msg: str, line: int = 0) -> None:
        super().__init__(f"{msg}（第 {line} 行）" if line else msg)
        self.line = line


class Unsup(Exception):
    """这条语句转不了：整条注释掉并标 TODO。reason 用固定类别名。"""

    def __init__(self, reason: str) -> None:
        super().__init__(reason)
        self.reason = reason


# ======================================================================
# 词法分析
# ======================================================================

class Tok:
    __slots__ = ("k", "v", "line", "pos", "end", "nl", "extra")

    def __init__(self, k: str, v: Any, line: int, pos: int, end: int, nl: bool, extra: Any = None):
        self.k, self.v, self.line, self.pos, self.end, self.nl, self.extra = k, v, line, pos, end, nl, extra

    def __repr__(self) -> str:
        return f"Tok({self.k},{self.v!r},L{self.line})"


class Comment:
    __slots__ = ("line", "endline", "lines", "own")

    def __init__(self, line: int, endline: int, lines: list[str], own: bool):
        self.line, self.endline, self.lines, self.own = line, endline, lines, own


_ESC = {"n": "\n", "r": "\r", "t": "\t", "\\": "\\", '"': '"', "'": "'", "b": "\b", "f": "\f",
        "v": "\v", "a": "\a", "0": "\0", "/": "/"}


def lex(src: str) -> tuple[list[Tok], list[Comment]]:
    toks: list[Tok] = []
    comments: list[Comment] = []
    i, n, line, nl = 0, len(src), 1, True
    while i < n:
        c = src[i]
        if c == "\n":
            line += 1
            i += 1
            nl = True
            continue
        if c in " \t\r\f\v﻿":
            i += 1
            continue
        if src.startswith("//", i):
            j = src.find("\n", i)
            j = n if j < 0 else j
            comments.append(Comment(line, line, [src[i + 2:j].rstrip()], nl))
            i = j
            continue
        if src.startswith("/*", i):
            j = src.find("*/", i + 2)
            if j < 0:
                raise ParseError("块注释没有结束", line)
            body = src[i + 2:j]
            cl = body.split("\n")
            comments.append(Comment(line, line + len(cl) - 1, [x.rstrip() for x in cl], nl))
            line += len(cl) - 1
            i = j + 2
            continue
        if c == "#" and nl:
            j = src.find("\n", i)
            j = n if j < 0 else j
            text = src[i:j].rstrip()
            m = re.match(r"#macro\s+(\w+)\s+(.*)$", text)
            if m:
                toks.append(Tok("macro", m.group(1), line, i, j, nl, m.group(2).strip()))
                nl = False
            elif re.match(r"#(end)?region\b", text):
                comments.append(Comment(line, line, [text[1:]], True))
            else:
                raise ParseError(f"不认识的预处理行 {text[:30]}", line)
            i = j
            continue
        start = i
        if c == "$" and i + 1 < n and src[i + 1] in "0123456789abcdefABCDEF":
            j = i + 1
            while j < n and src[j] in "0123456789abcdefABCDEF":
                j += 1
            toks.append(Tok("num", int(src[i + 1:j], 16), line, start, j, nl, "0x" + src[i + 1:j].upper()))
            i = j
        elif c == "0" and i + 1 < n and src[i + 1] in "xX":
            j = i + 2
            while j < n and src[j] in "0123456789abcdefABCDEF":
                j += 1
            toks.append(Tok("num", int(src[i + 2:j], 16), line, start, j, nl, "0x" + src[i + 2:j].upper()))
            i = j
        elif c.isdigit() or (c == "." and i + 1 < n and src[i + 1].isdigit()):
            m = re.compile(r"\d*\.?\d*").match(src, i)
            assert m
            text = m.group(0)
            j = m.end()
            toks.append(Tok("num", float(text), line, start, j, nl, None))
            # 记录原文用于小数格式化
            toks[-1].extra = ("dec", text)
            i = j
        elif c == "@" and i + 1 < n and src[i + 1] in "\"'":
            q = src[i + 1]
            j = src.find(q, i + 2)
            if j < 0:
                raise ParseError("字符串没有结束", line)
            s = src[i + 2:j]
            toks.append(Tok("str", s, line, start, j + 1, nl))
            line += s.count("\n")
            i = j + 1
        elif c in "\"'":
            q = c
            j = i + 1
            buf: list[str] = []
            while True:
                if j >= n or src[j] == "\n":
                    raise ParseError("字符串没有结束", line)
                ch = src[j]
                if ch == q:
                    break
                if ch == "\\" and q == '"' and j + 1 < n:
                    e = src[j + 1]
                    if e in _ESC:
                        buf.append(_ESC[e])
                        j += 2
                        continue
                    if e == "x" and re.match(r"[0-9a-fA-F]{2}", src[j + 2:j + 4]):
                        buf.append(chr(int(src[j + 2:j + 4], 16)))
                        j += 4
                        continue
                    if e == "u" and re.match(r"[0-9a-fA-F]{4}", src[j + 2:j + 6]):
                        buf.append(chr(int(src[j + 2:j + 6], 16)))
                        j += 6
                        continue
                    if e == "\n":
                        raise ParseError("字符串内换行", line)
                    buf.append(e)
                    j += 2
                    continue
                buf.append(ch)
                j += 1
            toks.append(Tok("str", "".join(buf), line, start, j + 1, nl))
            i = j + 1
        elif c.isalpha() or c == "_":
            m = re.compile(r"[A-Za-z_]\w*").match(src, i)
            assert m
            toks.append(Tok("id", m.group(0), line, start, m.end(), nl))
            i = m.end()
        else:
            for op in OPS:
                if src.startswith(op, i):
                    toks.append(Tok("op", op, line, start, i + len(op), nl))
                    i += len(op)
                    break
            else:
                raise ParseError(f"不认识的字符 {c!r}", line)
        nl = False
    toks.append(Tok("eof", None, line, n, n, True))
    return toks, comments


# ======================================================================
# AST 与语法分析
# ======================================================================

class N:
    """AST 节点。t 是类型名，其余字段按类型不同。语句节点带 p0/p1（源码偏移）和 l0/l1（行号）。"""

    def __init__(self, t: str, **kw: Any) -> None:
        self.t = t
        self.__dict__.update(kw)

    def __repr__(self) -> str:
        return f"N({self.t})"


class Parser:
    def __init__(self, src: str) -> None:
        self.src = src
        self.toks, self.comments = lex(src)
        self.i = 0

    # ---- 工具 ----
    def peek(self, k: int = 0) -> Tok:
        return self.toks[min(self.i + k, len(self.toks) - 1)]

    def next(self) -> Tok:
        t = self.toks[self.i]
        self.i += 1
        return t

    def is_op(self, v: str, k: int = 0) -> bool:
        t = self.peek(k)
        return t.k == "op" and t.v == v

    def is_kw(self, v: str, k: int = 0) -> bool:
        t = self.peek(k)
        return t.k == "id" and t.v == v

    def accept_op(self, v: str) -> bool:
        if self.is_op(v):
            self.i += 1
            return True
        return False

    def expect_op(self, v: str) -> Tok:
        t = self.peek()
        if not (t.k == "op" and t.v == v):
            raise ParseError(f"期望 {v!r}，得到 {t.v!r}", t.line)
        return self.next()

    def expect_id(self) -> Tok:
        t = self.peek()
        if t.k != "id":
            raise ParseError(f"期望标识符，得到 {t.v!r}", t.line)
        return self.next()

    def fin(self, node: N, t0: Tok) -> N:
        last = self.toks[self.i - 1]
        node.p0, node.p1, node.l0, node.l1 = t0.pos, last.end, t0.line, last.line
        return node

    # ---- 程序与语句 ----
    def program(self) -> list[N]:
        out: list[N] = []
        while self.peek().k != "eof":
            out.append(self.stmt())
        return out

    def block(self) -> N:
        t0 = self.expect_op("{")
        body: list[N] = []
        while not self.is_op("}"):
            if self.peek().k == "eof":
                raise ParseError("块没有结束", t0.line)
            body.append(self.stmt())
        tend = self.next()
        n = self.fin(N("block", body=body), t0)
        n.l_end = tend.line
        return n

    def stmt(self) -> N:
        t0 = self.peek()
        n = self.stmt_inner()
        while self.accept_op(";"):
            pass
        return self.fin(n, t0)

    def stmt_inner(self) -> N:
        t = self.peek()
        if t.k == "op" and t.v == ";":
            self.next()
            return N("empty")
        if t.k == "op" and t.v == "{":
            return self.block()
        if t.k == "macro":
            self.next()
            return N("macro", name=t.v, value=t.extra)
        if t.k == "id" and t.v in KEYWORDS:
            kw = t.v
            if kw == "if":
                self.next()
                c = self.expr()
                if self.is_kw("then"):
                    self.next()
                th = self.stmt()
                el = None
                if self.is_kw("else"):
                    self.next()
                    el = self.stmt()
                return N("if", c=c, then=th, els=el)
            if kw == "while":
                self.next()
                c = self.expr()
                if self.is_kw("do"):
                    self.next()
                return N("while", c=c, body=self.stmt())
            if kw == "do":
                self.next()
                body = self.stmt()
                if not self.is_kw("until"):
                    raise ParseError("do 后面没有 until", t.line)
                self.next()
                return N("do", body=body, c=self.expr())
            if kw == "for":
                self.next()
                self.expect_op("(")
                init = None if self.is_op(";") else self.simple_or_var()
                self.expect_op(";")
                cond = None if self.is_op(";") else self.expr()
                self.expect_op(";")
                step = None if self.is_op(")") else self.simple_or_var()
                self.accept_op(";")  # 原版有 `for (…; i++;)` 的写法
                self.expect_op(")")
                return N("for", init=init, cond=cond, step=step, body=self.stmt())
            if kw == "repeat":
                self.next()
                return N("repeat", n=self.expr(), body=self.stmt())
            if kw == "with":
                self.next()
                return N("with", target=self.expr(), body=self.stmt())
            if kw == "switch":
                self.next()
                e = self.expr()
                self.expect_op("{")
                cases: list[list[Any]] = []
                while not self.is_op("}"):
                    ct = self.peek()
                    if self.is_kw("case"):
                        self.next()
                        v = self.expr()
                        self.expect_op(":")
                        cases.append([v, [], ct.line])
                    elif self.is_kw("default"):
                        self.next()
                        self.expect_op(":")
                        cases.append([None, [], ct.line])
                    elif ct.k == "eof":
                        raise ParseError("switch 没有结束", t.line)
                    else:
                        if not cases:
                            raise ParseError("switch 里 case 之前有语句", ct.line)
                        cases[-1][1].append(self.stmt())
                self.next()
                return N("switch", e=e, cases=cases)
            if kw == "return":
                self.next()
                nt = self.peek()
                if (nt.k == "op" and nt.v in (";", "}")) or nt.nl or nt.k == "eof":
                    return N("return", e=None)
                return N("return", e=self.expr())
            if kw in ("exit", "break", "continue"):
                self.next()
                return N(kw)
            if kw == "var":
                return self.var_decl()
            if kw == "globalvar":
                self.next()
                names = [self.expect_id().v]
                while self.accept_op(","):
                    names.append(self.expect_id().v)
                return N("globalvar", names=names)
            if kw == "enum":
                self.next()
                name = self.expect_id().v
                self.expect_op("{")
                members: list[tuple[str, N | None]] = []
                while not self.is_op("}"):
                    mn = self.expect_id().v
                    val = self.expr() if self.accept_op("=") else None
                    members.append((mn, val))
                    if not self.accept_op(","):
                        break
                self.expect_op("}")
                return N("enum", name=name, members=members)
            if kw == "function":
                self.next()
                name = self.expect_id().v
                self.expect_op("(")
                params: list[tuple[str, N | None]] = []
                while not self.is_op(")"):
                    pn = self.expect_id().v
                    dv = self.expr() if self.accept_op("=") else None
                    params.append((pn, dv))
                    if not self.accept_op(","):
                        break
                self.expect_op(")")
                if self.is_kw("constructor"):
                    raise ParseError("不支持 constructor", t.line)
                return N("func", name=name, params=params, body=self.block())
            if kw in ("case", "default", "else", "until"):
                raise ParseError(f"多余的 {kw}", t.line)
            raise ParseError(f"不支持的语法 {kw}", t.line)
        return self.simple()

    def var_decl(self) -> N:
        self.next()  # var
        decls: list[tuple[str, N | None]] = []
        while True:
            name = self.expect_id().v
            init = self.expr() if self.accept_op("=") else None
            decls.append((name, init))
            if not self.accept_op(","):
                break
        return N("var", decls=decls)

    def simple_or_var(self) -> N:
        t0 = self.peek()
        n = self.var_decl() if self.is_kw("var") else self.simple()
        return self.fin(n, t0)

    def simple(self) -> N:
        lhs = self.unary()
        t = self.peek()
        if t.k == "op" and t.v in ASSIGN_OPS:
            self.next()
            return N("assign", target=lhs, op=t.v, value=self.expr())
        return N("expr", e=lhs)

    # ---- 表达式 ----
    def expr(self) -> N:
        c = self.binary(0)
        if self.accept_op("?"):
            a = self.expr()
            self.expect_op(":")
            b = self.expr()
            return N("tern", c=c, a=a, b=b)
        return c

    def binary(self, lvl: int) -> N:
        if lvl == len(BIN_LEVELS):
            return self.unary()
        left = self.binary(lvl + 1)
        ops = BIN_LEVELS[lvl]
        while True:
            t = self.peek()
            op = None
            if t.k == "op" and t.v in ops:
                op = t.v
            elif t.k == "id" and t.v in WORD_OPS and WORD_OPS[t.v] in ops:
                op = WORD_OPS[t.v]
            if op is None:
                return left
            self.next()
            right = self.binary(lvl + 1)
            left = N("bin", op=op, l=left, r=right)

    def unary(self) -> N:
        t = self.peek()
        if t.k == "op" and t.v in ("!", "-", "~", "+"):
            self.next()
            return N("un", op=t.v, e=self.unary())
        if t.k == "id" and t.v == "not":
            self.next()
            return N("un", op="!", e=self.unary())
        if t.k == "op" and t.v in ("++", "--"):
            self.next()
            return N("incdec", op=t.v, e=self.unary(), prefix=True)
        return self.postfix()

    def postfix(self) -> N:
        e = self.primary()
        while True:
            t = self.peek()
            if t.k == "op" and t.v == ".":
                self.next()
                e = N("mem", o=e, name=self.expect_id().v)
            elif t.k == "op" and t.v in ("[", "[|", "[?", "[#", "[@", "[$") and not t.nl:
                self.next()
                idx = [self.expr()]
                while self.accept_op(","):
                    idx.append(self.expr())
                self.expect_op("]")
                e = N("idx", o=e, idx=idx, acc=t.v[1:])
            elif t.k == "op" and t.v == "(" and not t.nl:
                self.next()
                args: list[N] = []
                while not self.is_op(")"):
                    args.append(self.expr())
                    if not self.accept_op(","):
                        break
                self.expect_op(")")
                e = N("call", f=e, args=args, line=t.line)
            elif t.k == "op" and t.v in ("++", "--") and not t.nl:
                self.next()
                e = N("incdec", op=t.v, e=e, prefix=False)
            else:
                return e

    def primary(self) -> N:
        t = self.next()
        if t.k == "num":
            if isinstance(t.extra, str):  # 十六进制
                return N("num", val=t.v, hex=t.extra, text=t.extra)
            return N("num", val=t.v, hex=None, text=t.extra[1])
        if t.k == "str":
            return N("str", val=t.v)
        if t.k == "id":
            if t.v in KEYWORDS and t.v not in ("not",):
                raise ParseError(f"表达式里出现关键字 {t.v}", t.line)
            return N("name", name=t.v, line=t.line)
        if t.k == "op" and t.v == "(":
            e = self.expr()
            self.expect_op(")")
            return N("paren", e=e)
        if t.k == "op" and t.v == "[":
            items: list[N] = []
            while not self.is_op("]"):
                items.append(self.expr())
                if not self.accept_op(","):
                    break
            self.expect_op("]")
            return N("array", items=items)
        if t.k == "op" and t.v == "{":
            depth = 1
            while depth and self.peek().k != "eof":
                x = self.next()
                if x.k == "op" and x.v == "{":
                    depth += 1
                elif x.k == "op" and x.v == "}":
                    depth -= 1
            return N("struct")
        raise ParseError(f"表达式里出现 {t.v!r}", t.line)


def parse(src: str) -> tuple[list[N], list[Comment]]:
    p = Parser(src)
    return p.program(), p.comments


# ======================================================================
# AST 遍历工具
# ======================================================================

def expr_children(e: N) -> list[N]:
    t = e.t
    if t == "paren" or t == "un" or t == "incdec":
        return [e.e]
    if t == "bin":
        return [e.l, e.r]
    if t == "tern":
        return [e.c, e.a, e.b]
    if t == "mem":
        return [e.o]
    if t == "idx":
        return [e.o] + list(e.idx)
    if t == "call":
        return [e.f] + list(e.args)
    if t == "array":
        return list(e.items)
    return []


def walk_expr(e: N | None, fn: Callable[[N], None]) -> None:
    if e is None:
        return
    fn(e)
    for c in expr_children(e):
        walk_expr(c, fn)


def body_list(s: N | None) -> list[N]:
    if s is None:
        return []
    return s.body if s.t == "block" else [s]


def strip_paren(e: N) -> N:
    while e.t == "paren":
        e = e.e
    return e


def lit_num(e: N) -> tuple[float, bool] | None:
    """数字字面量（含一元负号、括号）→ (值, 是否十六进制)。"""
    e = strip_paren(e)
    if e.t == "num":
        return float(e.val), bool(e.hex)
    if e.t == "un" and e.op == "-":
        r = lit_num(e.e)
        if r:
            return -r[0], r[1]
    return None


def func_locals(stmts: list[N]) -> set[str]:
    """一个函数（事件）里用 var 声明过的全部名字（GML 的 var 作用域是整个函数）。"""
    out: set[str] = set()

    def ws(s: N | None) -> None:
        if s is None:
            return
        t = s.t
        if t == "var":
            for name, _ in s.decls:
                out.add(name)
        elif t == "block":
            for x in s.body:
                ws(x)
        elif t == "if":
            ws(s.then)
            ws(s.els)
        elif t in ("while", "repeat", "with", "do"):
            ws(s.body)
        elif t == "for":
            ws(s.init)
            ws(s.step)
            ws(s.body)
        elif t == "switch":
            for _, body, _ in s.cases:
                for x in body:
                    ws(x)
    for s in stmts:
        ws(s)
    return out


def stmt_exprs(s: N) -> list[N]:
    t = s.t
    if t == "assign":
        return [s.target, s.value]
    if t == "expr":
        return [s.e]
    if t == "var":
        return [i for _, i in s.decls if i is not None]
    if t in ("if", "while", "do"):
        return [s.c]
    if t == "for":
        return [s.cond] if s.cond else []
    if t == "repeat":
        return [s.n]
    if t == "with":
        return [s.target]
    if t == "switch":
        return [s.e]
    if t == "return":
        return [s.e] if s.e else []
    return []


def sub_stmts(s: N) -> list[N]:
    t = s.t
    if t == "block":
        return list(s.body)
    if t == "if":
        return [x for x in (s.then, s.els) if x is not None]
    if t in ("while", "repeat", "with", "do"):
        return [s.body]
    if t == "for":
        return [x for x in (s.init, s.step, s.body) if x is not None]
    if t == "switch":
        return [x for _, body, _ in s.cases for x in body]
    return []


def walk_stmts(stmts: list[N], fn: Callable[[N], None]) -> None:
    for s in stmts:
        fn(s)
        walk_stmts(sub_stmts(s), fn)


# ======================================================================
# 兼容层 API 扫描（port/gm/*.gd）
# ======================================================================

class Sig:
    __slots__ = ("name", "params", "ret")

    def __init__(self, name: str, params: list[tuple[str, str, bool, bool]], ret: str):
        self.name, self.params, self.ret = name, params, ret  # (名, 类型, 有默认值, 可变参数)


_FUNC_RE = re.compile(r"^(?:static\s+)?func\s+(\w+)\s*\((.*)\)\s*(?:->\s*([\w\[\]]+))?\s*:")
_VAR_RE = re.compile(r"^(?:static\s+)?var\s+(\w+)\s*(?::\s*([\w\[\]]+))?")
_CONST_RE = re.compile(r"^const\s+(\w+)\s*(?::\s*([\w\[\]]+))?")


def scan_gd(path: Path) -> tuple[dict[str, Sig], dict[str, str], dict[str, str]]:
    funcs: dict[str, Sig] = {}
    vars_: dict[str, str] = {}
    consts: dict[str, str] = {}
    for line in read_text(path).splitlines():
        m = _FUNC_RE.match(line)
        if m:
            name = m.group(1)
            params: list[tuple[str, str, bool, bool]] = []
            raw = m.group(2).strip()
            if raw:
                for p in raw.split(","):
                    p = p.strip()
                    pm = re.match(r"(\.\.\.)?(\w+)\s*(?::\s*([\w\[\]]+))?\s*(=.*)?$", p)
                    if not pm:
                        continue
                    params.append((pm.group(2), pm.group(3) or "Variant", bool(pm.group(4)), bool(pm.group(1))))
            funcs[name] = Sig(name, params, m.group(3) or "Variant")
            continue
        m = _VAR_RE.match(line)
        if m:
            vars_[m.group(1)] = m.group(2) or "Variant"
            continue
        m = _CONST_RE.match(line)
        if m:
            consts[m.group(1)] = m.group(2) or "Variant"
    return funcs, vars_, consts


def gd_kind(t: str) -> str:
    return {"float": "num", "int": "int", "bool": "bool", "String": "str", "GMObject": "inst",
            "void": "void"}.get(t, "arr" if t.startswith("Array") else "unk")


# ======================================================================
# 事件名
# ======================================================================

def event_method(fname: str) -> tuple[str, str, str | None]:
    """事件文件名 → (方法名, 类别, TODO 原因)。类别：normal / collision / async / unknown。"""
    stem = fname[:-4]
    m = re.match(r"Collision_(\w+)$", stem)
    if m:
        return f"_collision_{m.group(1)}", "collision", None
    m = re.match(r"([A-Za-z]+)_(\d+)$", stem)
    if not m:
        return "_event_" + re.sub(r"\W", "_", stem), "unknown", f"未知事件({stem})"
    kind, num = m.group(1), int(m.group(2))
    if kind == "Create" and num == 0:
        return "_create", "normal", None
    if kind == "Destroy" and num == 0:
        return "_destroy", "normal", None
    if kind == "CleanUp" and num == 0:
        return "_cleanup", "normal", None
    if kind == "Step" and num in (0, 1, 2):
        return ["_step", "_step_begin", "_step_end"][num], "normal", None
    if kind == "Alarm":
        return f"_alarm_{num}", "normal", None
    if kind == "Other":
        if 10 <= num <= 25:
            return f"_user_{num - 10}", "normal", None
        if num in OTHER_EVENTS:
            return OTHER_EVENTS[num], "normal", None
        if num in ASYNC_OTHER:
            return f"_async_{num}", "async", "异步事件"
        return f"_other_{num}", "unknown", f"未知事件({stem})"
    if kind == "Draw" and num == 0:
        return "_gm_draw", "normal", None
    if kind == "Draw" and num == 64:
        return "_gm_draw_gui", "normal", None
    if kind == "Mouse":
        return f"_mouse_{num}", "normal", None
    if kind == "KeyPress":
        return f"_keypress_{num}", "normal", None
    return f"_{kind.lower()}_{num}", "unknown", f"未知事件({stem})"


EVENT_ORDER = ["Create", "Destroy", "CleanUp", "Step", "Alarm", "Collision", "Other", "Draw",
               "Mouse", "KeyPress"]


def event_sort_key(fname: str) -> tuple[int, int, str]:
    stem = fname[:-4]
    kind = stem.split("_")[0]
    ki = EVENT_ORDER.index(kind) if kind in EVENT_ORDER else len(EVENT_ORDER)
    m = re.match(r"[A-Za-z]+_(\d+)$", stem)
    num = int(m.group(1)) if m else 0
    if kind == "Step":
        num = {1: 0, 0: 1, 2: 2}.get(num, num)
    return ki, num, stem


# ======================================================================
# 全工程数据与预扫描
# ======================================================================

class Event:
    def __init__(self, fname: str, src: str) -> None:
        self.fname = fname
        self.src = src
        self.method, self.ekind, self.ereason = event_method(fname)
        self.ast: list[N] | None = None
        self.comments: list[Comment] = []
        self.error: str | None = None
        try:
            self.ast, self.comments = parse(src)
        except ParseError as e:  # 解析失败：整体注释输出
            self.error = str(e)
        except RecursionError:
            self.error = "递归过深"


class ObjData:
    def __init__(self, name: str, parent: str | None, files: list[str]) -> None:
        self.name = name
        self.parent = parent
        self.events: list[Event] = []
        for f in sorted(files, key=event_sort_key):
            p = ORIG / "objects" / name / f
            if p.exists():
                self.events.append(Event(f, read_text(p)))
        # 预扫描结果
        self.assign_kinds: dict[str, list[str]] = {}
        self.create_assigned: set[str] = set()
        self.order: list[str] = []  # 名字首次出现顺序
        self.reads: set[str] = set()


class Proj:
    def __init__(self) -> None:
        objs = json.loads((TABLES / "objects.json").read_text(encoding="utf-8"))["objects"]
        self.obj_table: dict[str, Any] = objs
        self.children: dict[str, list[str]] = {}
        for k, v in objs.items():
            if v.get("parent"):
                self.children.setdefault(v["parent"], []).append(k)
        names = json.loads((TABLES / "asset_names.json").read_text(encoding="utf-8"))
        self.script_assets: list[str] = names["scripts"]
        self.object_names: set[str] = set(names["objects"])
        # 资源常量：直接取 a.gd 的 const
        self.assets: set[str] = set(re.findall(r"^const (\w+): int", read_text(GMDIR / "a.gd"), re.M))
        g = json.loads((TABLES / "globals.json").read_text(encoding="utf-8"))
        self.globals: dict[str, str] = {k: v.get("likely_type", "") for k, v in g["globals"].items()}
        # 兼容层：GMObject 与 GM（gm.gd 及其继承链）
        self.obj_funcs, self.obj_vars, _ = scan_gd(GMDIR / "gm_object.gd")
        self.obj_vars = {k: v for k, v in self.obj_vars.items() if not k.startswith("_") and k != "COL"}
        self.obj_funcs = {k: v for k, v in self.obj_funcs.items() if not k.startswith("_")}
        self.obj_internal = {k for k in scan_gd(GMDIR / "gm_object.gd")[1]} | set(scan_gd(GMDIR / "gm_object.gd")[0])
        self.gm_funcs: dict[str, Sig] = {}
        self.gm_vars: dict[str, str] = {}
        self.gm_consts: dict[str, str] = {}
        for f in ("gm_base.gd", "gm_draw.gd", "gm_layer.gd", "gm_system.gd", "gm_audio.gd", "gm_input.gd", "gm.gd"):
            fu, va, co = scan_gd(GMDIR / f)
            self.gm_funcs.update({k: v for k, v in fu.items() if not k.startswith("_")})
            self.gm_vars.update({k: v for k, v in va.items() if not k.startswith("_")})
            self.gm_consts.update({k: v for k, v in co.items() if not k.startswith("_") and k.lower() == k})
        # 脚本里定义的函数、宏、枚举
        self.script_funcs: set[str] = set()
        self.macros: dict[str, str] = {}
        self.enums: dict[str, list[str]] = {}
        self.script_src: dict[str, str] = {}
        for sname in self.script_assets:
            p = ORIG / "scripts" / sname / f"{sname}.gml"
            if not p.exists():
                continue
            src = read_text(p)
            self.script_src[sname] = src
            masked = mask(src)
            self.script_funcs.update(re.findall(r"\bfunction\s+(\w+)\s*\(", masked))
            for m in re.finditer(r"\benum\s+(\w+)\s*\{([^}]*)\}", masked):
                self.enums[m.group(1)] = [x.split("=")[0].strip() for x in m.group(2).split(",") if x.strip()]
        # 和 GML 内置函数同名的脚本函数（GMS 导入旧工程时生成的 background_delete.gml 里定义了
        # sprite_delete 等，函数体只是调用同名内置函数）：GMS 调用的是内置函数，否则会无限递归
        self.script_funcs -= {"sprite_delete", "sprite_exists", "gpu_set_blendenable", "gpu_set_blendmode"}
        for gml in list((ORIG / "objects").rglob("*.gml")) + list((ORIG / "scripts").rglob("*.gml")):
            for m in re.finditer(r"^\s*#macro\s+(\w+)\s+(.*)$", read_text(gml), re.M):
                self.macros[m.group(1)] = m.group(2).strip()
        self.objs: dict[str, ObjData] = {}
        self.assigned_anywhere: set[str] = set()
        self.inst_used: set[str] = set()
        self._coll_target: str | None = None
        self._wt_stack: list[str | None] = []
        self._decl_cache: dict[str, dict[str, tuple[str, str | None]]] = {}
        self._chain_cache: dict[str, dict[str, tuple[str, str | None]]] = {}
        self._subtree_cache: dict[str, list[str]] = {}
        self._scripts_scanned = False

    # ---- 分类 ----
    def is_fixed_name(self, name: str) -> bool:
        """不是实例变量的名字（内置、资源、脚本、宏、枚举、特殊名）。"""
        return (name in self.obj_vars or name in self.gm_consts or
                (name in self.gm_vars and name in GML_GLOBAL_VARS) or name in self.assets or
                name in self.macros or name in self.enums or name in self.script_funcs or
                name in ("self", "other", "id", "noone", "all", "global", "true", "false",
                         "undefined", "pi", "infinity", "NaN", "argument", "argument_count") or
                re.fullmatch(r"argument\d+", name) is not None)

    def is_gml_global_missing(self, name: str) -> bool:
        if name in self.assigned_anywhere:
            return False
        return name in GML_GLOBAL_VARS or GML_CONST_PREFIX.match(name) is not None

    def global_kind(self, name: str) -> str:
        return {"number": "num", "string": "str", "bool": "bool", "array": "arr"}.get(self.globals.get(name, ""), "unk")

    # ---- 粗略类型（预扫描用，不产生代码） ----
    def rough_kind(self, e: N, locals_: set[str]) -> str:
        t = e.t
        if t == "num":
            return "noone" if e.val == -4 else "num"
        if t == "str":
            return "str"
        if t == "paren":
            return self.rough_kind(e.e, locals_)
        if t == "un":
            if e.op == "!":
                return "bool"
            r = lit_num(e)
            if r is not None:
                return "noone" if r[0] == -4 else "num"
            k = self.rough_kind(e.e, locals_)
            return "num" if k in ("num", "int", "bool") else "unk"
        if t == "name":
            n = e.name
            if n in locals_:
                return "unk"
            if n == "noone":
                return "noone"
            if n in ("true", "false"):
                return "bool"
            if n in ("self", "other", "id"):
                return "inst"
            if n in self.obj_vars:
                return gd_kind(self.obj_vars[n])
            if n in self.gm_consts:
                return gd_kind(self.gm_consts[n])
            if n in self.gm_vars and n in GML_GLOBAL_VARS:
                return gd_kind(self.gm_vars[n])
            if n in self.assets:
                return "int"
            if n in self.macros:
                return "str" if self.macros[n].startswith('"') else "num"
            return "unk"
        if t == "bin":
            if e.op in ("&&", "||", "^^", "==", "!=", "<>", "=", "<", "<=", ">", ">="):
                return "bool"
            a, b = self.rough_kind(e.l, locals_), self.rough_kind(e.r, locals_)
            if e.op == "+" and ("str" in (a, b)):
                return "str"
            if e.op == "+" and "unk" in (a, b):
                return "unk"
            return "num"
        if t == "tern":
            a, b = self.rough_kind(e.a, locals_), self.rough_kind(e.b, locals_)
            return a if a == b else "unk"
        if t == "call" and e.f.t == "name":
            n = e.f.name
            if n in MATH_GODOT or n in ("round", "sign", "min", "max"):
                return "num"
            if n == "string":
                return "str"
            if n in self.obj_funcs:
                return gd_kind(self.obj_funcs[n].ret)
            if n in self.gm_funcs:
                return gd_kind(self.gm_funcs[n].ret)
            return "unk"
        if t == "mem" and e.o.t == "name" and e.o.name == "global":
            return self.global_kind(e.name)
        if t == "array":
            return "arr"
        return "unk"

    # ---- 预扫描 ----
    def obj(self, name: str) -> ObjData:
        d = self.objs.get(name)
        if d is None:
            v = self.obj_table[name]
            d = ObjData(name, v.get("parent"), v.get("gml_files", []))
            self.objs[name] = d
            saved = (self._coll_target, self._wt_stack)  # 可能是在扫描别的 object 时递归进来的
            for ev in d.events:
                if ev.ast is not None:
                    self.scan_event(d, ev)
            self._coll_target, self._wt_stack = saved
        return d

    def scan_event(self, d: ObjData, ev: Event) -> None:
        assert ev.ast is not None
        locals_ = func_locals(ev.ast)
        in_create = ev.fname == "Create_0.gml"
        m = re.match(r"Collision_(\w+)\.gml$", ev.fname)
        self._coll_target = m.group(1) if m and m.group(1) in self.obj_table else None
        self._wt_stack = []
        self.scan_stmts(ev.ast, locals_, 0, d, in_create)
        self._coll_target = None

    def scan_stmts(self, stmts: list[N], locals_: set[str], wdepth: int, d: ObjData | None, in_create: bool) -> None:
        for s in stmts:
            self.scan_stmt(s, locals_, wdepth, d, in_create)

    def add_assign(self, d: ObjData, n: str, kind: str, in_create: bool) -> None:
        d.assign_kinds.setdefault(n, []).append(kind)
        if n not in d.order:
            d.order.append(n)
        if in_create:
            d.create_assigned.add(n)

    def with_target_obj(self, t: N) -> str | None:
        """with 目标能静态确定是哪个 object 时返回其名字（object 名、instance_create(…, obj)、碰撞事件的 other）。"""
        t = strip_paren(t)
        if t.t == "name":
            if t.name in self.obj_table:
                return t.name
            if t.name == "other" and not self._wt_stack:
                return self._coll_target
        if t.t == "call" and t.f.t == "name" and t.f.name in ("instance_create", "instance_create_depth") and t.args:
            a = strip_paren(t.args[-1])
            if a.t == "name" and a.name in self.obj_table:
                return a.name
        return None

    def note_assign(self, tgt: N, kind: str, locals_: set[str], wdepth: int, d: ObjData | None, in_create: bool) -> None:
        tgt = strip_paren(tgt)
        if tgt.t == "name":
            n = tgt.name
            if n in locals_ or self.is_fixed_name(n):
                return
            self.assigned_anywhere.add(n)
            if wdepth == 0 and d is not None:
                self.add_assign(d, n, kind, in_create)
            elif wdepth == 1 and self._wt_stack and self._wt_stack[-1]:
                # with (obj_x) { foo = … }：foo 是 obj_x 的实例变量
                self.add_assign(self.obj(self._wt_stack[-1]), n, kind, False)
        elif tgt.t == "mem":
            if not (tgt.o.t == "name" and tgt.o.name == "global"):
                self.assigned_anywhere.add(tgt.name)
                o = strip_paren(tgt.o)
                if o.t == "name" and o.name not in locals_:
                    if o.name == "other" and wdepth == 0 and self._coll_target:
                        self.add_assign(self.obj(self._coll_target), tgt.name, kind, False)
                    elif o.name == "other" and wdepth == 1 and d is not None:
                        self.add_assign(d, tgt.name, kind, False)
                    elif o.name in self.obj_table and wdepth == 0:
                        self.add_assign(self.obj(o.name), tgt.name, kind, False)
            self.note_inst_use(tgt.o)
        elif tgt.t == "idx":
            self.note_assign(tgt.o, "arr", locals_, wdepth, d, in_create)

    def note_reads(self, e: N, locals_: set[str], wdepth: int, d: ObjData | None) -> None:
        def f(x: N) -> None:
            if x.t == "name" and wdepth == 0 and d is not None:
                n = x.name
                if n not in locals_ and not self.is_fixed_name(n) and n not in self.gm_funcs and n not in self.obj_funcs:
                    d.reads.add(n)
                    if n not in d.order:
                        d.order.append(n)
            if x.t == "incdec":
                self.note_assign(x.e, "num", locals_, wdepth, d, False)

        # 手动递归：调用的函数名、成员访问的成员名不算读取
        def rec(x: N) -> None:
            if x.t == "call":
                if x.f.t != "name":
                    rec(x.f)
                for a in x.args:
                    rec(a)
                return
            if x.t == "mem":
                self.note_inst_use(x.o)
                rec(x.o)
                return
            f(x)
            for c in expr_children(x):
                rec(c)
        rec(e)

    def note_inst_use(self, o: N) -> None:
        """名字被当实例用（取成员、with 目标）：这样的实例变量不声明成 float。"""
        o = strip_paren(o)
        if o.t == "name":
            self.inst_used.add(o.name)
        elif o.t == "mem":
            self.inst_used.add(o.name)

    def scan_stmt(self, s: N, locals_: set[str], wdepth: int, d: ObjData | None, in_create: bool) -> None:
        t = s.t
        if t == "assign":
            k = self.rough_kind(s.value, locals_) if s.op == "=" else (
                "str" if self.rough_kind(s.value, locals_) == "str" else "num")
            self.note_assign(s.target, k, locals_, wdepth, d, in_create)
            tg = strip_paren(s.target)
            if tg.t != "name":
                self.note_reads(tg, locals_, wdepth, d)
            self.note_reads(s.value, locals_, wdepth, d)
            return
        if t == "with":
            self.note_inst_use(s.target)
            self.note_reads(s.target, locals_, wdepth, d)
            self._wt_stack.append(self.with_target_obj(s.target) if wdepth == 0 else None)
            self.scan_stmts(body_list(s.body), locals_, wdepth + 1, d, in_create)
            self._wt_stack.pop()
            return
        for e in stmt_exprs(s):
            self.note_reads(e, locals_, wdepth, d)
        if t == "func":
            inner = func_locals(s.body.body) | {p for p, _ in s.params}
            self.scan_stmts(s.body.body, inner, wdepth, None, False)
            return
        for c in sub_stmts(s):
            self.scan_stmt(c, locals_, wdepth, d, in_create)

    def scan_all(self) -> None:
        """预扫描全部 object 和脚本（实例变量类型要看子树，‘内置常量’判断要看全工程赋值）。"""
        for name in self.obj_table:
            self.obj(name)
        if not self._scripts_scanned:
            self._scripts_scanned = True
            for sname, src in self.script_src.items():
                try:
                    ast, _ = parse(src)
                except (ParseError, RecursionError):
                    continue
                self.scan_stmts(ast, func_locals(ast), 1, None, False)

    def subtree(self, name: str) -> list[str]:
        r = self._subtree_cache.get(name)
        if r is None:
            r = [name]
            for c in self.children.get(name, []):
                r += self.subtree(c)
            self._subtree_cache[name] = r
        return r

    def chain(self, name: str) -> list[str]:
        out: list[str] = []
        p = self.obj_table[name].get("parent")
        while p:
            out.append(p)
            p = self.obj_table[p].get("parent")
        return out

    def chain_methods(self, name: str) -> set[str]:
        """父类链（不含自己）上存在的事件方法名。"""
        out: set[str] = set()
        for p in self.chain(name):
            for f in self.obj_table[p].get("gml_files", []):
                out.add(event_method(f)[0])
        return out

    def own_methods(self, name: str) -> set[str]:
        return {event_method(f)[0] for f in self.obj_table[name].get("gml_files", [])}

    def chain_decls(self, name: str) -> dict[str, tuple[str, str | None]]:
        """父类链（不含自己）声明过的实例变量 → (类型, TODO)。"""
        r = self._chain_cache.get(name)
        if r is None:
            r = {}
            p = self.obj_table[name].get("parent")
            if p:
                r.update(self.chain_decls(p))
                r.update(self.decls(p))
            self._chain_cache[name] = r
        return r

    def decls(self, name: str) -> dict[str, tuple[str, str | None]]:
        """本 object 新声明的实例变量 → (类型 'float'/'String'/'', TODO 原因或 None)，按首次出现排序。"""
        r = self._decl_cache.get(name)
        if r is not None:
            return r
        d = self.obj(name)
        inherited = self.chain_decls(name)
        r = {}
        for n in d.order:
            if n in inherited or n in r or self.is_fixed_name(n):
                continue
            if n in d.assign_kinds:
                typ = ""
                if n in d.create_assigned and n not in self.inst_used:
                    sub_kinds: list[str] = []
                    for o in self.subtree(name):
                        sub_kinds += self.obj(o).assign_kinds.get(n, [])
                    create_ok = all(k in ("num", "int", "bool") for k in d.assign_kinds[n]) and \
                        any(k in ("num", "int") for k in d.assign_kinds[n])
                    if create_ok and all(k in ("num", "int", "bool", "unk") for k in sub_kinds):
                        typ = "float"
                    elif all(k == "str" for k in d.assign_kinds[n]) and all(k in ("str", "unk") for k in sub_kinds):
                        typ = "String"
                todo = f"内置实例变量缺失({n})" if n in GML_INST_MISSING else None
                r[n] = (typ, todo)
            else:
                if self.is_gml_global_missing(n):
                    continue
                if n in GML_INST_MISSING:
                    todo = f"内置实例变量缺失({n})"
                elif any(n in self.obj(o).assign_kinds for o in self.subtree(name)[1:]):
                    todo = f"仅子类赋值({n})"
                elif re.match(r"(obj|spr|snd|rm|bg|s|fnt|sha|shd|pth|path)_", n):
                    todo = f"疑似缺失资源({n})"
                else:
                    todo = f"未声明标识符({n})"
                r[n] = ("", todo)
        self._decl_cache[name] = r
        return r


def mask(src: str) -> str:
    from gmlib import mask_comments_and_strings
    return mask_comments_and_strings(src)


# ======================================================================
# 发射
# ======================================================================

class E:
    __slots__ = ("code", "kind", "prec")

    def __init__(self, code: str, kind: str = "unk", prec: int = 20) -> None:
        self.code, self.kind, self.prec = code, kind, prec


def wrap(e: E, minprec: int) -> str:
    return e.code if e.prec >= minprec else f"({e.code})"


def gdstr(s: str) -> str:
    out = ['"']
    for ch in s:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\r":
            out.append("\\r")
        elif ch == "\t":
            out.append("\\t")
        elif ord(ch) < 32:
            out.append("\\u%04x" % ord(ch))
        else:
            out.append(ch)
    out.append('"')
    return "".join(out)


def fmt_num(node: N, want: str) -> E:
    if node.hex:
        return E(node.hex, "int")
    v = float(node.val)
    if want == "bool" and v in (0.0, 1.0):
        return E("true" if v == 1.0 else "false", "bool")
    if v.is_integer():
        if want == "int":
            return E(str(int(v)), "int")
        return E(f"{int(v)}.0", "num")
    t = node.text
    if t.startswith("."):
        t = "0" + t
    if t.endswith("."):
        t += "0"
    return E(t, "num")


class Fn:
    """一个正在发射的函数（事件或脚本函数）的上下文。"""

    def __init__(self, mode: str, method: str, collision: bool, locals_: set[str], hoisted: set[str],
                 params: set[str], comments: list[Comment], src: str, variadic: bool = False) -> None:
        self.mode = mode
        self.method = method
        self.collision = collision
        self.locals = locals_ | params
        self.hoisted = hoisted
        self.scopes: list[set[str]] = [set(params) | set(hoisted)]
        self.with_stack: list[str] = []
        self.loops: list[dict[str, Any]] = []
        self.comments = comments
        self.ci = 0
        self.src = src
        self.variadic = variadic
        self.me = "me"
        self.lkinds: dict[str, str] = {}


class ScopeScan:
    """判断哪些局部变量要提升到函数开头（GML 的 var 是函数作用域，GDScript 是块作用域）。"""

    def __init__(self, locals_: set[str], params: set[str]) -> None:
        self.locals = locals_
        self.ctr = 0
        self.first: dict[str, tuple[int, ...]] = {p: () for p in params}
        self.bad: set[str] = set()

    def newp(self, path: tuple[int, ...]) -> tuple[int, ...]:
        self.ctr += 1
        return path + (self.ctr,)

    def ref(self, name: str, path: tuple[int, ...]) -> None:
        if name not in self.locals:
            return
        f = self.first.get(name)
        if f is None or path[:len(f)] != f:
            self.bad.add(name)

    def decl(self, name: str, path: tuple[int, ...]) -> None:
        f = self.first.get(name)
        if f is None:
            self.first[name] = path
        elif path[:len(f)] != f:
            self.bad.add(name)

    def refs(self, e: N | None, path: tuple[int, ...]) -> None:
        def f(x: N) -> None:
            if x.t == "name":
                self.ref(x.name, path)
        walk_expr(e, f)

    def stmts(self, ss: list[N], path: tuple[int, ...]) -> None:
        for s in ss:
            self.stmt(s, path)

    def body(self, s: N | None, path: tuple[int, ...]) -> None:
        self.stmts(body_list(s), self.newp(path))

    def stmt(self, s: N, path: tuple[int, ...]) -> None:
        t = s.t
        if t == "block":
            self.stmts(s.body, path)
        elif t == "var":
            for name, init in s.decls:
                self.refs(init, path)
                self.decl(name, path)
        elif t == "if":
            self.refs(s.c, path)
            self.body(s.then, path)
            el = s.els
            while el is not None and el.t == "if":
                self.refs(el.c, path)
                self.body(el.then, path)
                el = el.els
            if el is not None:
                self.body(el, path)
        elif t in ("while", "repeat", "with"):
            for e in stmt_exprs(s):
                self.refs(e, path)
            self.body(s.body, path)
        elif t == "do":
            p = self.newp(path)
            self.stmts(body_list(s.body), p)
            self.refs(s.c, p)
        elif t == "for":
            if s.init:
                self.stmt(s.init, path)
            self.refs(s.cond, path)
            p = self.newp(path)
            self.stmts(body_list(s.body), p)
            if s.step:
                self.stmt(s.step, p)
        elif t == "switch":
            self.refs(s.e, path)
            for _, body, _ in s.cases:
                self.stmts(body, self.newp(path))
        else:
            for e in stmt_exprs(s):
                self.refs(e, path)


def local_kinds(proj: Proj, stmts: list[N], locals_: set[str]) -> dict[str, str]:
    """局部变量的静态类型：所有赋值都是“返回实例的函数”时记为 inst（条件里写成 != null）。"""
    seen: dict[str, set[str]] = {}

    def f(s: N) -> None:
        if s.t == "var":
            for name, init in s.decls:
                if init is not None:
                    seen.setdefault(name, set()).add(proj.rough_kind(init, set()))
        elif s.t == "assign":
            tg = strip_paren(s.target)
            if tg.t == "name" and tg.name in locals_:
                seen.setdefault(tg.name, set()).add(proj.rough_kind(s.value, set()) if s.op == "=" else "num")
        elif s.t == "expr" and s.e.t == "incdec":
            tg = strip_paren(s.e.e)
            if tg.t == "name":
                seen.setdefault(tg.name, set()).add("num")
    walk_stmts(stmts, f)
    return {k: "inst" for k, v in seen.items() if v == {"inst"} and k in locals_}


def has_own_continue(stmts: list[N]) -> bool:
    for s in stmts:
        if s.t == "continue":
            return True
        if s.t in ("while", "for", "do", "repeat", "with", "func"):
            continue
        if has_own_continue(sub_stmts(s)):
            return True
    return False


def has_switch_break(stmts: list[N]) -> bool:
    """case 体里（不在内层循环/with/switch 中）还有 break。"""
    for s in stmts:
        if s.t == "break":
            return True
        if s.t in ("while", "for", "do", "repeat", "with", "switch", "func"):
            continue
        if has_switch_break(sub_stmts(s)):
            return True
    return False


def strip_break(stmts: list[N]) -> tuple[list[N], bool]:
    """去掉 case 体末尾的 break → (新语句表, 是否以 break/return/exit/continue 结束)。"""
    ss = [s for s in stmts if s.t != "empty"]
    if not ss:
        return ss, False
    last = ss[-1]
    if last.t == "break":
        return ss[:-1], True
    if last.t in ("return", "exit", "continue"):
        return ss, True
    if last.t == "block":
        inner, term = strip_break(last.body)
        if term:
            nb = N("block", body=inner)
            nb.__dict__.update({k: v for k, v in last.__dict__.items() if k not in ("body", "t")})
            return ss[:-1] + [nb], True
    return ss, False


class Emitter:
    def __init__(self, proj: Proj, mode: str, objname: str | None = None) -> None:
        self.p = proj
        self.mode = mode
        self.objname = objname
        self.lines: list[str] = []
        self.ind = 0
        self.block_code: list[int] = [0]
        self.todos: list[str] = []
        self.fn: Fn = None  # type: ignore[assignment]
        self.g_used: set[str] = set()
        self.scr_used: set[str] = set()
        self.ivars: dict[str, tuple[str, str | None]] = {}
        self.chain_m: set[str] = set()
        self.own_m: set[str] = set()
        if mode == "object" and objname:
            self.ivars = dict(proj.chain_decls(objname))
            self.ivars.update(proj.decls(objname))
            self.chain_m = proj.chain_methods(objname)
            self.own_m = proj.own_methods(objname)

    # ---- 输出 ----
    def out(self, text: str, code: bool = True) -> None:
        self.lines.append("\t" * self.ind + text)
        if code:
            self.block_code[-1] += 1

    def todo(self, reason: str) -> None:
        if reason not in self.todos:
            self.todos.append(reason)

    def line(self, code: str, s: N | None = None, header: bool = False) -> None:
        text = code
        fn = self.fn
        if s is not None:
            last = s.l0 if header else s.l1
            trail: list[str] = []
            while fn.ci < len(fn.comments) and fn.comments[fn.ci].line <= last and \
                    (not fn.comments[fn.ci].own or not header):
                c = fn.comments[fn.ci]
                if header and c.line != s.l0:
                    break
                trail.append(" ".join(x.strip() for x in c.lines))
                fn.ci += 1
            if trail:
                text += "  # " + " ".join(trail)
        if self.todos:
            text += "  # TODO-GML: " + "; ".join(self.todos)
            self.todos = []
        self.out(text)

    def flush_comments(self, upto: float) -> None:
        fn = self.fn
        while fn.ci < len(fn.comments) and fn.comments[fn.ci].line < upto:
            for x in fn.comments[fn.ci].lines:
                x = x.rstrip()
                self.out(("#" + x) if x.startswith(" ") or not x else ("# " + x), code=False)
            fn.ci += 1

    def skip_comments(self, upto: int) -> None:
        fn = self.fn
        while fn.ci < len(fn.comments) and fn.comments[fn.ci].line <= upto:
            fn.ci += 1

    def emit_raw(self, s: N, reason: str) -> None:
        text = self.fn.src[s.p0:s.p1]
        raw = text.split("\n")
        # 去掉共同缩进（第一行本来就从语句开头截起）
        rest = [x for x in raw[1:] if x.strip()]
        common = min((len(x) - len(x.lstrip()) for x in rest), default=0)
        for i, x in enumerate(raw):
            x = x.rstrip("\r").rstrip()
            if i > 0:
                x = x[common:] if len(x) >= common else x.lstrip()
            if x.strip():
                self.out("# GML: " + x.replace("\t", "    "), code=False)
        self.out(f"pass  # TODO-GML: {reason}")
        self.skip_comments(s.l1)

    # ---- 名字 ----
    def safe_member(self, name: str) -> str:
        if name in GD_RESERVED or name in NODE_MEMBERS or (name in self.p.obj_internal and name not in self.p.obj_vars
                                                            and name not in self.p.obj_funcs):
            return name + "_v"
        return name

    @staticmethod
    def safe_local(name: str) -> str:
        return name + "_v" if name in GD_RESERVED else name

    def selfref(self) -> str:
        if self.fn.with_stack:
            return self.fn.with_stack[-1]
        return self.fn.me if self.fn.mode == "script" else "self"

    def pref(self) -> str:
        if self.fn.with_stack:
            return self.fn.with_stack[-1] + "."
        return self.fn.me + "." if self.fn.mode == "script" else ""

    def otherref(self) -> str:
        ws = self.fn.with_stack
        if ws:
            if len(ws) == 1:
                return self.fn.me if self.fn.mode == "script" else "self"
            return ws[-2]
        if self.fn.collision:
            return "other"
        self.todo("other来源不定")
        return 'GM.get(&"other")'

    def ivar_kind(self, name: str) -> str:
        if self.fn.mode != "object":
            return "unk"
        typ = self.ivars.get(name, ("", None))[0]
        return {"float": "num", "String": "str"}.get(typ, "unk")

    def member_kind(self, name: str) -> str:
        return gd_kind(self.p.obj_vars[name]) if name in self.p.obj_vars else "unk"

    def mname(self, name: str) -> str:
        return name if name in self.p.obj_vars else self.safe_member(name)

    # ---- 表达式 ----
    def expr(self, e: N, want: str = "float") -> E:
        t = e.t
        if t == "num":
            return fmt_num(e, want)
        if t == "str":
            return E(gdstr(e.val), "str")
        if t == "paren":
            inner = self.expr(e.e, want)
            return E(f"({inner.code})", inner.kind, 20)
        if t == "name":
            return self.name_read(e.name)
        if t == "mem":
            return self.member(e)
        if t == "idx":
            return self.index(e, write=False)
        if t == "call":
            return self.call(e)
        if t == "un":
            if e.op == "!":
                return self.cond(e)
            if e.op == "-":
                inner = self.expr(e.e, want)
                if strip_paren(e.e).t == "num":
                    return E("-" + inner.code, inner.kind, 13)
                return E("-" + wrap(inner, 13), "num" if inner.kind in ("num", "unk", "bool") else inner.kind, 13)
            if e.op == "+":
                return self.expr(e.e, want)
            if e.op == "~":
                self.todo("位运算")
                inner = self.expr(e.e, "int")
                return E(f"~int({inner.code})", "int", 13)
        if t == "bin":
            return self.binary(e, want)
        if t == "tern":
            c = self.cond(e.c)
            a = self.expr(e.a, want)
            b = self.expr(e.b, want)
            return E(f"{wrap(a, 2)} if {wrap(c, 2)} else {wrap(b, 2)}", a.kind if a.kind == b.kind else "unk", 1)
        if t == "incdec":
            raise Unsup("表达式内自增")
        if t == "array":
            items = [self.expr(x).code for x in e.items]
            return E("[" + ", ".join(items) + "]", "arr")
        if t == "struct":
            raise Unsup("结构体")
        raise Unsup("不支持的表达式")

    def name_read(self, name: str) -> E:
        fn, p = self.fn, self.p
        if name in fn.locals:
            return E(self.safe_local(name), fn.lkinds.get(name, "unk"))
        m = re.fullmatch(r"argument(\d+)", name)
        if m:
            if fn.mode != "script":
                raise Unsup("argument")
            return E(f"argument[{m.group(1)}]" if fn.variadic else name, "unk")
        if name == "argument_count":
            if fn.mode == "script" and fn.variadic:
                return E("float(argument.size())", "num")
            raise Unsup("argument")
        if name in ("self", "id"):
            return E(self.selfref(), "inst")
        if name == "other":
            return E(self.otherref(), "inst")
        if name == "noone":
            return E("GM.noone", "noone")
        if name == "all":
            return E("GM.all", "int")
        if name == "global":
            raise Unsup("global单独使用")
        if name in ("true", "false"):
            return E(name, "bool")
        if name == "undefined":
            return E("null", "null")
        if name == "pi":
            return E("PI", "num")
        if name == "infinity":
            return E("INF", "num")
        if name == "NaN":
            return E("NAN", "num")
        if name in p.obj_vars:
            return E(self.pref() + name, gd_kind(p.obj_vars[name]))
        if name in p.gm_consts:
            return E("GM." + name, gd_kind(p.gm_consts[name]))
        if name in p.gm_vars and name in GML_GLOBAL_VARS:
            return E("GM." + name, gd_kind(p.gm_vars[name]))
        if name in p.assets:
            return E("A." + name, "int")
        if name in p.macros:
            self.scr_used.add(name)
            return E("Scr." + name, "str" if p.macros[name].startswith('"') else "num")
        if name in p.enums:
            self.scr_used.add(name)
            return E("Scr." + name, "unk")
        if name in p.script_funcs:
            raise Unsup("脚本引用")
        if p.is_gml_global_missing(name):
            self.todo(f"兼容层没有变量({name})")
            return E(f'GM.get(&"{name}")', "unk")
        if name in GML_INST_MISSING:
            self.todo(f"内置实例变量缺失({name})")
        if fn.mode == "script" and not fn.with_stack:
            self.todo("脚本内实例变量")
        return E(self.pref() + self.safe_member(name), self.ivar_kind(name) if not fn.with_stack else "unk")

    def member(self, e: N, write: bool = False) -> E:
        o, name = e.o, e.name
        if o.t == "name" and o.name not in self.fn.locals:
            if o.name == "global":
                self.g_used.add(name)
                return E("G." + name, self.p.global_kind(name))
            if o.name in self.p.enums:
                self.scr_used.add(o.name)
                return E(f"Scr.{o.name}.{name}", "int")
            if o.name in self.p.object_names:
                if write:
                    raise Unsup("obj.var访问")
                self.todo("obj.var访问")
                return E(f"GM.instance_find(A.{o.name}, 0).{self.mname(name)}", self.member_kind(name))
            if o.name in self.p.assets:
                raise Unsup("资源上取成员")
        b = self.expr(o)
        if b.kind in ("num", "int", "str", "bool", "noone"):
            raise Unsup("非实例取成员")
        kind = self.member_kind(name)
        if b.code == "self" and name not in self.p.obj_vars:
            kind = self.ivar_kind(name)
        return E(f"{wrap(b, 20)}.{self.mname(name)}", kind)

    def index(self, e: N, write: bool) -> E:
        o = e.o
        if o.t == "name" and o.name == "argument" and "argument" not in self.fn.locals:
            if self.fn.mode == "script" and self.fn.variadic:
                i = self.expr(e.idx[0], "int")
                return E(f"argument[{i.code}]", "unk")
            raise Unsup("argument")
        if o.t == "name" and o.name == "alarm" and "alarm" not in self.fn.locals:
            base = self.pref() + "alarm"
            kind = "num"
        else:
            b = self.expr(o)
            if b.kind in ("num", "int", "bool", "noone"):
                raise Unsup("非数组取下标")
            base = wrap(b, 20)
            kind = "num" if b.kind == "arr" and strip_paren(o).t == "mem" and o.name == "alarm" else "unk"
            if write and b.kind != "arr":
                self.todo("数组写入")
        acc = e.acc
        if acc in ("#", "$"):
            raise Unsup("ds_grid/结构体访问器")
        idx = [self.expr(i, "int").code for i in e.idx]
        if acc == "?":
            if len(idx) != 1:
                raise Unsup("ds_map访问器")
            return E(f"{base}[{idx[0]}]" if write else f"{base}.get({idx[0]})", kind)
        if len(idx) == 2:
            return E(f"{base}[{idx[0]}][{idx[1]}]", kind)
        if len(idx) != 1:
            raise Unsup("多维数组")
        return E(f"{base}[{idx[0]}]", kind)

    def binary(self, e: N, want: str) -> E:
        op = e.op
        if op in ("&&", "||", "^^"):
            return self.cond(e)
        if op in ("==", "!=", "<>", "=", "<", "<=", ">", ">="):
            return self.compare(e)
        if op == "??":
            raise Unsup("??运算")
        l, r = self.operands(e.l, e.r)
        if op in ("div", "mod", "%"):
            f = "gm_div" if op == "div" else "gm_mod"
            return E(f"GM.{f}({l.code}, {r.code})", "num")
        if op in ("&", "|", "^", "<<", ">>"):
            self.todo("位运算")
            l, r = self.operands(e.l, e.r, "int")
            return E(f"int({l.code}) {op} int({r.code})", "int", GD_PREC[op])
        prec = GD_PREC[op]
        if l.kind == "bool":
            l = E(f"float({l.code})", "num")
        if r.kind == "bool":
            r = E(f"float({r.code})", "num")
        if l.kind == "void" or r.kind == "void":
            raise Unsup("void返回值")
        if op == "+" and "str" in (l.kind, r.kind):
            kind = "str"
        elif l.kind == "int" and r.kind == "int":
            kind = "int"
        elif op == "+" and "unk" in (l.kind, r.kind):
            kind = "unk"
        else:
            kind = "num"
        return E(f"{wrap(l, prec)} {op} {wrap(r, prec + 1)}", kind, prec)

    def operands(self, a: N, b: N, want: str = "float") -> tuple[E, E]:
        """字面量的整数/浮点写法跟随另一边：另一边是 int（资源编号、sprite_index 等）就写整数。"""
        la, lb = lit_num(a), lit_num(b)
        if la is not None and lb is None:
            eb = self.expr(b, want)
            ea = self.expr(a, "int" if eb.kind == "int" else want)
            return ea, eb
        ea = self.expr(a, want)
        eb = self.expr(b, "int" if (lb is not None and ea.kind == "int") else want)
        return ea, eb

    def compare(self, e: N) -> E:
        op = {"=": "==", "<>": "!="}.get(e.op, e.op)
        ln, rn = strip_paren(e.l), strip_paren(e.r)
        if op in ("==", "!="):
            def is_noone(x: N) -> bool:
                return x.t == "name" and x.name == "noone" and "noone" not in self.fn.locals
            if is_noone(rn) or is_noone(ln):
                other = ln if is_noone(rn) else rn
                oe = self.expr(other)
                if oe.kind == "inst":
                    return E(f"{wrap(oe, 7)} {op} null", "bool", GD_PREC["cmp"])
                return E(f"{wrap(oe, 7)} {op} GM.noone", "bool", GD_PREC["cmp"])
        l, r = self.operands(e.l, e.r)
        # GML 的布尔就是 0/1：和数字字面量 0/1 比较时写成 true/false，和别的数比较时转成 float
        for x, yn, side in ((l, rn, "r"), (r, ln, "l")):
            if x.kind == "bool":
                lv = lit_num(yn)
                if lv is not None and lv[0] in (0.0, 1.0) and op in ("==", "!="):
                    b = E("true" if lv[0] == 1.0 else "false", "bool")
                    l, r = (l, b) if side == "r" else (b, r)
                elif (r if side == "r" else l).kind in ("num", "int"):
                    fx = E(f"float({x.code})", "num")
                    l, r = (fx, r) if side == "r" else (l, fx)
        if "str" in (l.kind, r.kind) and ({l.kind, r.kind} & {"num", "int", "bool"}):
            raise Unsup("字符串与数字比较")
        for x, y, yn in ((l, r, rn), (r, l, ln)):
            if x.kind == "inst" and op in ("==", "!="):
                lv = lit_num(yn)
                if lv is not None and lv[0] == -4:
                    return E(f"{wrap(x, 7)} {op} null", "bool", GD_PREC["cmp"])
                if y.kind in ("num", "int"):
                    raise Unsup("实例与数值比较")
        if op in ("==", "!="):
            for lv in (lit_num(ln), lit_num(rn)):
                if lv is not None and not lv[1] and not float(lv[0]).is_integer() and "str" not in (l.kind, r.kind):
                    c = f"GM.eq({l.code}, {r.code})"
                    return E(c, "bool") if op == "==" else E("not " + c, "bool", GD_PREC["not"])
        return E(f"{wrap(l, 7)} {op} {wrap(r, 7)}", "bool", GD_PREC["cmp"])

    def cond(self, e: N) -> E:
        """条件位置：返回 bool 的写法（port-plan §3.3 第 7 条）。"""
        t = e.t
        if t == "paren":
            c = self.cond(e.e)
            return E(f"({c.code})", "bool")
        if t == "bin" and e.op in ("&&", "||"):
            a, b = self.cond(e.l), self.cond(e.r)
            gop, pr = ("and", 3) if e.op == "&&" else ("or", 2)
            return E(f"{wrap(a, pr)} {gop} {wrap(b, pr + 1)}", "bool", pr)
        if t == "bin" and e.op == "^^":
            a, b = self.cond(e.l), self.cond(e.r)
            return E(f"{wrap(a, 7)} != {wrap(b, 7)}", "bool", GD_PREC["cmp"])
        if t == "un" and e.op == "!":
            inner = strip_paren(e.e)
            x = self.expr(inner) if not (inner.t == "bin" and inner.op in ("&&", "||", "^^")) and \
                not (inner.t == "un" and inner.op == "!") else self.cond(inner)
            if x.kind == "inst":
                return E(f"{wrap(x, 7)} == null", "bool", GD_PREC["cmp"])
            if x.kind != "bool":
                self.todo("真值判断")
            return E("not " + wrap(x, 4), "bool", GD_PREC["not"])
        x = self.expr(e)
        if x.kind == "bool":
            return x
        if x.kind == "inst":
            return E(f"{wrap(x, 7)} != null", "bool", GD_PREC["cmp"])
        self.todo("真值判断")
        return x

    # ---- 调用 ----
    def call(self, e: N) -> E:
        f = e.f
        if f.t != "name":
            raise Unsup("动态调用")
        name, args = f.name, e.args
        p, fn = self.p, self.fn
        if name in fn.locals or re.fullmatch(r"argument\d+", name):
            raise Unsup("动态调用")
        if name == "event_inherited":
            raise Unsup("event_inherited位置")
        if name in ("event_perform", "event_perform_object"):
            raise Unsup("event_perform")
        if name == "script_execute":
            raise Unsup("动态调用")
        if name == "event_user":
            if len(args) != 1:
                raise Unsup("参数个数(event_user)")
            lv = lit_num(args[0])
            if lv is not None and float(lv[0]).is_integer():
                k = int(lv[0])
                m = f"_user_{k}"
                if fn.mode == "object" and not fn.with_stack and (m in self.chain_m or m in self.own_m):
                    return E(f"{m}()", "void")
                return E(f"{self.pref()}event_user({k})", "void")
            return E(f"{self.pref()}event_user(int({self.expr(args[0]).code}))", "void")
        if name == "instance_destroy" and not args:
            return E(f"{self.pref()}instance_destroy()", "void")
        if name in MATH_GODOT:
            g, n = MATH_GODOT[name]
            if len(args) != n:
                raise Unsup(f"参数个数({name})")
            return E(f"{g}(" + ", ".join(self.expr(a).code for a in args) + ")", "num")
        if name in MATH_GM:
            if len(args) != 1:
                raise Unsup(f"参数个数({name})")
            return E(f"GM.{MATH_GM[name]}({self.expr(args[0]).code})", "str" if name == "string" else "num")
        if name in ("min", "max"):
            if len(args) < 2:
                raise Unsup(f"参数个数({name})")
            g = name + "f"
            code = self.expr(args[0]).code
            for a in args[1:]:
                code = f"{g}({code}, {self.expr(a).code})"
            return E(code, "num")
        if name in p.obj_funcs and not (name == "instance_destroy" and args):
            return self.sig_call(self.pref() + name, p.obj_funcs[name], args)
        if name in p.gm_funcs:
            return self.sig_call("GM." + name, p.gm_funcs[name], args)
        if name in p.script_funcs:
            self.scr_used.add(name)
            parts = [self.selfref()] + [self.expr(a).code for a in args]
            return E(f"Scr.{name}(" + ", ".join(parts) + ")", "unk")
        if name in p.assets:
            raise Unsup("动态调用")
        self.todo(f"兼容层没有函数({name})")
        parts = [f'&"{name}"'] + [self.expr(a).code for a in args]
        return E("GM.call(" + ", ".join(parts) + ")", "unk")

    def sig_call(self, callee: str, sig: Sig, args: list[N]) -> E:
        params = sig.params
        variadic = bool(params) and params[-1][3]
        fixed = params[:-1] if variadic else params
        codes: list[str] = []
        for i, a in enumerate(args):
            ptype = fixed[i][1] if i < len(fixed) else ("Variant" if variadic else None)
            if ptype is None:
                raise Unsup(f"参数个数({sig.name})")
            codes.append(self.conv_arg(a, ptype, sig.name))
        n = len(args)
        # 隐含 self 的参数（port-plan §3.2 末段：notme 之后多带一个 me）
        if n < len(fixed) and fixed[n][0] == "me":
            codes.append(self.selfref())
            n += 1
        required = sum(1 for (_, _, hd, _) in fixed if not hd)
        if n < required:
            raise Unsup(f"参数个数({sig.name})")
        return E(f"{callee}(" + ", ".join(codes) + ")", gd_kind(sig.ret))

    def conv_arg(self, a: N, ptype: str, fname: str) -> str:
        if ptype == "bool":
            lv = lit_num(a)
            if lv is not None and lv[0] in (0.0, 1.0):
                return "true" if lv[0] == 1.0 else "false"
            x = self.expr(a)
            if x.kind not in ("bool", "unk"):
                self.todo("bool实参")
            return x.code
        if ptype == "int":
            return self.expr(a, "int").code
        return self.expr(a).code

    # ---- 左值 ----
    def lvalue(self, t: N) -> E:
        t = strip_paren(t)
        fn, p = self.fn, self.p
        if t.t == "name":
            name = t.name
            if name in fn.locals:
                return E(self.safe_local(name), "unk")
            if re.fullmatch(r"argument\d+", name) and fn.mode == "script":
                return E(f"argument[{name[8:]}]" if fn.variadic else name, "unk")
            if name in ("self", "other", "id", "noone", "all", "global", "argument", "argument_count",
                        "true", "false", "pi", "undefined"):
                raise Unsup("给特殊名赋值")
            if name in p.obj_vars:
                return E(self.pref() + name, gd_kind(p.obj_vars[name]))
            if name in p.gm_consts or name in p.assets or name in p.macros or name in p.enums or name in p.script_funcs:
                raise Unsup("给常量赋值")
            if name in p.gm_vars and name in GML_GLOBAL_VARS:
                if name == "room":
                    raise Unsup("给room赋值")
                return E("GM." + name, gd_kind(p.gm_vars[name]))
            if p.is_gml_global_missing(name):
                raise Unsup(f"兼容层没有变量({name})")
            if name in GML_INST_MISSING:
                self.todo(f"内置实例变量缺失({name})")
            if fn.mode == "script" and not fn.with_stack:
                self.todo("脚本内实例变量")
            return E(self.pref() + self.safe_member(name), self.ivar_kind(name) if not fn.with_stack else "unk")
        if t.t == "mem":
            return self.member(t, write=True)
        if t.t == "idx":
            return self.index(t, write=True)
        raise Unsup("无效赋值目标")

    # ---- 语句 ----
    def emit_stmt(self, s: N) -> None:
        fn = self.fn
        self.flush_comments(s.l0)
        snap = (len(self.lines), self.ind, list(self.block_code), fn.ci, [set(x) for x in fn.scopes],
                len(fn.with_stack), len(fn.loops))
        self.todos = []
        try:
            getattr(self, "st_" + s.t)(s)
        except Unsup as u:
            del self.lines[snap[0]:]
            self.ind = snap[1]
            self.block_code = snap[2]
            fn.ci = snap[3]
            fn.scopes = snap[4]
            del fn.with_stack[snap[5]:]
            del fn.loops[snap[6]:]
            self.todos = []
            self.emit_raw(s, u.reason)

    def emit_body(self, body: N | list[N] | None, post: Callable[[], None] | None = None) -> None:
        self.ind += 1
        self.block_code.append(0)
        self.fn.scopes.append(set())
        if isinstance(body, list):
            stmts, endl = body, None
        else:
            stmts = body_list(body)
            endl = body.l_end if body is not None and body.t == "block" else None
        for s in stmts:
            self.emit_stmt(s)
        if endl is not None:
            self.flush_comments(endl)
        if post:
            post()
        if self.block_code[-1] == 0:
            self.out("pass")
        self.fn.scopes.pop()
        n = self.block_code.pop()
        self.block_code[-1] += n
        self.ind -= 1

    def inline(self, s: N) -> None:
        """for 的初始化/增量语句：直接发射，不处理注释。"""
        self.todos = []
        getattr(self, "st_" + s.t)(s)

    def st_empty(self, s: N) -> None:
        pass

    def st_block(self, s: N) -> None:
        for x in s.body:
            self.emit_stmt(x)
        self.flush_comments(s.l_end)

    def st_assign(self, s: N) -> None:
        tgt = self.lvalue(s.target)
        op = s.op
        if op == "=":
            if tgt.kind == "bool":
                lv = lit_num(s.value)
                if lv is not None and lv[0] in (0.0, 1.0):
                    v = E("true" if lv[0] == 1.0 else "false", "bool")
                else:
                    v = self.expr(s.value)
                    if v.kind not in ("bool", "unk"):
                        self.todo("bool赋值")
            else:
                v = self.expr(s.value, "int" if tgt.kind == "int" else "float")
            if v.kind == "void":
                raise Unsup("void返回值")
            self.line(f"{tgt.code} = {v.code}", s)
        elif op in ("+=", "-=", "*=", "/="):
            v = self.expr(s.value, "int" if tgt.kind == "int" else "float")
            self.line(f"{tgt.code} {op} {v.code}", s)
        elif op == "%=":
            v = self.expr(s.value)
            self.line(f"{tgt.code} = GM.gm_mod({tgt.code}, {v.code})", s)
        elif op in ("&=", "|=", "^=", "<<=", ">>="):
            self.todo("位运算")
            v = self.expr(s.value, "int")
            self.line(f"{tgt.code} = int({tgt.code}) {op[:-1]} int({v.code})", s)
        else:
            raise Unsup("??运算")

    def st_expr(self, s: N) -> None:
        e = s.e
        if e.t == "incdec":
            tgt = self.lvalue(e.e)
            one = "1" if tgt.kind == "int" else "1.0"
            self.line(f"{tgt.code} {'+=' if e.op == '++' else '-='} {one}", s)
            return
        if e.t == "call":
            if e.f.t == "name" and e.f.name == "event_inherited":
                fn = self.fn
                if fn.with_stack or fn.mode != "object":
                    raise Unsup("event_inherited位置")
                if fn.method in self.chain_m:
                    self.line(f"super.{fn.method}({'other' if fn.collision else ''})", s)
                else:
                    self.out("# event_inherited(): 父类无此事件", code=False)
                    self.skip_comments(s.l1)
                return
            c = self.call(e)
            self.line(c.code, s)
            return
        raise Unsup("无效语句")

    def st_var(self, s: N) -> None:
        fn = self.fn
        for name, init in s.decls:
            nm = self.safe_local(name)
            ie = self.expr(init) if init is not None else None
            if ie is not None and ie.kind == "void":
                raise Unsup("void返回值")
            code = ie.code if ie is not None else None
            declared = name in fn.hoisted or any(name in sc for sc in fn.scopes)
            if declared:
                if code is None:
                    self.line(f"pass  # GML: var {name}", s)
                else:
                    self.line(f"{nm} = {code}", s)
            else:
                fn.scopes[-1].add(name)
                self.line(f"var {nm}" + (f" = {code}" if code is not None else ""), s)

    def st_if(self, s: N) -> None:
        c = self.cond(strip_paren(s.c))
        self.line(f"if {c.code}:", s, header=True)
        self.emit_body(s.then)
        el = s.els
        while el is not None:
            if el.t == "if":
                self.flush_comments(el.l0)
                self.todos = []
                try:
                    c2 = self.cond(strip_paren(el.c))
                except Unsup:
                    self.todos = []
                    self.out("else:")
                    self.emit_body(el)
                    return
                self.line(f"elif {c2.code}:", el, header=True)
                self.emit_body(el.then)
                el = el.els
            else:
                self.flush_comments(el.l0)
                self.out("else:")
                self.emit_body(el)
                return

    def st_while(self, s: N) -> None:
        c = self.cond(strip_paren(s.c))
        self.line(f"while {c.code}:", s, header=True)
        self.fn.loops.append({"k": "while"})
        try:
            self.emit_body(s.body)
        finally:
            self.fn.loops.pop()

    def st_do(self, s: N) -> None:
        c = self.cond(strip_paren(s.c))
        ctodos = self.todos
        self.todos = []
        if has_own_continue(body_list(s.body)):
            self.todo("do-until含continue")
        self.line("while true:", s, header=True)
        self.fn.loops.append({"k": "do"})

        def post() -> None:
            self.todos = ctodos
            self.line(f"if {c.code}:")
            self.ind += 1
            self.out("break")
            self.ind -= 1
        try:
            self.emit_body(s.body, post)
        finally:
            self.fn.loops.pop()

    def st_for(self, s: N) -> None:
        if s.init is not None:
            self.inline(s.init)
        c = self.cond(strip_paren(s.cond)) if s.cond is not None else E("true", "bool")
        self.line(f"while {c.code}:", s, header=True)
        self.fn.loops.append({"k": "for", "step": s.step})
        try:
            self.emit_body(s.body, (lambda: self.inline(s.step)) if s.step is not None else None)
        finally:
            self.fn.loops.pop()

    def st_repeat(self, s: N) -> None:
        lv = lit_num(s.n)
        if lv is not None and float(lv[0]).is_integer():
            n = str(int(lv[0]))
        else:
            self.todo("repeat计数")
            n = f"int({self.expr(s.n).code})"
        depth = sum(1 for x in self.fn.loops if x["k"] == "repeat")
        v = "_rep" + (str(depth + 1) if depth else "")
        self.line(f"for {v} in range({n}):", s, header=True)
        self.fn.loops.append({"k": "repeat"})
        try:
            self.emit_body(s.body)
        finally:
            self.fn.loops.pop()

    def with_var(self) -> str:
        n = len(self.fn.with_stack)
        base = "inst" if n == 0 else f"inst{n + 1}"
        while base in self.fn.locals or base in self.ivars:
            base = "_" + base
        return base

    def st_with(self, s: N) -> None:
        t = self.expr(strip_paren(s.target))
        if t.kind in ("str", "bool"):
            raise Unsup("with目标")
        iv = self.with_var()
        self.line(f"for {iv} in GM.with_list({t.code}):", s, header=True)
        self.fn.with_stack.append(iv)
        self.fn.loops.append({"k": "with"})
        try:
            self.emit_body(s.body)
        finally:
            self.fn.with_stack.pop()
            self.fn.loops.pop()

    def case_pattern(self, lab: N, subj_kind: str) -> tuple[str, str]:
        lab = strip_paren(lab)
        lv = lit_num(lab)
        if lv is not None:
            node = lab
            neg = False
            if lab.t == "un":
                node, neg = strip_paren(lab.e), True
            code = fmt_num(node, "int" if subj_kind == "int" else "float").code
            return ("-" + code if neg else code), ("int" if subj_kind == "int" or node.hex else "num")
        if lab.t == "str":
            return gdstr(lab.val), "str"
        if lab.t == "name":
            n = lab.name
            if n in ("true", "false"):
                return n, "bool"
            if n in self.p.assets:
                return "A." + n, "int"
            if n in self.p.macros:
                self.scr_used.add(n)
                return "Scr." + n, ("str" if self.p.macros[n].startswith('"') else "num")
            if n in self.p.gm_consts:
                return "GM." + n, gd_kind(self.p.gm_consts[n])
        if lab.t == "mem" and lab.o.t == "name" and lab.o.name in self.p.enums:
            self.scr_used.add(lab.o.name)
            return f"Scr.{lab.o.name}.{lab.name}", "int"
        raise Unsup("switch非常量case")

    def st_switch(self, s: N) -> None:
        subj = self.expr(strip_paren(s.e))
        groups: list[list[Any]] = []
        pending: list[N | None] = []
        for lab, body, _ln in s.cases:
            pending.append(lab)
            if any(b.t != "empty" for b in body):
                groups.append([pending, body])
                pending = []
        if pending:
            groups.append([pending, []])
        prepared: list[tuple[list[N | None], list[N]]] = []
        for gi, (labs, body) in enumerate(groups):
            stmts, term = strip_break(body)
            if stmts and not term and gi != len(groups) - 1:
                raise Unsup("switch贯穿")
            if has_switch_break(stmts):
                raise Unsup("switch内break")
            prepared.append((labs, stmts))
        # default 必须放最后（GDScript 的 _ 会挡住后面的分支）
        prepared.sort(key=lambda g: any(x is None for x in g[0]))
        pats: list[str] = []
        mismatch = False
        for labs, _ in prepared:
            if any(x is None for x in labs):
                pats.append("_")
                continue
            ps = []
            for lab in labs:
                code, k = self.case_pattern(lab, subj.kind)  # type: ignore[arg-type]
                ps.append(code)
                if subj.kind == "unk" and k in ("num", "int"):
                    mismatch = True
                elif subj.kind in ("num", "int", "str") and k != "bool" and \
                        not (subj.kind == k or (subj.kind == "num" and k == "num")):
                    mismatch = True
            pats.append(", ".join(ps))
        if mismatch:
            self.todo("match类型")
        self.line(f"match {subj.code}:", s, header=True)
        self.ind += 1
        self.fn.loops.append({"k": "switch"})
        try:
            for (labs, stmts), pat in zip(prepared, pats):
                self.out(f"{pat}:")
                self.emit_body(stmts)
        finally:
            self.fn.loops.pop()
            self.ind -= 1

    def st_return(self, s: N) -> None:
        if self.fn.mode == "script":
            self.line("return" + (f" {self.expr(s.e).code}" if s.e is not None else ""), s)
            return
        if s.e is not None:
            self.todo("事件返回值")
        self.line("return", s)

    def st_exit(self, s: N) -> None:
        self.line("return", s)

    def loop_top(self, skip_switch: bool) -> dict[str, Any] | None:
        for x in reversed(self.fn.loops):
            if x["k"] == "switch" and skip_switch:
                continue
            return x
        return None

    def st_break(self, s: N) -> None:
        top = self.loop_top(False)
        if top is None:
            raise Unsup("循环外break")
        if top["k"] == "switch":
            raise Unsup("switch内break")
        self.line("break", s)

    def st_continue(self, s: N) -> None:
        top = self.loop_top(True)
        if top is None:
            raise Unsup("循环外continue")
        if top["k"] == "for" and top.get("step") is not None:
            self.inline(top["step"])
        self.line("continue", s)

    def st_macro(self, s: N) -> None:
        self.out(f"# #macro {s.name} {s.value}（全局宏，引用处写 Scr.{s.name}）", code=False)

    def st_enum(self, s: N) -> None:
        if self.fn.mode == "script":
            self.out(f"# enum {s.name}：已提到文件顶部", code=False)
            return
        raise Unsup("enum位置")

    def st_func(self, s: N) -> None:
        raise Unsup("嵌套函数")

    def st_globalvar(self, s: N) -> None:
        raise Unsup("globalvar")

    # ---- 函数 ----
    def emit_function(self, header: str, src_comment: str, stmts: list[N], comments: list[Comment], src: str,
                      method: str, collision: bool, params: list[str], variadic: bool = False,
                      pre_lines: list[str] | None = None, me: str = "me") -> None:
        locals_ = func_locals(stmts)
        ss = ScopeScan(locals_, set(params))
        ss.stmts(stmts, ())
        hoisted = (ss.bad & locals_) - set(params)
        fn = Fn(self.mode, method, collision, locals_, hoisted, set(params), comments, src, variadic)
        fn.me = me
        fn.lkinds = local_kinds(self.p, stmts, locals_)
        self.fn = fn
        self.ind = 0
        self.out(src_comment, code=False)
        self.out(header, code=False)
        self.ind = 1
        self.block_code = [0, 0]
        for pl in pre_lines or []:
            self.out(pl)
        for h in sorted(hoisted):
            self.out(f"var {self.safe_local(h)}  # 局部变量提升（GML 的 var 是函数作用域）")
        for s in stmts:
            self.emit_stmt(s)
        self.flush_comments(float("inf"))
        if self.block_code[-1] == 0:
            self.out("pass")
        self.ind = 0
        self.lines.append("")
        self.lines.append("")

    def emit_commented(self, header: str, src_comment: str, src: str, reason: str) -> None:
        self.ind = 0
        self.out(src_comment, code=False)
        self.out(header, code=False)
        self.ind = 1
        for x in src.replace("\r", "").split("\n"):
            if x.strip():
                self.out("# GML: " + x.rstrip().replace("\t", "    "), code=False)
        self.out(f"pass  # TODO-GML: {reason}")
        self.ind = 0
        self.lines.append("")
        self.lines.append("")


# ======================================================================
# 转换入口
# ======================================================================

def convert_object(proj: Proj, name: str) -> tuple[str, list[str]]:
    """→ (gd 文本, 解析失败清单)。"""
    d = proj.obj(name)
    em = Emitter(proj, "object", name)
    failures: list[str] = []
    em.lines += [
        f"# 草稿：由 tools/gml2gd.py 从 objects/{name}/ 机械转换，未经核对。",
        "# 核对并处理全部 TODO-GML 标记之后才能移入 port/objects/（port-plan §7 的 1b）。",
        f'extends "res://objects/{d.parent}.gd"' if d.parent else "extends GMObject",
        "",
    ]
    decls = proj.decls(name)
    if decls:
        for n, (typ, todo) in decls.items():
            nm = em.safe_member(n)
            if typ == "float":
                text = f"var {nm}: float = 0.0"
            elif typ == "String":
                text = f'var {nm}: String = ""'
            else:
                text = f"var {nm} = null"
            reasons = [todo] if todo else []
            if nm != n:
                reasons.append(f"改名({n})")
            if reasons:
                text += "  # TODO-GML: " + "; ".join(reasons)
            em.lines.append(text)
        em.lines.append("")
    em.lines.append("")
    for ev in d.events:
        coll = ev.ekind == "collision"
        header = f"func {ev.method}({'other: GMObject' if coll else ''}) -> void:"
        srcc = f"# from objects/{name}/{ev.fname}"
        if ev.error is not None:
            failures.append(f"objects/{name}/{ev.fname}: {ev.error}")
            em.emit_commented(header, srcc, ev.src, "解析失败")
            continue
        if ev.ekind == "async":
            em.emit_commented(header, srcc, ev.src, ev.ereason or "异步事件")
            continue
        pre = [f"pass  # TODO-GML: {ev.ereason}"] if ev.ekind == "unknown" else None
        assert ev.ast is not None
        em.emit_function(header, srcc, ev.ast, ev.comments, ev.src, ev.method, coll, [], pre_lines=pre)
    return "\n".join(em.lines).rstrip() + "\n", failures


def convert_script(proj: Proj, sname: str) -> tuple[str, list[str]]:
    src = proj.script_src.get(sname)
    if src is None:
        p = ORIG / "scripts" / sname / f"{sname}.gml"
        src = read_text(p)
    em = Emitter(proj, "script")
    lines = em.lines
    lines += [
        f"# 草稿：由 tools/gml2gd.py 从 scripts/{sname}/{sname}.gml 机械转换，未经核对。",
        "# 占位约定：脚本函数写成 static func，第一个参数 me 是调用者实例；调用处写 Scr.<名>(self, …)。",
        "# 脚本最终如何组织（port-plan §2：按文件夹归到若干 .gd）还没定。",
        "extends RefCounted",
        "",
        "",
    ]
    try:
        ast, comments = parse(src)
    except (ParseError, RecursionError) as e:
        em.emit_commented(f"static func {sname}(me: GMObject, ...argument: Array):",
                          f"# from scripts/{sname}/{sname}.gml", src, "解析失败")
        return "\n".join(lines).rstrip() + "\n", [f"scripts/{sname}/{sname}.gml: {e}"]
    # 顶层：宏、枚举（提到类级）；函数；其余顶层语句放进 _toplevel
    top_other: list[N] = []
    funcs: list[N] = []
    consts: list[str] = []

    def collect(stmts: list[N]) -> None:
        for s in stmts:
            if s.t == "macro":
                consts.append(macro_const(proj, s.name, s.value))
            elif s.t == "enum":
                consts.append(enum_decl(proj, s))
    collect(ast)
    for s in ast:
        if s.t == "func":
            funcs.append(s)
            walk_stmts(s.body.body, lambda x: collect([x]) if x.t in ("macro", "enum") else None)
        elif s.t not in ("macro", "enum", "empty"):
            top_other.append(s)
    if consts:
        lines += consts + ["", ""]
    for f in funcs:
        params = [p for p, _ in f.params]
        uses_var = False

        def chk(x: N) -> None:
            nonlocal uses_var
            for e in stmt_exprs(x):
                def g(y: N) -> None:
                    nonlocal uses_var
                    if y.t == "name" and y.name in ("argument", "argument_count"):
                        uses_var = True
                walk_expr(e, g)
        walk_stmts(f.body.body, chk)
        me = "me" if "me" not in params and "me" not in func_locals(f.body.body) else "_me"
        if not uses_var:
            # GMS2.3 允许函数不声明形参而直接用 argument0…：补成可选形参
            used_n: set[int] = set()

            def chk2(x: N) -> None:
                for e in stmt_exprs(x):
                    def g2(y: N) -> None:
                        if y.t == "name":
                            mm = re.fullmatch(r"argument(\d+)", y.name)
                            if mm:
                                used_n.add(int(mm.group(1)))
                    walk_expr(e, g2)
            walk_stmts(f.body.body, chk2)
            if used_n:
                for k in range(max(used_n) + 1):
                    if f"argument{k}" not in params:
                        f.params.append((f"argument{k}", None))
                params = [p for p, _ in f.params]
        pre: list[str] = []
        if uses_var:
            sig = f"{me}: GMObject, ...argument: Array"
            for i, pn in enumerate(params):
                pre.append(f"var {Emitter.safe_local(pn)} = argument[{i}] if argument.size() > {i} else null")
            fparams = params
        else:
            parts = [f"{me}: GMObject"]
            for pn, dv in f.params:
                dcode = "null"
                if dv is not None:
                    try:
                        em.fn = Fn("script", f.name, False, set(), set(), set(), [], src)
                        dcode = em.expr(dv).code
                    except Unsup:
                        dcode = "null"
                parts.append(f"{Emitter.safe_local(pn)} = {dcode}")
            sig = ", ".join(parts)
            fparams = params
        # 函数注释：取函数体之前的注释
        fcomments = [c for c in comments if f.l0 <= c.line <= f.l1]
        header = f"static func {f.name}({sig}):"
        em.emit_function(header, f"# from scripts/{sname}/{sname}.gml", f.body.body, fcomments, src, f.name,
                         False, fparams, variadic=uses_var, pre_lines=pre, me=me)
    if top_other:
        em.emit_function("static func _toplevel(me: GMObject):", f"# from scripts/{sname}/{sname}.gml（顶层语句）",
                         top_other, [c for c in comments if not any(f.l0 <= c.line <= f.l1 for f in funcs)], src,
                         "_toplevel", False, [], pre_lines=["pass  # TODO-GML: 脚本顶层代码"])
    return "\n".join(lines).rstrip() + "\n", []


def macro_const(proj: Proj, name: str, value: str) -> str:
    try:
        toks_src = value
        p = Parser(toks_src)
        e = p.expr()
        em = Emitter(proj, "script")
        em.fn = Fn("script", "", False, set(), set(), set(), [], value)
        code = em.expr(e).code
        return f"const {name} = {code}"
    except (ParseError, Unsup, IndexError):
        return f"const {name} = null  # TODO-GML: 宏值({value})"


def enum_decl(proj: Proj, s: N) -> str:
    parts = []
    for mn, val in s.members:
        if val is None:
            parts.append(mn)
        else:
            lv = lit_num(val)
            parts.append(f"{mn} = {int(lv[0])}" if lv is not None else f"{mn}  # TODO-GML: 枚举值")
    return f"enum {s.name} {{ " + ", ".join(parts) + " }"


# ======================================================================
# CLI
# ======================================================================

TODO_RE = re.compile(r"# TODO-GML: (.*)$")


def todo_categories(text: str) -> Counter[str]:
    c: Counter[str] = Counter()
    for line in text.splitlines():
        m = TODO_RE.search(line)
        if m:
            for part in m.group(1).split("; "):
                c[part.split("(")[0].strip()] += 1
    return c


def todo_details(text: str, cat: str) -> Counter[str]:
    c: Counter[str] = Counter()
    for line in text.splitlines():
        m = TODO_RE.search(line)
        if m:
            for part in m.group(1).split("; "):
                mm = re.match(re.escape(cat) + r"\((.*)\)$", part.strip())
                if mm:
                    c[mm.group(1)] += 1
    return c


def write_draft(rel: str, text: str) -> Path:
    path = DRAFT / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    gdi = DRAFT / ".gdignore"
    if not gdi.exists():
        gdi.write_text("", encoding="utf-8")
    path.write_text(text, encoding="utf-8", newline="\n")
    return path


def main(argv: list[str]) -> int:
    sys.setrecursionlimit(10000)
    if len(argv) < 2 or argv[1] not in ("object", "script", "stats"):
        print(__doc__)
        return 2
    cmd = argv[1]
    proj = Proj()
    proj.scan_all()
    if cmd == "object":
        names = [a for a in argv[2:] if not a.startswith("--")]
        if "--chain" in argv:
            full: list[str] = []
            for n in names:
                for x in list(reversed(proj.chain(n))) + [n]:
                    if x not in full:
                        full.append(x)
            names = full
        for n in names:
            if n not in proj.obj_table:
                print(f"没有这个 object：{n}")
                return 1
            text, fails = convert_object(proj, n)
            path = write_draft(f"objects/{n}.gd", text)
            nt = sum(1 for x in text.splitlines() if "# TODO-GML:" in x)
            print(f"{path.relative_to(PORT.parent).as_posix()}  {len(text.splitlines())} 行，TODO {nt} 行"
                  + (f"，解析失败 {len(fails)}" if fails else ""))
            for f in fails:
                print("  解析失败：" + f)
        return 0
    if cmd == "script":
        for n in argv[2:]:
            if n not in proj.script_src:
                print(f"没有这个脚本：{n}")
                return 1
            text, fails = convert_script(proj, n)
            path = write_draft(f"scripts/{n}.gd", text)
            nt = sum(1 for x in text.splitlines() if "# TODO-GML:" in x)
            print(f"{path.relative_to(PORT.parent).as_posix()}  {len(text.splitlines())} 行，TODO {nt} 行")
            for f in fails:
                print("  解析失败：" + f)
        return 0
    # stats
    total = 0
    todo_lines = 0
    gml_lines = 0
    cats: Counter[str] = Counter()
    fails: list[str] = []
    crashes: list[str] = []
    missing_funcs: Counter[str] = Counter()
    missing_vars: Counter[str] = Counter()
    texts: list[str] = []
    for n in proj.obj_table:
        try:
            text, f = convert_object(proj, n)
        except Exception as ex:  # 转换器自身的 bug：记下来，不中断统计
            crashes.append(f"objects/{n}: {type(ex).__name__}: {ex}")
            continue
        texts.append(text)
        fails += f
    for n in proj.script_src:
        try:
            text, f = convert_script(proj, n)
        except Exception as ex:
            crashes.append(f"scripts/{n}: {type(ex).__name__}: {ex}")
            continue
        texts.append(text)
        fails += f
    for text in texts:
        ls = text.splitlines()
        total += len(ls)
        todo_lines += sum(1 for x in ls if "# TODO-GML:" in x)
        gml_lines += sum(1 for x in ls if x.lstrip().startswith("# GML: "))
        cats += todo_categories(text)
        missing_funcs += todo_details(text, "兼容层没有函数")
        missing_vars += todo_details(text, "兼容层没有变量")
    print(f"文件：object {len(proj.obj_table)} 个，脚本 {len(proj.script_src)} 个")
    print(f"输出总行数：{total}")
    print(f"带 # TODO-GML: 的行：{todo_lines}（{todo_lines / max(total, 1) * 100:.2f}%）")
    print(f"被整条注释掉的 GML 行（# GML: ）：{gml_lines}")
    print("TODO 类别（前 30）：")
    for k, v in cats.most_common(30):
        print(f"  {v:6d}  {k}")
    print("兼容层没有的函数（前 40）：")
    for k, v in missing_funcs.most_common(40):
        print(f"  {v:6d}  {k}")
    print("兼容层没有的变量/常量（前 20）：")
    for k, v in missing_vars.most_common(20):
        print(f"  {v:6d}  {k}")
    print(f"解析失败：{len(fails)}")
    for f in fails:
        print("  " + f)
    print(f"转换器异常：{len(crashes)}")
    for c in crashes:
        print("  " + c)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
