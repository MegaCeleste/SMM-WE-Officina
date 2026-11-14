extends "res://gm/gm_layer.gd"
## 兼容层第 2c 层（第 2 批）：系统、日期、窗口/显示、application_surface、动态 sprite、
## shader 占位、杂项内置函数。
##
## application_surface：世界层画进一个 SubViewport（见 gm_draw._init_draw），它的纹理就是
## application_surface。原版调了 application_surface_draw_enable(false)，由 obj_persistent 的
## Draw GUI 自己把它画到屏幕上（draw_surface_stretched），这里照此实现，所以 port_y（屏幕震动）
## 和以后的冲击波 shader 都能按原样工作。

# ---- 系统 ----
## 数值没有核对过 GMS 的定义；原版只拿 os_type 和它们比较，不依赖具体数值。
const os_windows: int = 0
const os_android: int = 4
const os_type: int = os_windows
const os_permission_denied: int = 0
const os_permission_granted: int = 1

const tm_sleep: int = 0
const tm_countvsyncs: int = 1

## GMS 的 working_directory。原版拼的是 Windows 路径（"Niveles\\"），文件读写在第 3/9 批定，
## 这里先给 user://。
var working_directory: String = "user://"

# ---- GML 内置的全局游戏变量 ----
var score: float = 0.0
var lives: float = -1.0
var health: float = 100.0

# ---- 日期（墙上时钟，原版只在 intro 里用来选星期） ----
var current_year: float:
	get:
		return float(Time.get_datetime_dict_from_system()["year"])
var current_month: float:
	get:
		return float(Time.get_datetime_dict_from_system()["month"])
var current_day: float:
	get:
		return float(Time.get_datetime_dict_from_system()["day"])
## 0 = 星期日，与 GMS 相同
var current_weekday: float:
	get:
		if weekday_override >= 0:
			return float(weekday_override)
		return float(Time.get_datetime_dict_from_system()["weekday"])
var current_hour: float:
	get:
		return float(Time.get_datetime_dict_from_system()["hour"])
var current_minute: float:
	get:
		return float(Time.get_datetime_dict_from_system()["minute"])
var current_second: float:
	get:
		return float(Time.get_datetime_dict_from_system()["second"])

## 测试用：>= 0 时 current_weekday 返回这个值，不读系统时间
var weekday_override: int = -1

# ---- 显示 ----
var _timing_method: int = tm_countvsyncs
var _sleep_margin: float = 10.0
var _app_surface_draw: bool = true
var _blend_enable: bool = true

const application_surface: int = -100  ## 一个固定的 surface 编号，不会和动态 surface 撞

var _dyn_sprite_count: int = 0


func _headless() -> bool:
	return DisplayServer.get_name() == "headless"


func gml_release_mode(_enable: Variant) -> void:
	pass


func math_set_epsilon(e: float) -> void:
	if not is_equal_approx(e, EPSILON):
		push_warning("GM.math_set_epsilon(%s)：兼容层的 GM.eq 固定用 %s" % [e, EPSILON])


func url_open(url: String) -> void:
	if not _headless():
		OS.shell_open(url)


func os_get_language() -> String:
	return OS.get_locale_language()


func array_length_1d(a: Variant) -> float:
	return float((a as Array).size()) if a is Array else 0.0


func array_length(a: Variant) -> float:
	return array_length_1d(a)


## GML 数组写入：越界时自动扩展（中间填 0）。GDScript 的数组不会自动扩展，所以
## 翻译时 `a[i] = v` 在可能越界的地方写成 `GM.aset(a, i, v)`（port-plan §3.3 第 11 条）。
func aset(a: Array, i: float, v: Variant) -> void:
	var k: int = int(i)
	if k >= a.size():
		var old: int = a.size()
		a.resize(k + 1)
		for j: int in range(old, k):
			a[j] = 0.0
	a[k] = v


# ======================================================================
# 窗口与显示
# ======================================================================

func window_set_size(w: float, h: float) -> void:
	if _headless():
		return
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		return
	DisplayServer.window_set_size(Vector2i(int(w), int(h)))


