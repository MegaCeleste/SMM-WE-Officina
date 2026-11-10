class_name GMObject
extends Node
## 所有移植 object 的根基类：GMS 实例的内置变量和“以自身为主语”的内置函数。
##
## 事件方法（_create、_step、_alarm_0、_collision_obj_xxx、_user_0 …）不在这里声明，
## 由子类按需定义；GM 在类第一次实例化时扫描有哪些事件（见 GMClass）。
## 行为依据：docs/port-plan.md §3–§5；数值细节取自 GameMaker HTML5 runner 源码
## （yyInstance.js），标 UNVERIFIED 的地方未在 Windows runner 上实测。

const DEG2RAD: float = 0.0174532925  # runner 用的就是这个截断常数

## 碰撞系统（GM.col），由 GM 在启动时填入；放成 static 是为了少一次 autoload 查找
static var COL: GMCollision = null

# ---- 兼容层内部状态 ----
var _uid: int = 0  ## 创建序号，决定同阶段内的执行顺序
var _cls: GMClass = null
var _isa: PackedByteArray = PackedByteArray()  ## = _cls.is_a，查询时少一层间接
var _mv: bool = false  ## 是否已进 GM._movers（速度、重力、阻力曾被设过）
var _active: bool = true
var _destroyed: bool = false
var _dying: bool = false
var _cc: int = 0  ## createCounter：阶段开始之后才创建的实例不参加该阶段
var _bb_dirty: bool = true
var _grid_dirty: bool = false
var _in_grid: bool = false
var _gx0: int = 0
var _gy0: int = 0
var _gx1: int = 0
var _gy1: int = 0
var _qstamp: int = 0
var _bl: float = 0.0
var _bt: float = 0.0
var _br: float = 0.0
var _bbm: float = 0.0
var _colcheck: int = 0
var _mask_spr: GMSprite = null  ## 当前用于碰撞的 sprite（mask_index 或 sprite_index），没有则为 null
var _sp_lock: bool = false
var _mouse_over: bool = false
var _outside_room: bool = false
var _room_inst_name: String = ""

# ---- GMS 内置变量 ----
var object_index: int = -1
var persistent: bool = false
var visible: bool = true
var xstart: float = 0.0
var ystart: float = 0.0
var xprevious: float = 0.0
var yprevious: float = 0.0
var friction: float = 0.0:
	set(v):
		friction = v
		if not _mv:
			_join_movers()
var gravity: float = 0.0:
	set(v):
		gravity = v
		if not _mv:
			_join_movers()
var gravity_direction: float = 270.0
var image_index: float = 0.0
var image_speed: float = 1.0
var image_alpha: float = 1.0
var image_blend: int = 0xFFFFFF
var alarm: Array[float] = [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0]

var x: float = 0.0:
	set(v):
		if v != x:
			x = v
			if not _bb_dirty:
				_touch()
var y: float = 0.0:
	set(v):
		if v != y:
			y = v
			if not _bb_dirty:
				_touch()
var sprite_index: int = -1:
	set(v):
		sprite_index = v
		if not _bb_dirty:
			_touch()
var mask_index: int = -1:
	set(v):
		mask_index = v
		if not _bb_dirty:
			_touch()
var image_xscale: float = 1.0:
	set(v):
		if v != image_xscale:
			image_xscale = v
			if not _bb_dirty:
				_touch()
var image_yscale: float = 1.0:
	set(v):
		if v != image_yscale:
			image_yscale = v
			if not _bb_dirty:
				_touch()
var image_angle: float = 0.0:
	set(v):
		if v != image_angle:
			image_angle = v
			if not _bb_dirty:
				_touch()
var depth: float = 0.0:
	set(v):
		if v != depth:
			var old: float = depth
			depth = v
			if _uid != 0:
				GM._depth_changed(self, old)

# hspeed/vspeed 与 speed/direction 的联动，照 runner 的 Compute_Speed1/2
var hspeed: float = 0.0:
	set(v):
		if v == hspeed:
			return
		hspeed = v
		if not _sp_lock:
			_compute_speed1()
var vspeed: float = 0.0:
	set(v):
		if v == vspeed:
			return
		vspeed = v
		if not _sp_lock:
			_compute_speed1()
var speed: float = 0.0:
	set(v):
		if v == speed:
			return
		speed = v
		if not _sp_lock:
			_compute_speed2()
