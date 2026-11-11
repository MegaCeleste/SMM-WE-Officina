extends "res://gm/gm_draw.gd"
## 兼容层第 2b 层：room 图层与 layer_* 函数（第 2 批）。
##
## 原版的 1098 处 `__background_set` 都走 GMS 自动生成的兼容脚本（scripts/__background_*），
## 那些脚本按图层名（Compatibility_Background_N 等）找图层、读写背景元素。这里实现它们用到的
## layer_* 函数，脚本本身照原样翻译。
##
## 只实现了背景元素。实例图层只记名字和 depth（实例自己的 depth 照旧由 GMObject 管）；
## asset 图层（图块、sprite 元素）只建空图层，内容还没画（rm_template 的
## Compatibility_Tiles_Depth_9，第 3 批处理）。

const layerelementtype_undefined: int = 0
const layerelementtype_background: int = 1
const layerelementtype_instance: int = 2
const layerelementtype_oldtilemap: int = 3
const layerelementtype_sprite: int = 4
const layerelementtype_tilemap: int = 5
const layerelementtype_particlesystem: int = 6
const layerelementtype_tile: int = 7
const layerelementtype_sequence: int = 8


class GMLayer:
	extends RefCounted
	var id: int = -1
	var name: String = ""
	var depth: float = 0.0
	var visible: bool = true
	var x: float = 0.0
	var y: float = 0.0
	var hspeed: float = 0.0
	var vspeed: float = 0.0
	var elements: Array[int] = []
	var seq: int = 0  ## 加入顺序：room 里图层列表的位置，新建的排在最后


class GMBackground:
	extends RefCounted
	var id: int = -1
	var layer: int = -1
	var sprite: int = -1
	var visible: bool = true
	var htiled: bool = false
	var vtiled: bool = false
	var stretch: bool = false
	var xscale: float = 1.0
	var yscale: float = 1.0
	var blend: int = 0xFFFFFF
	var alpha: float = 1.0
	var index: float = 0.0
	var speed: float = 0.0  ## 每步的帧推进量


var _layers: Dictionary = {}  ## id → GMLayer
var _layer_order: Array[GMLayer] = []  ## 按 room 里的列表顺序（第一个是编辑器里最上面的）
var _bgs: Dictionary = {}  ## 元素 id → GMBackground
var _next_layer_id: int = 1
var _next_element_id: int = 1
var _layers_dirty: bool = true
var _layer_seq: int = 0


## 换 room 时调用：清掉旧图层，按 room 定义建新图层（tables/runtime.json 的 rooms[].layers）
func _load_room_layers(defs: Array) -> void:
	_layers.clear()
	_layer_order.clear()
	_bgs.clear()
	_layers_dirty = true
	_layer_seq = 0
	for d: Dictionary in defs:
		var l: GMLayer = _new_layer(float(d["depth"]), String(d["name"]))
		l.visible = bool(d.get("visible", true))
		if String(d["type"]) == "GMRBackgroundLayer":
			l.x = float(d.get("x", 0.0))
			l.y = float(d.get("y", 0.0))
			l.hspeed = float(d.get("hspeed", 0.0))
			l.vspeed = float(d.get("vspeed", 0.0))
			var spr: int = -1
			if d.get("sprite") != null:
				spr = int(sprite_name_to_id.get(String(d["sprite"]), -1))
			var b: GMBackground = _new_background(l, spr)
			var col: Dictionary = d["colour"]
			# yy 里的颜色是 ABGR 整数；blend 用 GML 的 0xBBGGRR，alpha 单独存
			b.blend = int(col["r"]) | (int(col["g"]) << 8) | (int(col["b"]) << 16)
			b.alpha = float(col["a"]) / 255.0
			b.htiled = bool(d.get("htiled", false))
			b.vtiled = bool(d.get("vtiled", false))
			b.stretch = bool(d.get("stretch", false))
			# UNVERIFIED: 背景的动画速度。userdefinedAnimFPS 为假时用 sprite 自己的速度
			if spr >= 0:
				if bool(d.get("userdefinedAnimFPS", false)):
					var fps_v: float = float(d.get("animationFPS", 15.0))
					b.speed = fps_v if int(d.get("animationSpeedType", 0)) == 1 else fps_v / room_speed
				else:
					b.speed = sprites[spr].tick_speed


func _new_layer(d: float, n: String) -> GMLayer:
	var l: GMLayer = GMLayer.new()
	l.id = _next_layer_id
	_next_layer_id += 1
	l.depth = d
	l.name = n if n != "" else "_layer_%08x" % l.id
	l.seq = _layer_seq
	_layer_seq += 1
	_layers[l.id] = l
	_layer_order.append(l)
	_layers_dirty = true
	return l


func _new_background(l: GMLayer, spr: int) -> GMBackground:
	var b: GMBackground = GMBackground.new()
	b.id = _next_element_id
	_next_element_id += 1
	b.layer = l.id
	b.sprite = spr
	_bgs[b.id] = b
	l.elements.append(b.id)
	return b