## Prefer a larger native-pixel window while staying within the usable desktop.
## The original requested size remains the minimum on sufficiently large screens.
func window_set_game_size(w: float, h: float) -> void:
	if _headless() or w <= 0.0 or h <= 0.0:
		return
	var screen: int = DisplayServer.window_get_current_screen()
	var usable: Vector2i = DisplayServer.screen_get_usable_rect(screen).size
	var scale: float = minf(2.0, minf(float(usable.x) * 0.95 / w, float(usable.y) * 0.95 / h))
	window_set_size(w * scale, h * scale)


func window_get_width() -> float:
	return float(DisplayServer.window_get_size().x)


func window_get_height() -> float:
	return float(DisplayServer.window_get_size().y)


func window_center() -> void:
	if _headless() or DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		return
	var scr: int = DisplayServer.window_get_current_screen()
	var area: Rect2i = DisplayServer.screen_get_usable_rect(scr)
	var sz: Vector2i = DisplayServer.window_get_size()
	DisplayServer.window_set_position(area.position + (area.size - sz) / 2)


func display_reset(_aa: float, _vsync: Variant) -> void:
	pass


func display_get_width() -> float:
	return float(DisplayServer.screen_get_size().x)


func display_get_height() -> float:
	return float(DisplayServer.screen_get_size().y)


func display_set_gui_size(w: float, h: float) -> void:
	_gui_w = w
	_gui_h = h


func display_get_gui_width() -> float:
	return _gui_w


func display_get_gui_height() -> float:
	return _gui_h


## tm_countvsyncs 打开垂直同步，tm_sleep 关闭。游戏逻辑的节拍由 physics tick 决定，与此无关。
func display_set_timing_method(m: float) -> void:
	_timing_method = int(m)
	if _headless():
		return
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if _timing_method == tm_countvsyncs else DisplayServer.VSYNC_DISABLED)


func display_get_timing_method() -> int:
	return _timing_method


func display_set_sleep_margin(v: float) -> void:
	_sleep_margin = v


func display_get_sleep_margin() -> float:
	return _sleep_margin


# ======================================================================
# application_surface 与 surface
# ======================================================================

func _app_surface_draw_on() -> bool:
	return _app_surface_draw


func application_surface_draw_enable(on: Variant) -> void:
	_app_surface_draw = truthy(on)
	_update_app_surface_quad()


func surface_resize(surf: float, w: float, h: float) -> void:
	if int(surf) != application_surface:
		push_warning("GM.surface_resize：只支持 application_surface")
		return
	_set_app_surface_size(w, h)


func surface_get_width(surf: float) -> float:
	return _app_w if int(surf) == application_surface else 0.0


func surface_get_height(surf: float) -> float:
	return _app_h if int(surf) == application_surface else 0.0


func surface_exists(surf: float) -> bool:
	return int(surf) == application_surface


func draw_surface_stretched(surf: float, px: float, py: float, w: float, h: float) -> void:
	draw_surface_stretched_ext(surf, px, py, w, h, c_white, _draw_alpha)


func draw_surface_stretched_ext(surf: float, px: float, py: float, w: float, h: float, col: int, alpha: float) -> void:
	if int(surf) != application_surface:
		push_warning("GM.draw_surface_stretched：只支持 application_surface")
		return
	if _ci == _ci_world or _ci_root == _ci_world:
		return  # 把 application_surface 画进它自己：GMS 也不允许
	_reset_xf()
	RenderingServer.canvas_item_add_texture_rect(_ci, Rect2(px, py, w, h), _app_vp.get_texture().get_rid(), false, gm_color(col, alpha))


func draw_surface(surf: float, px: float, py: float) -> void:
	draw_surface_stretched(surf, px, py, surface_get_width(surf), surface_get_height(surf))


## GMS 关掉混合时源像素直接覆盖目标。原版只在画不透明的截图和 application_surface 时关，
## 结果与开着混合一样，所以这里只记状态。
func gpu_set_blendenable(on: Variant) -> void:
	_blend_enable = truthy(on)


func gpu_get_blendenable() -> bool:
	return _blend_enable


# ---- 混合模式（第 7 批）。GMS 的编号：bm_normal 0、bm_add 1、bm_max 2、bm_subtract 3 ----
const bm_normal: int = 0
const bm_add: int = 1
const bm_max: int = 2
const bm_subtract: int = 3
var _blend_mode: int = bm_normal
var _mat_blend: Dictionary = {}  ## 模式 → CanvasItemMaterial


