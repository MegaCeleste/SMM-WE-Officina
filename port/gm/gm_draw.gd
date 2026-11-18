extends "res://gm/gm_base.gd"
## 兼容层第 2 层：绘制、字体、视图/相机。
##
## Draw 事件在 tick 内执行（GMS 的顺序），所以不能用 CanvasItem._draw()；这里直接往
## RenderingServer 的 canvas item 里写绘制命令，每个 tick 清空重画一次。

const VIEW_W: float = 384.0
const VIEW_H: float = 216.0
## Legacy GUI canvas dimensions; actual output is sized to the window.
const OUTPUT_SCALE: float = 2.0
const SPRITE_SHADOW_OFFSET: Vector2 = Vector2(2.0, 2.0)
const SPRITE_SHADOW_OPACITY: float = 0.30

# ---- 绘制状态（GMS 里是全局的，跨事件、跨帧保留） ----
var _draw_colour: int = c_white
var _draw_alpha: float = 1.0
var _draw_font: int = -1
var _draw_halign: int = fa_left
var _draw_valign: int = fa_top
var _circle_precision: int = 24

var _world_node: Node2D = null
var _gui_layer: CanvasLayer = null
var _gui_node: Node2D = null
var _ci_world: RID = RID()
var _ci_gui: RID = RID()
var _ci: RID = RID()  ## 当前绘制目标
var _xf_set: bool = false
var _draw_inst: GMObject = null  ## 正在执行 Draw 事件的实例（subimg = -1 时取它的 image_index）
var _draw_sprite_shadows: bool = false
var _ordered_world: bool = false
var _prototype_capture_anchor: bool = false
var _prototype_anchor_found: bool = false
var _prototype_anchor: Vector2 = Vector2.ZERO

## 字体表：{"kind": "ttf", "font": Font, "size": int} 或
## {"kind": "spr", "spr": int, "map": Dictionary, "prop": bool, "sep": float}
var _fonts: Array = []

# ---- 视图 / 相机（原版只用 view 0） ----
var view_enabled: bool = false
var view_visible: Array[bool] = [false, false, false, false, false, false, false, false]
var view_camera: Array[int] = [0, 1, 2, 3, 4, 5, 6, 7]
var _cam_x: Array[float] = []
var _cam_y: Array[float] = []
var _cam_w: Array[float] = []
var _cam_h: Array[float] = []
var _cam_angle: Array[float] = []
var _cam_target: Array = []  ## GMObject、object 编号或 noone
var _cam_bx: Array[float] = []
var _cam_by: Array[float] = []
var _cam_sx: Array[float] = []
var _cam_sy: Array[float] = []
var _view_xport: Array[float] = []
var _view_yport: Array[float] = []
var _view_wport: Array[float] = []
var _view_hport: Array[float] = []
var room_width: float = VIEW_W
var room_height: float = VIEW_H

# ---- application_surface 与 GUI（第 2 批） ----
## 世界层画进这个 SubViewport；它的纹理就是 application_surface（见 gm_system.gd）
var _app_vp: SubViewport = null
var _app_w: float = VIEW_W
var _app_h: float = VIEW_H
## application_surface 自动画到屏幕上用的 canvas item（application_surface_draw_enable(false) 时为空）
var _app_node: Node2D = null
var _ci_app: RID = RID()
## display_set_gui_size 设的 GUI 坐标范围，映射到整个画面
var _gui_w: float = VIEW_W
var _gui_h: float = VIEW_H
## 16:9 output rectangle in native window pixels, including letterbox offset.
var _output_rect: Rect2 = Rect2(0.0, 0.0, VIEW_W * OUTPUT_SCALE, VIEW_H * OUTPUT_SCALE)