var direction: float = 0.0:
	set(v):
		if _sp_lock:
			direction = v
			return
		while v < 0.0:
			v += 360.0
		while v > 360.0:
			v -= 360.0
		direction = fmod(v, 360.0)
		_compute_speed2()

# ---- 只读内置变量 ----
var bbox_left: float:
	get:
		if _bb_dirty:
			_bb_update()
		return _bl
var bbox_right: float:
	get:
		if _bb_dirty:
			_bb_update()
		return _br
var bbox_top: float:
	get:
		if _bb_dirty:
			_bb_update()
		return _bt
var bbox_bottom: float:
	get:
		if _bb_dirty:
			_bb_update()
		return _bbm
var image_number: float:
	get:
		return float(GM.sprites[sprite_index].frames) if sprite_index >= 0 else 0.0
var sprite_width: float:
	get:
		return GM.sprites[sprite_index].width * image_xscale if sprite_index >= 0 else 0.0
var sprite_height: float:
	get:
		return GM.sprites[sprite_index].height * image_yscale if sprite_index >= 0 else 0.0
var sprite_xoffset: float:
	get:
		return GM.sprites[sprite_index].xo * image_xscale if sprite_index >= 0 else 0.0
var sprite_yoffset: float:
	get:
		return GM.sprites[sprite_index].yo * image_yscale if sprite_index >= 0 else 0.0


func _touch() -> void:
	_bb_dirty = true
	if not _grid_dirty:
		_grid_dirty = true
		COL.dirty.append(self)


static func _clamp6(f: float) -> float:
	# runner 的 ClampFloat：向零截断到 6 位小数
	return float(int(f * 1000000.0)) / 1000000.0


func _join_movers() -> void:
	_mv = true
	GM._movers.append(self)


func _compute_speed1() -> void:
	if not _mv:
		_join_movers()
	_sp_lock = true
	if hspeed == 0.0:
		if vspeed > 0.0:
			direction = 270.0
		elif vspeed < 0.0:
			direction = 90.0
	else:
		var dd: float = _clamp6(180.0 * atan2(vspeed, hspeed) / PI)
		direction = -dd if dd <= 0.0 else 360.0 - dd
	if absf(direction - roundf(direction)) < 0.0001:
		direction = roundf(direction)
	direction = fmod(direction, 360.0)
	speed = sqrt(hspeed * hspeed + vspeed * vspeed)
	if absf(speed - roundf(speed)) < 0.0001:
		speed = roundf(speed)
	_sp_lock = false


func _compute_speed2() -> void:
	if not _mv:
		_join_movers()
	_sp_lock = true
	var r: float = direction * DEG2RAD
	hspeed = speed * _clamp6(cos(r))
	vspeed = -speed * _clamp6(sin(r))
	if absf(hspeed - roundf(hspeed)) < 0.0001:
		hspeed = roundf(hspeed)
	if absf(vspeed - roundf(vspeed)) < 0.0001:
		vspeed = roundf(vspeed)
	_sp_lock = false


## runner 的 AdaptSpeed：先 friction，再 gravity
func _adapt_speed() -> void:
	if friction != 0.0:
		var ns: float = speed - friction if speed > 0.0 else speed + friction
		if speed > 0.0 and ns < 0.0:
			speed = 0.0
		elif speed < 0.0 and ns > 0.0:
			speed = 0.0
		elif speed != 0.0:
			speed = ns
	if gravity != 0.0:
		motion_add(gravity_direction, gravity)


## runner 的 Compute_BoundingBox（collision compatibility 模式）。
## 包围盒取整（四舍六入五成双），右/下为闭区间。
func _bb_update() -> void:
	_bb_dirty = false
	_bb_calc(x, y)