func _layer(id: Variant) -> GMLayer:
	if id is String:
		for l: GMLayer in _layer_order:
			if l.name == id:
				return l
		return null
	return _layers.get(int(id))


func _bg(id: Variant) -> GMBackground:
	return _bgs.get(int(id))


# ---- 每步：图层滚动、背景动画（在 Draw 之前做） ----
func _update_layers() -> void:
	for l: GMLayer in _layer_order:
		if l.hspeed != 0.0 or l.vspeed != 0.0:
			l.x += l.hspeed
			l.y += l.vspeed
	for b: GMBackground in _bgs.values():
		if b.speed != 0.0 and b.sprite >= 0:
			b.index += b.speed
			var n: float = float(sprites[b.sprite].frames)
			if b.index >= n:
				b.index -= n
			elif b.index < 0.0:
				b.index += n


## 某个 depth 上的图层（不含空图层），同 depth 时列表里靠前的画在上面，所以先画靠后的。
## UNVERIFIED U12：同 depth 图层的先后
func _layers_at(d: float) -> Array[GMLayer]:
	var out: Array[GMLayer] = []
	for l: GMLayer in _layer_order:
		if l.depth == d and not l.elements.is_empty():
			out.append(l)
	out.sort_custom(func(a: GMLayer, b: GMLayer) -> bool: return a.seq > b.seq)
	return out


func _layer_depths() -> Array[float]:
	var out: Array[float] = []
	for l: GMLayer in _layer_order:
		if not l.elements.is_empty() and not out.has(l.depth):
			out.append(l.depth)
	return out


## 画一个图层的全部背景元素（世界坐标，当前 canvas item 是世界层）
func _draw_layer(l: GMLayer) -> void:
	if not l.visible:
		return
	var vx: float = _cam_x[0]
	var vy: float = _cam_y[0]
	var vw: float = _cam_w[0]
	var vh: float = _cam_h[0]
	for eid: int in l.elements:
		var b: GMBackground = _bgs.get(eid)
		if b == null or not b.visible:
			continue
		if b.sprite < 0:
			# 没有 sprite 的背景就是纯色填充
			if b.alpha > 0.0:
				_reset_xf()
				RenderingServer.canvas_item_add_rect(_ci, Rect2(vx, vy, vw, vh), gm_color(b.blend, b.alpha))
			continue
		var s: GMSprite = sprites[b.sprite]
		var tex: Texture2D = s.texture()
		if tex == null:
			continue
		var f: int = _frame_of(s, b.index)
		var src: Rect2 = Rect2(f * s.width, 0.0, s.width, s.height)
		var c: Color = gm_color(b.blend, b.alpha)
		_reset_xf()
		if b.stretch:
			RenderingServer.canvas_item_add_texture_rect_region(_ci, Rect2(l.x, l.y, room_width, room_height), tex.get_rid(), src, c)
			continue
		var tw: float = float(s.width) * b.xscale
		var th: float = float(s.height) * b.yscale
		if tw <= 0.0 or th <= 0.0:
			continue
		var x0: float = l.x
		var y0: float = l.y
		var nx: int = 1
		var ny: int = 1
		if b.htiled:
			x0 = l.x + floorf((vx - l.x) / tw) * tw
			nx = int(ceilf((vx + vw - x0) / tw)) + 1
		if b.vtiled:
			y0 = l.y + floorf((vy - l.y) / th) * th
			ny = int(ceilf((vy + vh - y0) / th)) + 1
		for j: int in ny:
			for i: int in nx:
				RenderingServer.canvas_item_add_texture_rect_region(_ci, Rect2(x0 + tw * i, y0 + th * j, tw, th), tex.get_rid(), src, c)


# ======================================================================
# layer_*（GML 同名函数）
# ======================================================================

func layer_get_all() -> Array:
	var out: Array = []
	for l: GMLayer in _layer_order:
		out.append(l.id)
	return out


func layer_get_id(layer_name: String) -> int:
	var l: GMLayer = _layer(layer_name)
	return l.id if l != null else -1


func layer_exists(id: Variant) -> bool:
	return _layer(id) != null


func layer_get_name(id: Variant) -> String:
	var l: GMLayer = _layer(id)
	return l.name if l != null else ""


func layer_create(d: float, layer_name: String = "") -> int:
	return _new_layer(d, layer_name).id


func layer_destroy(id: Variant) -> void:
	var l: GMLayer = _layer(id)
	if l == null:
		return
	for eid: int in l.elements:
		_bgs.erase(eid)
	_layers.erase(l.id)
	_layer_order.erase(l)
	_layers_dirty = true


func layer_depth(id: Variant, d: float) -> void:
	var l: GMLayer = _layer(id)
	if l != null and l.depth != d:
		l.depth = d
		_layers_dirty = true


func layer_get_depth(id: Variant) -> float:
	var l: GMLayer = _layer(id)
	return l.depth if l != null else -1.0


func layer_set_visible(id: Variant, vis: Variant) -> void:
	var l: GMLayer = _layer(id)
	if l != null:
		l.visible = truthy(vis)