func _init_draw() -> void:
	for i: int in 8:
		_cam_x.append(0.0)
		_cam_y.append(0.0)
		_cam_w.append(VIEW_W)
		_cam_h.append(VIEW_H)
		_cam_angle.append(0.0)
		_cam_target.append(noone)
		_cam_bx.append(0.0)
		_cam_by.append(0.0)
		_cam_sx.append(-1.0)
		_cam_sy.append(-1.0)
		_view_xport.append(0.0)
		_view_yport.append(0.0)
		_view_wport.append(VIEW_W)
		_view_hport.append(VIEW_H)
	# GMS 的窗口底色是黑的；SubViewport 每帧用它清屏
	RenderingServer.set_default_clear_color(Color.BLACK)
	_app_vp = SubViewport.new()
	_app_vp.name = "GMApplicationSurface"
	_app_vp.size = Vector2i(int(_app_w), int(_app_h))
	_app_vp.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	_app_vp.transparent_bg = false
	_app_vp.disable_3d = true
	_app_vp.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	add_child(_app_vp)
	_world_node = Node2D.new()
	_world_node.name = "GMWorld"
	_app_vp.add_child(_world_node)
	_app_node = Node2D.new()
	_app_node.name = "GMAppSurface"
	add_child(_app_node)
	_ci_app = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_ci_app, _app_node.get_canvas_item())
	_update_app_surface_quad()
	_gui_layer = CanvasLayer.new()
	_gui_layer.name = "GMGui"
	_gui_layer.layer = 10
	add_child(_gui_layer)
	_gui_node = Node2D.new()
	_gui_layer.add_child(_gui_node)
	_ci_world = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_ci_world, _world_node.get_canvas_item())
	_ci_gui = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_ci_gui, _gui_node.get_canvas_item())
	_ci = _ci_world
	get_viewport().size_changed.connect(_refresh_output_layout)
	_refresh_output_layout()


func _exit_tree() -> void:
	if _ci_world.is_valid():
		RenderingServer.free_rid(_ci_world)
	if _ci_gui.is_valid():
		RenderingServer.free_rid(_ci_gui)
	if _ci_app.is_valid():
		RenderingServer.free_rid(_ci_app)


func _set_app_surface_size(w: float, h: float) -> void:
	_app_w = maxf(1.0, floorf(w))
	_app_h = maxf(1.0, floorf(h))
	_update_app_surface_quad()


## Render world and legacy GUI at the physical output size, but retain GMS's
## application_surface dimensions for its API and screenshot coordinates.
func _refresh_output_layout() -> void:
	var window_size: Vector2 = get_viewport().get_visible_rect().size
	if window_size.x <= 0.0 or window_size.y <= 0.0:
		return
	var scale: float = minf(window_size.x / VIEW_W, window_size.y / VIEW_H)
	var output_size: Vector2 = Vector2(maxf(1.0, floorf(VIEW_W * scale)), maxf(1.0, floorf(VIEW_H * scale)))
	var offset: Vector2 = Vector2(floorf((window_size.x - output_size.x) / 2.0), floorf((window_size.y - output_size.y) / 2.0))
	_output_rect = Rect2(offset, output_size)
	if _app_vp != null:
		_app_vp.size = Vector2i(int(output_size.x), int(output_size.y))
	if _ci_app.is_valid():
		RenderingServer.canvas_item_set_transform(_ci_app, Transform2D(0.0, output_size / Vector2(VIEW_W * OUTPUT_SCALE, VIEW_H * OUTPUT_SCALE), 0.0, offset))
	if _ci_gui.is_valid():
		RenderingServer.canvas_item_set_transform(_ci_gui, Transform2D(0.0, output_size / Vector2(_gui_w, _gui_h), 0.0, offset))
	if _ci_world.is_valid():
		_apply_world_transform(Vector2(_cam_x[0], _cam_y[0]))


func _apply_world_transform(camera: Vector2) -> void:
	var scale: Vector2 = Vector2(float(_app_vp.size.x) / _cam_w[0], float(_app_vp.size.y) / _cam_h[0])
	RenderingServer.canvas_item_set_transform(_ci_world, Transform2D(0.0, scale, 0.0, -camera * scale))


## application_surface 自动显示：铺满整个画面（GMS 在 Draw 和 Draw GUI 之间画它）
func _update_app_surface_quad() -> void:
	if not _ci_app.is_valid():
		return
	RenderingServer.canvas_item_clear(_ci_app)
	if _app_surface_draw_on():
		RenderingServer.canvas_item_add_texture_rect(_ci_app, Rect2(0.0, 0.0, VIEW_W * OUTPUT_SCALE, VIEW_H * OUTPUT_SCALE), _app_vp.get_texture().get_rid())


## gm_system.gd 覆盖
func _app_surface_draw_on() -> bool:
	return true