## 换混合模式就开一个新的绘制分段（同 shader_set）。bm_add = (src_alpha, one)，与 Godot 的
## BLEND_MODE_ADD 相同。bm_subtract 在 GMS 里是 (zero, inv_src_colour)，Godot 没有对应的固定
## 混合方式，暂用 BLEND_MODE_SUB 近似；bm_max 暂按 bm_add 处理（本批只有 obj_blend_ring 用 bm_add）。
## 混合模式不是 normal 时，shader_set 的材质被覆盖（原版没有两者同时用的地方）。
func gpu_set_blendmode(mode: float) -> void:
	var m: int = int(mode)
	if m == _blend_mode:
		return
	_blend_mode = m
	_new_segment(_current_material())


func gpu_get_blendmode() -> int:
	return _blend_mode


func _current_material() -> RID:
	if _blend_mode != bm_normal:
		if not _mat_blend.has(_blend_mode):
			var cm: CanvasItemMaterial = CanvasItemMaterial.new()
			cm.blend_mode = CanvasItemMaterial.BLEND_MODE_SUB if _blend_mode == bm_subtract else CanvasItemMaterial.BLEND_MODE_ADD
			_mat_blend[_blend_mode] = cm
		return (_mat_blend[_blend_mode] as CanvasItemMaterial).get_rid()
	if _shader_on and _mat_blendreplace != null:
		return _mat_blendreplace.get_rid()
	return RID()


# ======================================================================
# 动态 sprite（截图）
# ======================================================================

## 只支持从 application_surface 截取。截的是上一次渲染出的那一帧（GMS 的 application_surface
## 里也是上一帧的画面）。headless 下没有画面，得到一张全黑的图。
func sprite_create_from_surface(surf: float, px: float, py: float, w: float, h: float, _removeback: Variant, _smooth: Variant, xo: float, yo: float) -> int:
	if int(surf) != application_surface:
		push_warning("GM.sprite_create_from_surface：只支持 application_surface")
		return -1
	var iw: int = maxi(int(w), 1)
	var ih: int = maxi(int(h), 1)
	var img: Image = null
	if not _headless():
		img = _app_vp.get_texture().get_image()
	if img == null or img.is_empty():
		img = Image.create_empty(int(_app_w), int(_app_h), false, Image.FORMAT_RGBA8)
		img.fill(Color.BLACK)
	if img.get_width() != int(_app_w) or img.get_height() != int(_app_h):
		img.resize(int(_app_w), int(_app_h), Image.INTERPOLATE_NEAREST)
	var out: Image = Image.create_empty(iw, ih, false, img.get_format())
	out.blit_rect(img, Rect2i(int(px), int(py), iw, ih), Vector2i.ZERO)
	return _add_dynamic_sprite(out, xo, yo)


func _add_dynamic_sprite(img: Image, xo: float, yo: float) -> int:
	var s: GMSprite = GMSprite.new()
	s.index = sprites.size()
	_dyn_sprite_count += 1
	s.name = "__dynamic_%d" % _dyn_sprite_count
	s.frames = 1
	s.width = img.get_width()
	s.height = img.get_height()
	s.xo = xo
	s.yo = yo
	s.bl = 0
	s.bt = 0
	s.br = s.width - 1
	s.bb = s.height - 1
	s.kind = 1
	s.colcheck = GMSprite.COL_AABB
	s.tick_speed = 1.0
	s.set_texture(ImageTexture.create_from_image(img))
	var ex: float = maxf(s.xo, float(s.width) - s.xo)
	var ey: float = maxf(s.yo, float(s.height) - s.yo)
	s.cull_r = sqrt(ex * ex + ey * ey) + 1.0
	sprites.append(s)
	return s.index


## 只能删动态创建的 sprite（GMS 也一样）。删掉后编号不复用，sprite_exists 返回假。
func sprite_delete(spr: float) -> void:
	var i: int = int(spr)
	if i < 0 or i >= sprites.size() or sprites[i] == null:
		return
	if not sprites[i].name.begins_with("__dynamic_"):
		push_warning("GM.sprite_delete：%s 不是动态 sprite" % sprites[i].name)
		return
	sprites[i] = null


