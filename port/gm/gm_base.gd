extends Node
## 兼容层第 1 层：常量、数据表、数学、字符串、随机数。
## autoload `GM` 的脚本是 gm.gd，它沿 gm_input ← gm_audio ← gm_draw ← gm_base 一路继承，
## 所以这里的东西都以 `GM.xxx` 访问。数学函数的取整、容差细节照 GameMaker HTML5 runner
## （scripts/functions/Function_Maths.js）。

# ---- GML 常量 ----
const noone: int = -4
const all: int = -3
const room_speed: float = 60.0
const EPSILON: float = 0.00001  ## 原版 math_set_epsilon(0.00001)，也是 GMS 默认值

const c_white: int = 0xFFFFFF
const c_black: int = 0x000000
const c_red: int = 0x0000FF
const c_green: int = 0x008000
const c_lime: int = 0x00FF00
const c_blue: int = 0xFF0000
const c_yellow: int = 0x00FFFF
const c_orange: int = 0x40A0FF
const c_aqua: int = 0xFFFF00
const c_fuchsia: int = 0xFF00FF
const c_gray: int = 0x808080
const c_grey: int = 0x808080
const c_dkgray: int = 0x404040
const c_ltgray: int = 0xC0C0C0
const c_silver: int = 0xC0C0C0
const c_maroon: int = 0x000080
const c_navy: int = 0x800000
const c_olive: int = 0x008080
const c_purple: int = 0x800080
const c_teal: int = 0x808000

const fa_left: int = 0
const fa_center: int = 1
const fa_right: int = 2
const fa_top: int = 0
const fa_middle: int = 1
const fa_bottom: int = 2

const mb_any: int = -1
const mb_none: int = 0
const mb_left: int = 1
const mb_right: int = 2
const mb_middle: int = 3

const vk_nokey: int = 0
const vk_anykey: int = 1
const vk_backspace: int = 8
const vk_tab: int = 9
const vk_enter: int = 13
const vk_return: int = 13
const vk_shift: int = 16
const vk_control: int = 17
const vk_alt: int = 18
const vk_pause: int = 19
const vk_escape: int = 27
const vk_space: int = 32
const vk_pageup: int = 33
const vk_pagedown: int = 34
const vk_end: int = 35
const vk_home: int = 36
const vk_left: int = 37
const vk_up: int = 38
const vk_right: int = 39
const vk_down: int = 40
const vk_printscreen: int = 44
const vk_insert: int = 45
const vk_delete: int = 46
const vk_numpad0: int = 96
const vk_multiply: int = 106
const vk_add: int = 107
const vk_subtract: int = 109
const vk_decimal: int = 110
const vk_divide: int = 111
const vk_f1: int = 112
const vk_f2: int = 113
const vk_f3: int = 114
const vk_f4: int = 115
const vk_f5: int = 116
const vk_f6: int = 117
const vk_f7: int = 118
const vk_f8: int = 119
const vk_f9: int = 120
const vk_f10: int = 121
const vk_f11: int = 122
const vk_f12: int = 123
const vk_lshift: int = 160
const vk_rshift: int = 161
const vk_lcontrol: int = 162
const vk_rcontrol: int = 163
const vk_lalt: int = 164
const vk_ralt: int = 165

const USER_EVENT_NAMES: Array[StringName] = [
	&"_user_0", &"_user_1", &"_user_2", &"_user_3", &"_user_4", &"_user_5", &"_user_6", &"_user_7",
	&"_user_8", &"_user_9", &"_user_10", &"_user_11", &"_user_12", &"_user_13", &"_user_14", &"_user_15",
]
const ALARM_NAMES: Array[StringName] = [
	&"_alarm_0", &"_alarm_1", &"_alarm_2", &"_alarm_3", &"_alarm_4", &"_alarm_5",
	&"_alarm_6", &"_alarm_7", &"_alarm_8", &"_alarm_9", &"_alarm_10", &"_alarm_11",
]