func _begin_world_draw() -> void:
	RenderingServer.canvas_item_clear(_ci_world)
	RenderingServer.canvas_item_clear(_ci_gui)
	_apply_world_transform(Vector2(_cam_x[0], _cam_y[0]))
	RenderingServer.canvas_item_set_transform(_ci_gui, Transform2D(0.0, _output_rect.size / Vector2(_gui_w, _gui_h), 0.0, _output_rect.position))
	_ci = _ci_world
	_xf_set = false


func _begin_gui_draw() -> void:
	_ci = _ci_gui
	_xf_set = false


func _reset_xf() -> void:
	if _xf_set:
		RenderingServer.canvas_item_add_set_transform(_ci, Transform2D.IDENTITY)
		_xf_set = false


# ======================================================================
# 绘制状态
# ======================================================================

func draw_set_colour(col: int) -> void:
	_draw_colour = col


func draw_set_color(col: int) -> void:
	_draw_colour = col


func draw_get_colour() -> int:
	return _draw_colour


func draw_set_alpha(a: float) -> void:
	_draw_alpha = a


func draw_get_alpha() -> float:
	return _draw_alpha


func draw_set_font(font: int) -> void:
	_draw_font = font


func draw_set_halign(h: int) -> void:
	_draw_halign = h


func draw_set_valign(v: int) -> void:
	_draw_valign = v


func draw_set_circle_precision(p: float) -> void:
	_circle_precision = clampi(int(p), 4, 64)


# ======================================================================
# sprite
# ======================================================================

func _frame_of(s: GMSprite, subimg: float) -> int:
	if subimg < 0.0 and _draw_inst != null:
		subimg = _draw_inst.image_index
	var f: int = int(floorf(subimg)) % s.frames
	if f < 0:
		f += s.frames
	return f


func draw_sprite(spr: int, subimg: float, px: float, py: float) -> void:
	draw_sprite_ext(spr, subimg, px, py, 1.0, 1.0, 0.0, c_white, _draw_alpha)


func _sprite_shadow_allowed() -> bool:
	return true


func _draw_sprite_region(texture: RID, dest: Rect2, source: Rect2, color: Color, transform: Transform2D = Transform2D.IDENTITY) -> void:
	var transformed: bool = transform != Transform2D.IDENTITY
	if not transformed:
		_reset_xf()
	var shadow: bool = _draw_sprite_shadows and color.a > 0.0 and _sprite_shadow_allowed()
	if shadow:
		var shadow_color: Color = Color(0.0, 0.0, 0.0, minf(color.a, 1.0) * SPRITE_SHADOW_OPACITY)
		if transformed:
			var shadow_transform: Transform2D = transform.translated(SPRITE_SHADOW_OFFSET)
			RenderingServer.canvas_item_add_set_transform(_ci, shadow_transform)
			RenderingServer.canvas_item_add_texture_rect_region(_ci, dest, texture, source, shadow_color)
		else:
			RenderingServer.canvas_item_add_texture_rect_region(_ci, Rect2(dest.position + SPRITE_SHADOW_OFFSET, dest.size), texture, source, shadow_color)
	if transformed:
		RenderingServer.canvas_item_add_set_transform(_ci, transform)
		_xf_set = true
	RenderingServer.canvas_item_add_texture_rect_region(_ci, dest, texture, source, color)


func draw_sprite_ext(spr: int, subimg: float, px: float, py: float, xs: float, ys: float, rot: float, col: int, alpha: float) -> void:
	if not sprite_exists(spr):
		return
	if _prototype_capture_anchor and not _prototype_anchor_found and _draw_inst != null and spr == _draw_inst.sprite_index:
		_prototype_anchor = Vector2(px, py)
		_prototype_anchor_found = true
	var s: GMSprite = sprites[spr]
	var tex: Texture2D = s.texture()
	if tex == null:
		return
	var f: int = _frame_of(s, subimg)
	var src: Rect2 = Rect2(f * s.width, 0.0, s.width, s.height)
	if xs == 1.0 and ys == 1.0 and rot == 0.0:
		_draw_sprite_region(tex.get_rid(), Rect2(px - s.xo, py - s.yo, s.width, s.height), src, gm_color(col, alpha))
	else:
		var transform: Transform2D = Transform2D(-deg_to_rad(rot), Vector2(xs, ys), 0.0, Vector2(px, py))
		_draw_sprite_region(tex.get_rid(), Rect2(-s.xo, -s.yo, s.width, s.height), src, gm_color(col, alpha), transform)