# ======================================================================
# shader
# sha_blendreplace（第 4 批）：rgb 换成顶点色，alpha = 顶点 alpha × 贴图 alpha。
# 其余两个 shader 第 11 批实现，现在是空操作。
#
# 绘制命令都写进同一个 canvas item，而材质只能整个 canvas item 设一个，所以
# shader_set / shader_reset 各开一个新的“段”（当前绘制目标的子 canvas item，按
# draw_index 排在后面），之后的命令写进新段，先后顺序不变。
# ======================================================================

const _BLENDREPLACE_CODE: String = "shader_type canvas_item;
varying vec4 v_col;
void vertex() {
	v_col = COLOR;
}
void fragment() {
	COLOR = vec4(v_col.rgb, v_col.a * texture(TEXTURE, UV).a);
}
"

var _seg_pool: Array[RID] = []
var _seg_used: int = 0
var _ci_root: RID = RID()
var _shader_on: bool = false
var _mat_blendreplace: ShaderMaterial = null
var _world_draw_order: int = 0


func _begin_world_draw() -> void:
	super._begin_world_draw()
	for i: int in range(_seg_used):
		RenderingServer.canvas_item_clear(_seg_pool[i])
	_seg_used = 0
	_world_draw_order = 0
	_ci_root = _ci_world
	_shader_on = false
	if _ordered_world or _blend_mode != bm_normal:
		_new_segment(_current_material())


func _begin_gui_draw() -> void:
	super._begin_gui_draw()
	_ci_root = _ci_gui
	_shader_on = false
	if _blend_mode != bm_normal:
		_new_segment(_current_material())


func _exit_tree() -> void:
	for seg: RID in _seg_pool:
		RenderingServer.free_rid(seg)
	_seg_pool.clear()
	super._exit_tree()


func _new_segment(material: RID) -> void:
	if not _ci_root.is_valid():
		return
	if _seg_used == _seg_pool.size():
		_seg_pool.append(RenderingServer.canvas_item_create())
	var seg: RID = _seg_pool[_seg_used]
	_seg_used += 1
	RenderingServer.canvas_item_set_parent(seg, _ci_root)
	RenderingServer.canvas_item_set_draw_index(seg, _next_world_draw_order() if _ordered_world and _ci_root == _ci_world else _seg_used)
	RenderingServer.canvas_item_set_material(seg, material)
	_ci = seg
	_xf_set = false


func _next_world_draw_order() -> int:
	_world_draw_order += 1
	return _world_draw_order


func shader_get_uniform(_sh: float, _uniform: String) -> int:
	return -1


func shader_set(sh: float) -> void:
	if int(sh) != A.sha_blendreplace:
		return
	if _mat_blendreplace == null:
		var shd: Shader = Shader.new()
		shd.code = _BLENDREPLACE_CODE
		_mat_blendreplace = ShaderMaterial.new()
		_mat_blendreplace.shader = shd
	_shader_on = true
	_new_segment(_current_material())


func shader_reset() -> void:
	if _shader_on:
		_shader_on = false
		_new_segment(_current_material())


func shader_set_uniform_f(_handle: float, ...values: Array) -> void:
	pass


func shader_is_compiled(_sh: float) -> bool:
	return false


# ======================================================================
# 虚拟按键（触屏用；原版只在开了触屏控制时调用，第 9 批再看）
# ======================================================================

var _next_vkey: int = 1


func virtual_key_add(_px: float, _py: float, _w: float, _h: float, _key: float) -> int:
	_next_vkey += 1
	return _next_vkey - 1


func virtual_key_delete(_id: Variant) -> void:
	pass


# ======================================================================
# 文件与关卡读取（第 3 批）
# ======================================================================

## GML 路径 → Godot 路径：反斜杠换成斜杠；相对路径放到 working_directory 下
func _fix_path(p: String) -> String:
	var s: String = p.replace("\\", "/")
	if not (s.begins_with("user://") or s.begins_with("res://") or s.is_absolute_path()):
		s = working_directory + s
	return s


func file_exists(p: String) -> bool:
	return FileAccess.file_exists(_fix_path(p))


func directory_exists(p: String) -> bool:
	return DirAccess.dir_exists_absolute(_fix_path(p).trim_suffix("/"))


func directory_create(p: String) -> void:
	DirAccess.make_dir_recursive_absolute(_fix_path(p).trim_suffix("/"))