# ---- 数据表（tables/runtime.json、masks.bin） ----
var sprites: Array[GMSprite] = []
var sprite_name_to_id: Dictionary = {}
var classes: Array[GMClass] = []
var obj_name_to_id: Dictionary = {}
var sound_defs: Array = []  ## [[name, file, volume], …]
var sound_name_to_id: Dictionary = {}
var room_defs: Array = []  ## 每个 room 一个 Dictionary
var room_name_to_id: Dictionary = {}

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _load_tables() -> void:
	var f: FileAccess = FileAccess.open("res://tables/runtime.json", FileAccess.READ)
	if f == null:
		push_error("GM: 读不到 res://tables/runtime.json，先运行 tools/run_all.py")
		return
	var data: Dictionary = JSON.parse_string(f.get_as_text())
	f.close()
	var mask_index: Dictionary = {}
	var mask_blob: PackedByteArray = PackedByteArray()
	var mf: FileAccess = FileAccess.open("res://tables/masks.json", FileAccess.READ)
	if mf != null:
		mask_index = (JSON.parse_string(mf.get_as_text()) as Dictionary)["sprites"]
		mf.close()
		mask_blob = FileAccess.get_file_as_bytes("res://tables/masks.bin")
	else:
		push_error("GM: 读不到 res://tables/masks.json，先运行 tools/run_all.py")

	var rows: Array = data["sprites"]
	sprites.resize(rows.size())
	for i: int in rows.size():
		var r: Array = rows[i]
		var s: GMSprite = GMSprite.new()
		s.index = i
		s.name = r[0]
		s.frames = int(r[1])
		s.width = int(r[2])
		s.height = int(r[3])
		s.xo = float(r[4])
		s.yo = float(r[5])
		s.bl = int(r[6])
		s.bt = int(r[7])
		s.br = int(r[8])
		s.bb = int(r[9])
		s.kind = int(r[10])
		# playbackSpeedType：0 = 每秒帧数，1 = 每游戏帧的帧数
		s.tick_speed = float(r[11]) if int(r[12]) == 1 else float(r[11]) / room_speed
		if s.kind == 1:
			s.colcheck = GMSprite.COL_AABB
		elif s.kind == 5:
			s.colcheck = GMSprite.COL_ROTRECT
		else:
			s.colcheck = GMSprite.COL_PRECISE
			var mi: Variant = mask_index.get(str(i))
			if mi != null and int(mi[1]) >= 0:
				var cnt: int = int(mi[0])
				var off: int = int(mi[1])
				var sz: int = int(mi[2])
				s.mask_stride = (s.br - s.bl + 1 + 7) >> 3
				for k: int in cnt:
					s.masks.append(mask_blob.slice(off + k * sz, off + (k + 1) * sz))
		var ex: float = maxf(s.xo, float(s.width) - s.xo)
		var ey: float = maxf(s.yo, float(s.height) - s.yo)
		s.cull_r = sqrt(ex * ex + ey * ey) + 1.0
		sprites[i] = s
		sprite_name_to_id[s.name] = i

	var orows: Array = data["objects"]
	classes.resize(orows.size())
	for i: int in orows.size():
		var r: Array = orows[i]
		var c: GMClass = GMClass.new()
		c.id = i
		c.name = r[0]
		c.parent_id = int(r[1])
		c.sprite = int(r[2])
		c.mask = int(r[3])
		c.visible = int(r[4]) != 0
		c.persistent = int(r[5]) != 0
		c.depth = float(r[6])
		classes[i] = c
		obj_name_to_id[c.name] = i
	_rebuild_class_ancestry()

	sound_defs = data["sounds"]
	for i: int in sound_defs.size():
		sound_name_to_id[sound_defs[i][0]] = i
	room_defs = data["rooms"]
	for i: int in room_defs.size():
		room_name_to_id[room_defs[i]["name"]] = i