func draw_sprite_part(spr: int, subimg: float, left: float, top: float, w: float, h: float, px: float, py: float) -> void:
	draw_sprite_part_ext(spr, subimg, left, top, w, h, px, py, 1.0, 1.0, c_white, _draw_alpha)


func draw_sprite_part_ext(spr: int, subimg: float, left: float, top: float, w: float, h: float, px: float, py: float, xs: float, ys: float, col: int, alpha: float) -> void:
	if not sprite_exists(spr):
		return
	var s: GMSprite = sprites[spr]
	var tex: Texture2D = s.texture()
	if tex == null:
		return
	var f: int = _frame_of(s, subimg)
	# 裁剪到帧范围内
	if left < 0.0:
		w += left
		px -= left * xs
		left = 0.0
	if top < 0.0:
		h += top
		py -= top * ys
		top = 0.0
	w = minf(w, s.width - left)
	h = minf(h, s.height - top)
	if w <= 0.0 or h <= 0.0:
		return
	var transform: Transform2D = Transform2D(0.0, Vector2(xs, ys), 0.0, Vector2(px, py))
	_draw_sprite_region(tex.get_rid(), Rect2(0.0, 0.0, w, h), Rect2(f * s.width + left, top, w, h), gm_color(col, alpha), transform)


func draw_sprite_stretched(spr: int, subimg: float, px: float, py: float, w: float, h: float) -> void:
	draw_sprite_stretched_ext(spr, subimg, px, py, w, h, c_white, _draw_alpha)


func draw_sprite_stretched_ext(spr: int, subimg: float, px: float, py: float, w: float, h: float, col: int, alpha: float) -> void:
	if not sprite_exists(spr):
		return
	var s: GMSprite = sprites[spr]
	var tex: Texture2D = s.texture()
	if tex == null:
		return
	var f: int = _frame_of(s, subimg)
	_draw_sprite_region(tex.get_rid(), Rect2(px, py, w, h), Rect2(f * s.width, 0.0, s.width, s.height), gm_color(col, alpha))


func sprite_get_width(spr: int) -> float:
	return float(sprites[spr].width) if spr >= 0 else 0.0


func sprite_get_height(spr: int) -> float:
	return float(sprites[spr].height) if spr >= 0 else 0.0


func sprite_get_xoffset(spr: int) -> float:
	return sprites[spr].xo if spr >= 0 else 0.0


func sprite_get_yoffset(spr: int) -> float:
	return sprites[spr].yo if spr >= 0 else 0.0


func sprite_get_number(spr: int) -> float:
	return float(sprites[spr].frames) if spr >= 0 else 0.0


func sprite_get_bbox_left(spr: int) -> float:
	return float(sprites[spr].bl) if spr >= 0 else 0.0


func sprite_get_bbox_right(spr: int) -> float:
	return float(sprites[spr].br) if spr >= 0 else 0.0


func sprite_get_bbox_top(spr: int) -> float:
	return float(sprites[spr].bt) if spr >= 0 else 0.0


func sprite_get_bbox_bottom(spr: int) -> float:
	return float(sprites[spr].bb) if spr >= 0 else 0.0


func sprite_get_name(spr: int) -> String:
	return sprites[spr].name if spr >= 0 and spr < sprites.size() else "<undefined>"


func sprite_exists(spr: int) -> bool:
	return spr >= 0 and spr < sprites.size() and sprites[spr] != null


# ======================================================================
# 图元
# ======================================================================

func draw_rectangle(x1: float, y1: float, x2: float, y2: float, outline: bool) -> void:
	draw_rectangle_colour(x1, y1, x2, y2, _draw_colour, _draw_colour, _draw_colour, _draw_colour, outline)