# 第 9 批：保存脚本使用的固定字节缓冲区。只使用 alignment=1、u8/text/string。
const buffer_fixed: int = 0
const buffer_u8: int = 1
const buffer_string: int = 11
const buffer_text: int = 13
const buffer_seek_start: int = 0
var _buffers: Dictionary = {}
var _buffer_next: int = 1


func buffer_create(size_bytes: float, _kind: float, _alignment: float) -> int:
	var bytes: PackedByteArray = []
	bytes.resize(int(size_bytes))
	bytes.fill(0)
	var handle: int = _buffer_next
	_buffer_next += 1
	_buffers[handle] = {"bytes": bytes, "pos": 0}
	return handle


func buffer_delete(handle: float) -> void:
	_buffers.erase(int(handle))


func buffer_seek(handle: float, _base: float, offset: float) -> void:
	_buffers[int(handle)]["pos"] = int(offset)


func buffer_peek(handle: float, offset: float, _kind: float) -> float:
	return float(_buffers[int(handle)]["bytes"][int(offset)])


func buffer_poke(handle: float, offset: float, _kind: float, value: float) -> void:
	var bytes: PackedByteArray = _buffers[int(handle)]["bytes"]
	bytes[int(offset)] = int(value) & 255
	_buffers[int(handle)]["bytes"] = bytes


func buffer_write(handle: float, kind: float, value: Variant) -> void:
	var b: Dictionary = _buffers[int(handle)]
	var bytes: PackedByteArray = b["bytes"]
	var pos: int = b["pos"]
	if int(kind) == buffer_u8:
		bytes[pos] = int(value) & 255
		pos += 1
	else:
		var text_bytes: PackedByteArray = str(value).to_utf8_buffer()
		if int(kind) == buffer_string:
			text_bytes.append(0)
		for byte: int in text_bytes:
			bytes[pos] = byte
			pos += 1
	b["bytes"] = bytes
	b["pos"] = pos


func buffer_save(handle: float, filename: String) -> void:
	var file: FileAccess = FileAccess.open(_fix_path(filename), FileAccess.WRITE)
	if file != null:
		file.store_buffer(_buffers[int(handle)]["bytes"])
	else:
		push_error("GM.buffer_save: %s (%s)" % [filename, FileAccess.get_open_error()])


func buffer_sha1(handle: float, offset: float, size_bytes: float) -> String:
	var ctx: HashingContext = HashingContext.new()
	ctx.start(HashingContext.HASH_SHA1)
	var bytes: PackedByteArray = _buffers[int(handle)]["bytes"]
	ctx.update(bytes.slice(int(offset), int(offset + size_bytes)))
	return ctx.finish().hex_encode()


func sha1_string_utf8(value: String) -> String:
	return value.sha1_text()


func base64_encode(value: String) -> String:
	return Marshalls.utf8_to_base64(value)


func json_encode(value: Variant) -> String:
	# full_precision 保留 GML 双精度 JSON 的有效数字；整数值不带小数点。
	return JSON.stringify(value, "", false, true)


func file_delete(filename: String) -> bool:
	return DirAccess.remove_absolute(_fix_path(filename)) == OK


var _view_surface_ids: Dictionary = {}


func view_set_surface_id(view: int, surface: int) -> void:
	_view_surface_ids[view] = surface


func view_get_surface_id(view: int) -> int:
	return int(_view_surface_ids.get(view, -1))