func layer_get_visible(id: Variant) -> bool:
	var l: GMLayer = _layer(id)
	return l.visible if l != null else false


func layer_x(id: Variant, v: float) -> void:
	var l: GMLayer = _layer(id)
	if l != null:
		l.x = v


func layer_y(id: Variant, v: float) -> void:
	var l: GMLayer = _layer(id)
	if l != null:
		l.y = v


func layer_get_x(id: Variant) -> float:
	var l: GMLayer = _layer(id)
	return l.x if l != null else 0.0


func layer_get_y(id: Variant) -> float:
	var l: GMLayer = _layer(id)
	return l.y if l != null else 0.0


func layer_hspeed(id: Variant, v: float) -> void:
	var l: GMLayer = _layer(id)
	if l != null:
		l.hspeed = v


func layer_vspeed(id: Variant, v: float) -> void:
	var l: GMLayer = _layer(id)
	if l != null:
		l.vspeed = v


func layer_get_hspeed(id: Variant) -> float:
	var l: GMLayer = _layer(id)
	return l.hspeed if l != null else 0.0


func layer_get_vspeed(id: Variant) -> float:
	var l: GMLayer = _layer(id)
	return l.vspeed if l != null else 0.0


func layer_get_all_elements(id: Variant) -> Array:
	var l: GMLayer = _layer(id)
	return l.elements.duplicate() if l != null else []


func layer_get_element_type(el: Variant) -> int:
	return layerelementtype_background if _bgs.has(int(el)) else layerelementtype_undefined


## 原版只在 __background_get_internal 里用它判断背景元素还在不在。没有 sprite 元素，恒为假，
## 那个脚本会因此每次重新按名字找一遍图层，结果不变。
func layer_sprite_exists(_id: Variant, _el: Variant) -> bool:
	return false


func layer_background_create(id: Variant, spr: float) -> int:
	var l: GMLayer = _layer(id)
	if l == null:
		return -1
	var b: GMBackground = _new_background(l, int(spr))
	_layers_dirty = true
	return b.id


func layer_background_get_id(id: Variant) -> int:
	var l: GMLayer = _layer(id)
	if l != null:
		for eid: int in l.elements:
			if _bgs.has(eid):
				return eid
	return -1


func layer_background_exists(id: Variant, el: Variant) -> bool:
	var l: GMLayer = _layer(id)
	return l != null and l.elements.has(int(el)) and _bgs.has(int(el))


func layer_background_change(el: Variant, spr: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.sprite = int(spr)
		b.index = 0.0


func layer_background_get_sprite(el: Variant) -> int:
	var b: GMBackground = _bg(el)
	return b.sprite if b != null else -1


## GML 语义：返回当前帧号，不是 sprite（原版的 __background_get_internal 拿它当 sprite 用来取
## Width/Height，那是 GMS 生成脚本的问题；全工程没有读 Width/Height 的地方）
func layer_background_get_index(el: Variant) -> float:
	var b: GMBackground = _bg(el)
	return b.index if b != null else 0.0


func layer_background_visible(el: Variant, v: Variant) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.visible = truthy(v)


func layer_background_get_visible(el: Variant) -> bool:
	var b: GMBackground = _bg(el)
	return b.visible if b != null else false


func layer_background_htiled(el: Variant, v: Variant) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.htiled = truthy(v)


func layer_background_get_htiled(el: Variant) -> bool:
	var b: GMBackground = _bg(el)
	return b.htiled if b != null else false


func layer_background_vtiled(el: Variant, v: Variant) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.vtiled = truthy(v)


func layer_background_get_vtiled(el: Variant) -> bool:
	var b: GMBackground = _bg(el)
	return b.vtiled if b != null else false


func layer_background_stretch(el: Variant, v: Variant) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.stretch = truthy(v)


func layer_background_get_stretch(el: Variant) -> bool:
	var b: GMBackground = _bg(el)
	return b.stretch if b != null else false


func layer_background_xscale(el: Variant, v: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.xscale = v


func layer_background_get_xscale(el: Variant) -> float:
	var b: GMBackground = _bg(el)
	return b.xscale if b != null else 1.0


func layer_background_yscale(el: Variant, v: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.yscale = v


func layer_background_get_yscale(el: Variant) -> float:
	var b: GMBackground = _bg(el)
	return b.yscale if b != null else 1.0


func layer_background_blend(el: Variant, col: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.blend = int(col)


func layer_background_get_blend(el: Variant) -> int:
	var b: GMBackground = _bg(el)
	return b.blend if b != null else c_white


func layer_background_alpha(el: Variant, a: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.alpha = a


func layer_background_get_alpha(el: Variant) -> float:
	var b: GMBackground = _bg(el)
	return b.alpha if b != null else 1.0


func layer_background_index(el: Variant, v: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.index = v


func layer_background_speed(el: Variant, v: float) -> void:
	var b: GMBackground = _bg(el)
	if b != null:
		b.speed = v