func draw_rectangle_colour(x1: float, y1: float, x2: float, y2: float, c1: int, _c2: int, _c3: int, _c4: int, outline: bool) -> void:
	_reset_xf()
	var l: float = minf(x1, x2)
	var t: float = minf(y1, y2)
	var w: float = absf(x2 - x1) + 1.0
	var h: float = absf(y2 - y1) + 1.0
	var c: Color = gm_color(c1, _draw_alpha)
	if not outline:
		RenderingServer.canvas_item_add_rect(_ci, Rect2(l, t, w, h), c)
	else:
		RenderingServer.canvas_item_add_rect(_ci, Rect2(l, t, w, 1.0), c)
		RenderingServer.canvas_item_add_rect(_ci, Rect2(l, t + h - 1.0, w, 1.0), c)
		RenderingServer.canvas_item_add_rect(_ci, Rect2(l, t, 1.0, h), c)
		RenderingServer.canvas_item_add_rect(_ci, Rect2(l + w - 1.0, t, 1.0, h), c)


func draw_circle(px: float, py: float, r: float, outline: bool) -> void:
	draw_circle_colour(px, py, r, _draw_colour, _draw_colour, outline)


func draw_circle_colour(px: float, py: float, r: float, c1: int, _c2: int, outline: bool) -> void:
	if r == 0.0:
		return
	_reset_xf()
	var c: Color = gm_color(c1, _draw_alpha)
	var pts: PackedVector2Array = PackedVector2Array()
	for i: int in _circle_precision + 1:
		var a: float = TAU * float(i) / float(_circle_precision)
		pts.append(Vector2(px + cos(a) * r, py + sin(a) * r))
	if outline:
		RenderingServer.canvas_item_add_polyline(_ci, pts, PackedColorArray([c]), 1.0)
	else:
		pts.remove_at(pts.size() - 1)
		RenderingServer.canvas_item_add_polygon(_ci, pts, PackedColorArray([c]))


func draw_line(x1: float, y1: float, x2: float, y2: float) -> void:
	_reset_xf()
	RenderingServer.canvas_item_add_line(_ci, Vector2(x1, y1), Vector2(x2, y2), gm_color(_draw_colour, _draw_alpha), 1.0)


## 在当前目标上铺满颜色（离屏目标由 gm_system.gd 处理）
func draw_clear(col: int) -> void:
	draw_clear_alpha(col, 1.0)


func draw_clear_alpha(col: int, alpha: float) -> void:
	RenderingServer.canvas_item_add_set_transform(_ci, Transform2D.IDENTITY)
	_xf_set = false
	RenderingServer.canvas_item_add_rect(_ci, Rect2(-100000.0, -100000.0, 200000.0, 200000.0), gm_color(col, alpha))


# ======================================================================
# 字体与文字
# ======================================================================

func font_add(file_name: String, size: float, _bold: Variant, _italic: Variant, _first: float, _last: float) -> int:
	var path: String = "res://assets/fonts/" + file_name
	var font: Font = null
	if ResourceLoader.exists(path):
		font = load(path) as Font
	if font == null:
		push_warning("GM.font_add: 找不到字体 %s，用引擎默认字体" % path)
		font = ThemeDB.fallback_font
	# GMS 的字号是点数，按 96 DPI 折成像素
	_fonts.append({"kind": "ttf", "font": font, "size": int(roundf(size * 96.0 / 72.0))})
	return _fonts.size() - 1


func font_add_sprite_ext(spr: int, string_map: String, prop: Variant, sep: float) -> int:
	var m: Dictionary = {}
	for i: int in string_map.length():
		m[string_map[i]] = i
	_fonts.append({"kind": "spr", "spr": spr, "map": m, "prop": bool(prop), "sep": sep})
	return _fonts.size() - 1


func _font() -> Dictionary:
	if _draw_font >= 0 and _draw_font < _fonts.size():
		return _fonts[_draw_font]
	return {"kind": "ttf", "font": ThemeDB.fallback_font, "size": 12}


func _line_width(fd: Dictionary, line: String) -> float:
	if fd["kind"] == "ttf":
		return (fd["font"] as Font).get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1.0, fd["size"]).x
	var s: GMSprite = sprites[fd["spr"]]
	return float(line.length()) * (float(s.width) + float(fd["sep"]))


func _line_height(fd: Dictionary) -> float:
	if fd["kind"] == "ttf":
		return (fd["font"] as Font).get_height(fd["size"])
	return float(sprites[fd["spr"]].height)


func string_width(v: Variant) -> float:
	var fd: Dictionary = _font()
	var w: float = 0.0
	for line: String in string(v).split("\n"):
		w = maxf(w, _line_width(fd, line))
	return w