## 3.5.1 的关卡文件把键名缩短了（样本 docs/samples/3.5.1level1.swe），源码读的是旧键名。
## 下面的对照表是按名字和各段的先后顺序推断的（docs/level-format.md 附录），读入时翻回旧键名；
## 表里没有的键原样保留（源码不读它们）。 UNVERIFIED：没有 3.5.1 的源码可对。
const SWE_SECTIONS: Dictionary = {
	"S1": "AJUSTES", "S2": "SUELO", "S3": "DECORACION", "S4": "NIVEL",
	"S5": "TUBERIAS", "S6": "CANNON", "S7": "PLATAFORMAS", "S8": "PUERTAS",
}
const SWE_KEYS_COMMON: Dictionary = {"xx": "x_pos", "yy": "y_pos", "ID": "object", "i": "index", "spr": "sprite"}
const SWE_KEYS: Dictionary = {
	"AJUSTES": {
		"label_1": "etiqueta1", "label_2": "etiqueta2", "gamestyle": "apariencia", "gametheme": "entorno",
		"timer": "cronometro", "autoscroll": "autoavance", "nightmode": "modo_noche", "start_y": "ground2",
		"goal_x": "ground3_x", "goal_y": "ground3_y", "wl": "water_level", "wl_limit": "water_level_limit",
		"wl_speed": "water_level_speed", "conditions": "condiciones", "t_conditions": "condiciones_type",
		"o_conditions": "condiciones_object", "c_conditions": "condiciones_count", "mtrs": "meteorites",
		"desc": "description",
	},
	"NIVEL": {
		"progress": "progresivo", "rot": "rotacion", "dir": "direct_t", "parachute": "paracaidas",
		"w_mode": "modo_water", "scl": "s_scaley",
	},
	"TUBERIAS": {
		"sz": "size", "rot": "rotacion", "dir": "direct_t", "sclx": "scalex", "clr": "color", "msk": "mask",
		"xscl": "xscale", "yscl": "yscale", "wrp": "warp", "t_sz": "t_size", "t_rot": "t_rotacion",
		"t_dir": "t_direct_t", "t_s_sclx": "t_s_scalex", "t_clr": "t_color", "t_xscl": "t_xscale",
		"t_yscl": "t_yscale",
	},
	"PLATAFORMAS": {"clr": "color", "dph": "depth", "wth": "width", "hht": "height", "dir": "direct_t"},
	"PUERTAS": {"dr_x": "door_x", "dr_y": "door_y"},
}


## scripts/LoadJSONFromFile 的实现：文件 = base64(JSON) + 40 位 HMAC-SHA1（小写十六进制，
## 密钥 global.drez，输入是 base64 串）+ 结尾 \0。校验不过或文件不存在返回 0.0（原版返回 0）。
## 最近一次 swe_load_json 读到的是不是 3.5.1 的缩写键名格式
var swe_last_was_351: bool = false


func swe_load_json(p: String, key: String) -> Variant:
	swe_last_was_351 = false
	var path: String = _fix_path(p)
	if not FileAccess.file_exists(path):
		return 0.0
	var raw: PackedByteArray = FileAccess.get_file_as_bytes(path)
	while not raw.is_empty() and raw[raw.size() - 1] == 0:
		raw.resize(raw.size() - 1)
	var s: String = raw.get_string_from_utf8()
	if s.length() <= 40:
		return 0.0
	var b64: String = s.substr(0, s.length() - 40)
	var expected: String = s.substr(s.length() - 40)
	var mac: String = Crypto.new().hmac_digest(HashingContext.HASH_SHA1, key.to_utf8_buffer(), b64.to_utf8_buffer()).hex_encode()
	if mac != expected:
		return 0.0
	var data: Variant = JSON.parse_string(Marshalls.base64_to_utf8(b64))
	if not (data is Dictionary):
		return 0.0
	return _swe_to_source_keys(data)


func _swe_to_source_keys(data: Dictionary) -> Dictionary:
	if not data.has("S0"):
		return data
	swe_last_was_351 = true
	var out: Dictionary = {}
	for top: String in data:
		var w: Variant = data[top]
		if top != "S0" or not (w is Dictionary):
			out["SUB1" if top == "SB1" else top] = w
			continue
		var main: Dictionary = {}
		for sec: String in w:
			var sec_name: String = SWE_SECTIONS.get(sec, sec)
			var keys: Dictionary = SWE_KEYS.get(sec_name, {})
			var list: Array = []
			for e: Variant in w[sec]:
				if not (e is Dictionary):
					list.append(e)
					continue
				var m: Dictionary = {}
				for k: String in e:
					var nk: String = keys.get(k, SWE_KEYS_COMMON.get(k, k))
					m[nk] = e[k]
				list.append(m)
			main[sec_name] = list
		out["MAIN"] = main
	return out


## GML 的 ==，两边类型可能不同时用（数值和字符串比较在 GML 里是 false，GDScript 里是运行时错误）。
func veq(a: Variant, b: Variant) -> bool:
	var na: bool = a is int or a is float or a is bool
	var nb: bool = b is int or b is float or b is bool
	if na and nb:
		return absf(float(a) - float(b)) <= EPSILON
	if na != nb:
		return false
	if typeof(a) != typeof(b) and not (a is String or a is StringName) :
		return false
	return a == b