## 按“实例位于 (px, py)”计算包围盒，写入 _bl/_bt/_br/_bbm。place_meeting 用它试探位置。
func _bb_calc(px: float, py: float) -> void:
	var ix: int = mask_index if mask_index >= 0 else sprite_index
	if ix < 0:
		_bl = px
		_br = px
		_bt = py
		_bbm = py
		_colcheck = GMSprite.COL_AABB
		_mask_spr = null
		return
	var s: GMSprite = GM.sprites[ix]
	_mask_spr = s
	_colcheck = s.colcheck
	if image_angle == 0.0:
		var l: float = GM.gm_round(px + image_xscale * (s.bl - s.xo))
		var r: float = GM.gm_round(l + image_xscale * float(s.br + 1 - s.bl))
		if l > r:
			var t0: float = l
			l = r
			r = t0
		var t: float = GM.gm_round(py + image_yscale * (s.bt - s.yo))
		var b: float = GM.gm_round(t + image_yscale * float(s.bb + 1 - s.bt))
		if t > b:
			var t1: float = t
			t = b
			b = t1
		_bl = l
		_br = r - 1.0
		_bt = t
		_bbm = b - 1.0
	else:
		var xmin: float = image_xscale * (s.bl - s.xo)
		var xmax: float = image_xscale * (s.br - s.xo + 1.0)
		var ymin: float = image_yscale * (s.bt - s.yo)
		var ymax: float = image_yscale * (s.bb - s.yo + 1.0)
		var cc: float = cos(image_angle * PI / 180.0)
		var ss: float = sin(image_angle * PI / 180.0)
		var cc_xmax: float = cc * xmax
		var cc_xmin: float = cc * xmin
		var ss_ymax: float = ss * ymax
		var ss_ymin: float = ss * ymin
		var tmp: float
		if cc_xmax < cc_xmin:
			tmp = cc_xmax
			cc_xmax = cc_xmin
			cc_xmin = tmp
		if ss_ymax < ss_ymin:
			tmp = ss_ymax
			ss_ymax = ss_ymin
			ss_ymin = tmp
		var cc_ymax: float = cc * ymax
		var cc_ymin: float = cc * ymin
		var ss_xmax: float = ss * xmax
		var ss_xmin: float = ss * xmin
		if cc_ymax < cc_ymin:
			tmp = cc_ymax
			cc_ymax = cc_ymin
			cc_ymin = tmp
		if ss_xmax < ss_xmin:
			tmp = ss_xmax
			ss_xmax = ss_xmin
			ss_xmin = tmp
		_bl = floorf(px + cc_xmin + ss_ymin + 0.5)
		_br = floorf(px + cc_xmax + ss_ymax - 0.5)
		_bt = floorf(py + cc_ymin - ss_xmax + 0.5)
		_bbm = floorf(py + cc_ymax - ss_xmin - 0.5)


# ======================================================================
# 以自身为主语的 GML 内置函数（名字和参数顺序与 GML 相同）
# obj 参数：int（object 编号，含后代）、GMObject（单个实例）或 GM.all
# ======================================================================

func collision_rectangle(x1: float, y1: float, x2: float, y2: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	return COL.rectangle(self, x1, y1, x2, y2, obj, prec, notme)


func collision_point(px: float, py: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	return COL.point(self, px, py, obj, prec, notme)


func collision_line(x1: float, y1: float, x2: float, y2: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	return COL.line(self, x1, y1, x2, y2, obj, prec, notme)


func place_meeting(px: float, py: float, obj: Variant) -> bool:
	return COL.place(self, px, py, obj) != null


func instance_place(px: float, py: float, obj: Variant) -> GMObject:
	return COL.place(self, px, py, obj)


## 原版没有任何 solid 实例（811 个 object 的 solid 全为 false，运行时也从不赋值），
## 所以 place_free 恒为真。
func place_free(_px: float, _py: float) -> bool:
	return true


func position_meeting(px: float, py: float, obj: Variant) -> bool:
	return COL.point(self, px, py, obj, true, false) != null


func instance_position(px: float, py: float, obj: Variant) -> GMObject:
	return COL.point(self, px, py, obj, true, false)


func motion_set(dir: float, spd: float) -> void:
	direction = dir
	speed = spd


func motion_add(dir: float, spd: float) -> void:
	_sp_lock = true
	hspeed += spd * _clamp6(cos(dir * DEG2RAD))
	vspeed -= spd * _clamp6(sin(dir * DEG2RAD))
	_sp_lock = false
	_compute_speed1()


func move_towards_point(px: float, py: float, spd: float) -> void:
	direction = GM.point_direction(x, y, px, py)
	speed = spd


func move_snap(hsnap: float, vsnap: float) -> void:
	# UNVERIFIED(U8)：正好落在半格时 runner 用哪种舍入未确认，这里用 GML 的 round
	x = GM.gm_round(x / hsnap) * hsnap
	y = GM.gm_round(y / vsnap) * vsnap


func instance_destroy() -> void:
	GM.instance_destroy(self)


func event_user(n: int) -> void:
	var m: StringName = GM.USER_EVENT_NAMES[n]
	if has_method(m):
		call(m)


func draw_self() -> void:
	if sprite_index >= 0:
		GM.draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