func string_height(v: Variant) -> float:
	return _line_height(_font()) * float(string(v).split("\n").size())


func draw_text(px: float, py: float, v: Variant) -> void:
	_draw_text_impl(px, py, string(v), 1.0, 1.0, 0.0, _draw_colour, _draw_alpha, -1.0)


func draw_text_colour(px: float, py: float, v: Variant, c1: int, _c2: int, _c3: int, _c4: int, alpha: float) -> void:
	_draw_text_impl(px, py, string(v), 1.0, 1.0, 0.0, c1, alpha, -1.0)


func draw_text_color(px: float, py: float, v: Variant, c1: int, c2: int, c3: int, c4: int, alpha: float) -> void:
	draw_text_colour(px, py, v, c1, c2, c3, c4, alpha)


func draw_text_transformed(px: float, py: float, v: Variant, xs: float, ys: float, angle: float) -> void:
	_draw_text_impl(px, py, string(v), xs, ys, angle, _draw_colour, _draw_alpha, -1.0)


func draw_text_ext_transformed_colour(px: float, py: float, v: Variant, sep: float, _w: float, xs: float, ys: float, angle: float, c1: int, _c2: int, _c3: int, _c4: int, alpha: float) -> void:
	_draw_text_impl(px, py, string(v), xs, ys, angle, c1, alpha, sep)


func _draw_text_impl(px: float, py: float, text: String, xs: float, ys: float, angle: float, col: int, alpha: float, sep: float) -> void:
	var fd: Dictionary = _font()
	var lines: PackedStringArray = text.split("\n")
	var lh: float = _line_height(fd) if sep < 0.0 else sep
	var total_h: float = lh * float(lines.size())
	var oy: float = 0.0
	if _draw_valign == fa_middle:
		oy = -total_h / 2.0
	elif _draw_valign == fa_bottom:
		oy = -total_h
	RenderingServer.canvas_item_add_set_transform(_ci, Transform2D(-deg_to_rad(angle), Vector2(xs, ys), 0.0, Vector2(px, py)))
	_xf_set = true
	var c: Color = gm_color(col, alpha)
	for li: int in lines.size():
		var line: String = lines[li]
		var lw: float = _line_width(fd, line)
		var ox: float = 0.0
		if _draw_halign == fa_center:
			ox = -lw / 2.0
		elif _draw_halign == fa_right:
			ox = -lw
		var ly: float = oy + lh * float(li)
		if fd["kind"] == "ttf":
			var font: Font = fd["font"]
			font.draw_string(_ci, Vector2(ox, ly + font.get_ascent(fd["size"])), line, HORIZONTAL_ALIGNMENT_LEFT, -1.0, fd["size"], c)
		else:
			var s: GMSprite = sprites[fd["spr"]]
			var tex: Texture2D = s.texture()
			if tex == null:
				continue
			var adv: float = float(s.width) + float(fd["sep"])
			var m: Dictionary = fd["map"]
			for ci: int in line.length():
				var fr: Variant = m.get(line[ci])
				if fr != null:
					RenderingServer.canvas_item_add_texture_rect_region(_ci, Rect2(ox + adv * float(ci), ly, s.width, s.height), tex.get_rid(), Rect2(int(fr) * s.width, 0.0, s.width, s.height), c)


# ======================================================================
# 视图 / 相机
# ======================================================================

func view_get_camera(v: int) -> int:
	return view_camera[v]


func view_set_camera(v: int, cam: int) -> void:
	view_camera[v] = cam


func view_get_visible(v: int) -> bool:
	return view_visible[v]


func view_set_visible(v: int, vis: Variant) -> void:
	view_visible[v] = bool(vis)


func view_get_xport(v: int) -> float:
	return _view_xport[v]


func view_get_yport(v: int) -> float:
	return _view_yport[v]


func view_get_wport(v: int) -> float:
	return _view_wport[v]


func view_get_hport(v: int) -> float:
	return _view_hport[v]


func view_set_xport(v: int, val: float) -> void:
	_view_xport[v] = val


func view_set_yport(v: int, val: float) -> void:
	_view_yport[v] = val


func view_set_wport(v: int, val: float) -> void:
	_view_wport[v] = val


func view_set_hport(v: int, val: float) -> void:
	_view_hport[v] = val


func camera_get_view_x(cam: int) -> float:
	return _cam_x[cam]