func _rebuild_class_ancestry() -> void:
	var n: int = classes.size()
	for c: GMClass in classes:
		c.is_a = PackedByteArray()
		c.is_a.resize(n)
		var p: int = c.id
		while p >= 0:
			c.is_a[p] = 1
			p = classes[p].parent_id


# ======================================================================
# 数学
# ======================================================================

## GML 的 round：四舍六入五成双
func gm_round(a: float) -> float:
	var i: float = floorf(absf(a)) * (1.0 if a >= 0.0 else -1.0)
	var f: float = a - i
	var odd: bool = fmod(absf(i), 2.0) == 1.0
	if a >= 0.0:
		if odd:
			return i + 1.0 if f >= 0.5 else i
		return i if f <= 0.5 else i + 1.0
	if odd:
		return i - 1.0 if f <= -0.5 else i
	return i if f >= -0.5 else i - 1.0


func gm_sign(v: float) -> float:
	if v == 0.0:
		return 0.0
	return -1.0 if v < 0.0 else 1.0


func frac(v: float) -> float:
	return v - float(int(v))


## GML 的 div（向零取整的整除）
func gm_div(a: float, b: float) -> float:
	return float(int(a / b))


## GML 的 mod（结果符号跟被除数）
func gm_mod(a: float, b: float) -> float:
	return fmod(a, b)


## GML 实数的 ==（带容差）。只在原版依赖容差的地方用。
func eq(a: float, b: float) -> bool:
	return absf(a - b) <= EPSILON


func lengthdir_x(len: float, dir: float) -> float:
	var v: float = len * cos(dir * PI / 180.0)
	var n: float = floorf(v + 0.5)
	return n if absf(v - n) < 0.0001 else v


func lengthdir_y(len: float, dir: float) -> float:
	var v: float = -(len * sin(dir * PI / 180.0))
	var n: float = floorf(v + 0.5)
	return n if absf(v - n) < 0.0001 else v


func point_direction(x1: float, y1: float, x2: float, y2: float) -> float:
	var dx: float = x2 - x1
	var dy: float = y2 - y1
	if dx == 0.0:
		if dy > 0.0:
			return 270.0
		return 90.0 if dy < 0.0 else 0.0
	var dd: float = 180.0 * atan2(dy, dx) / PI
	dd = float(int(gm_round(dd * 1000000.0))) / 1000000.0
	return -dd if dd <= 0.0 else 360.0 - dd


func point_distance(x1: float, y1: float, x2: float, y2: float) -> float:
	return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))


func angle_difference(src: float, dest: float) -> float:
	return fmod(fmod(src - dest, 360.0) + 540.0, 360.0) - 180.0


func point_in_rectangle(px: float, py: float, x1: float, y1: float, x2: float, y2: float) -> bool:
	return px >= x1 and px <= x2 and py >= y1 and py <= y2


func point_in_circle(px: float, py: float, cx: float, cy: float, rad: float) -> bool:
	return (px - cx) * (px - cx) + (py - cy) * (py - cy) <= rad * rad


func median(...args: Array) -> float:
	if args.is_empty():
		return 0.0
	var a: Array = args.duplicate()
	a.sort()
	return float(a[a.size() / 2])


# ---- 随机数。原版在 obj_persistent 的 Create 里调了 randomise()，所以数列每次启动都不同；
# ---- 这里不追求与 GMS 的数列一致。
func randomise() -> void:
	_rng.randomize()


func random_set_seed(seed_value: int) -> void:
	_rng.seed = seed_value


func random(v: float) -> float:
	return _rng.randf() * v


func random_range(a: float, b: float) -> float:
	if a == b:
		return a
	return minf(a, b) + _rng.randf() * absf(b - a)


func irandom(v: float) -> float:
	var n: int = int(v)
	var s: int = -1 if n < 0 else 1
	return float(int(_rng.randf() * float(n + s)))


