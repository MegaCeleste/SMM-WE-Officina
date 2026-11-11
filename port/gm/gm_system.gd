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
	if _ci == _ci_world:
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
# shader（第 11 批实现；现在全部是空操作）
# ======================================================================

func shader_get_uniform(_sh: float, _uniform: String) -> int:
	return -1


func shader_set(_sh: float) -> void:
	pass


func shader_reset() -> void:
	pass


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