func camera_get_view_y(cam: int) -> float:
	return _cam_y[cam]


func camera_get_view_width(cam: int) -> float:
	return _cam_w[cam]


func camera_get_view_height(cam: int) -> float:
	return _cam_h[cam]


func camera_get_view_angle(cam: int) -> float:
	return _cam_angle[cam]


func camera_get_view_target(cam: int) -> Variant:
	return _cam_target[cam]


func camera_get_view_border_x(cam: int) -> float:
	return _cam_bx[cam]


func camera_get_view_border_y(cam: int) -> float:
	return _cam_by[cam]


func camera_get_view_speed_x(cam: int) -> float:
	return _cam_sx[cam]


func camera_get_view_speed_y(cam: int) -> float:
	return _cam_sy[cam]


func camera_set_view_pos(cam: int, px: float, py: float) -> void:
	_cam_x[cam] = px
	_cam_y[cam] = py


func camera_set_view_size(cam: int, w: float, h: float) -> void:
	_cam_w[cam] = w
	_cam_h[cam] = h


func camera_set_view_angle(cam: int, a: float) -> void:
	_cam_angle[cam] = a


func camera_set_view_target(cam: int, target: Variant) -> void:
	_cam_target[cam] = target


func camera_set_view_border(cam: int, bx: float, by: float) -> void:
	_cam_bx[cam] = bx
	_cam_by[cam] = by


func camera_set_view_speed(cam: int, sx: float, sy: float) -> void:
	_cam_sx[cam] = sx
	_cam_sy[cam] = sy


## 相机跟随目标（GMS 在每步画图前做）。target 由 gm.gd 解析成实例后传进来。
func _camera_follow_position(cam: int, tx: float, ty: float) -> Vector2:
	var w: float = _cam_w[cam]
	var h: float = _cam_h[cam]
	var vx: float = _cam_x[cam]
	var vy: float = _cam_y[cam]
	var nx: float = vx
	var ny: float = vy
	var bx: float = _cam_bx[cam]
	var by: float = _cam_by[cam]
	if 2.0 * bx >= w:
		nx = tx - w / 2.0
	elif tx - bx < vx:
		nx = tx - bx
	elif tx + bx > vx + w:
		nx = tx + bx - w
	if 2.0 * by >= h:
		ny = ty - h / 2.0
	elif ty - by < vy:
		ny = ty - by
	elif ty + by > vy + h:
		ny = ty + by - h
	nx = clampf(nx, 0.0, maxf(room_width - w, 0.0))
	ny = clampf(ny, 0.0, maxf(room_height - h, 0.0))
	var sx: float = _cam_sx[cam]
	var sy: float = _cam_sy[cam]
	if sx >= 0.0:
		nx = clampf(nx, vx - sx, vx + sx)
	if sy >= 0.0:
		ny = clampf(ny, vy - sy, vy + sy)
	return Vector2(nx, ny)


func _camera_follow(cam: int, tx: float, ty: float) -> void:
	# Keep the logical camera's original double-precision arithmetic; the
	# Vector2-returning helper above is used only for presentation.
	var w: float = _cam_w[cam]
	var h: float = _cam_h[cam]
	var vx: float = _cam_x[cam]
	var vy: float = _cam_y[cam]
	var nx: float = vx
	var ny: float = vy
	var bx: float = _cam_bx[cam]
	var by: float = _cam_by[cam]
	if 2.0 * bx >= w:
		nx = tx - w / 2.0
	elif tx - bx < vx:
		nx = tx - bx
	elif tx + bx > vx + w:
		nx = tx + bx - w
	if 2.0 * by >= h:
		ny = ty - h / 2.0
	elif ty - by < vy:
		ny = ty - by
	elif ty + by > vy + h:
		ny = ty + by - h
	nx = clampf(nx, 0.0, maxf(room_width - w, 0.0))
	ny = clampf(ny, 0.0, maxf(room_height - h, 0.0))
	var sx: float = _cam_sx[cam]
	var sy: float = _cam_sy[cam]
	if sx >= 0.0:
		nx = clampf(nx, vx - sx, vx + sx)
	if sy >= 0.0:
		ny = clampf(ny, vy - sy, vy + sy)
	_cam_x[cam] = nx
	_cam_y[cam] = ny