func irandom_range(a: float, b: float) -> float:
	var lo: int = int(minf(a, b))
	var hi: int = int(maxf(a, b))
	return float(lo + int(random(float(hi - lo + 1))))


func choose(...args: Array) -> Variant:
	if args.is_empty():
		return 0
	return args[int(floorf(random(float(args.size()))))]


# ======================================================================
# 字符串（GML 的下标从 1 开始）
# ======================================================================

## GML 的 string()：整数值不带小数，其余保留两位小数
func string(v: Variant) -> String:
	if v is String:
		return v
	if v is StringName:
		return String(v)
	if v is bool:
		return "1" if v else "0"
	if v is int:
		return str(v)
	if v is float:
		var fv: float = v
		if fv == floorf(fv) and absf(fv) < 9.0e15:
			return str(int(fv))
		return "%.2f" % fv
	if v == null:
		return "undefined"
	return str(v)


func real(v: Variant) -> float:
	if v is String:
		return (v as String).to_float()
	return float(v)


func string_length(s: String) -> float:
	return float(s.length())


func string_byte_length(s: String) -> float:
	return float(s.to_utf8_buffer().size())


func string_copy(s: String, index: float, count: float) -> String:
	var i: int = maxi(int(index) - 1, 0)
	return s.substr(i, maxi(int(count), 0))


func string_char_at(s: String, index: float) -> String:
	var i: int = int(index) - 1
	if s.is_empty():
		return ""
	# GML：下标 <= 1 返回首字符，越界返回空串
	if i < 0:
		i = 0
	return s[i] if i < s.length() else ""


func string_pos(substr: String, s: String) -> float:
	return float(s.find(substr) + 1)


func string_count(substr: String, s: String) -> float:
	if substr.is_empty():
		return 0.0
	return float(s.count(substr))


func string_replace_all(s: String, substr: String, newstr: String) -> String:
	if substr.is_empty():
		return s
	return s.replace(substr, newstr)


func string_insert(substr: String, s: String, index: float) -> String:
	var i: int = clampi(int(index) - 1, 0, s.length())
	return s.substr(0, i) + substr + s.substr(i)


func string_delete(s: String, index: float, count: float) -> String:
	var i: int = int(index) - 1
	if i < 0 or count <= 0.0:
		return s
	return s.substr(0, i) + s.substr(i + int(count))


func string_repeat(s: String, count: float) -> String:
	return s.repeat(maxi(int(count), 0))


func string_format(val: float, total: float, dec: float) -> String:
	var t: String = ("%." + str(int(dec)) + "f") % val
	return t.lpad(int(total) + (int(dec) + 1 if dec > 0.0 else 0), " ")


## GMS1 兼容函数：把 # 换成换行，\# 换成 #
func string_hash_to_newline(v: Variant) -> String:
	var s: String = string(v)
	var out: String = ""
	var i: int = 0
	var n: int = s.length()
	while i < n:
		var ch: String = s[i]
		if ch == "\\" and i + 1 < n and s[i + 1] == "#":
			out += "#"
			i += 2
			continue
		out += "\n" if ch == "#" else ch
		i += 1
	return out


func ord(s: String) -> float:
	return float(s.unicode_at(0)) if not s.is_empty() else 0.0


func chr(v: float) -> String:
	return String.chr(int(v))


func make_colour_rgb(r: float, g: float, b: float) -> int:
	return (int(r) & 255) | ((int(g) & 255) << 8) | ((int(b) & 255) << 16)


func make_color_rgb(r: float, g: float, b: float) -> int:
	return make_colour_rgb(r, g, b)


## GML 颜色（0xBBGGRR）→ Godot Color
func gm_color(col: int, alpha: float = 1.0) -> Color:
	return Color(float(col & 255) / 255.0, float((col >> 8) & 255) / 255.0, float((col >> 16) & 255) / 255.0, alpha)
