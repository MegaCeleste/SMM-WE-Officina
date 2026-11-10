class_name GMCollision
extends RefCounted
## GMS 碰撞查询的自实现（docs/port-plan.md §5）。
##
## 判定算法照 GameMaker HTML5 runner 的 collision compatibility 分支
## （yyInstance.js 的 Collision_Rectangle / Collision_Point / Collision_Instance / Collision_Line，
## yySprite.js 的 PreciseCollisionRectangle / PreciseCollisionPoint / OrigPreciseCollision）。
## 同时命中多个实例时返回创建最早的那个。 UNVERIFIED(U7)：原版用空间索引，返回顺序未知。
## 随旋转的矩形（collisionKind 5，只有 6 个装饰 sprite）没有做分离轴测试，按包围盒处理。

## 格子边长。关卡按 16 像素对齐，16 像素一格时一块地砖正好只占一格。
const CELL: float = 16.0
const COL_BOX: int = GMSprite.COL_AABB
const ALL: int = -3
const NOONE: int = -4
const INV_CELL: float = 1.0 / 16.0
## 查询范围超过这么多格时改为扫实例表
const MAX_QUERY_CELLS: int = 4096

## 格子键 → 该格内的实例数组
var grid: Dictionary = {}
## 位置或遮罩变了、还没重新入格的实例
var dirty: Array[GMObject] = []
var _stamp: int = 0
var _cand: Array = []
var _empty: Array = []


func clear() -> void:
	grid.clear()
	dirty.clear()


static func _key(gx: int, gy: int) -> int:
	return ((gx + 32768) & 0xFFFF) | (((gy + 32768) & 0xFFFF) << 16)


func remove(inst: GMObject) -> void:
	if not inst._in_grid:
		return
	inst._in_grid = false
	for gy: int in range(inst._gy0, inst._gy1 + 1):
		for gx: int in range(inst._gx0, inst._gx1 + 1):
			var k: int = _key(gx, gy)
			var a: Array = grid[k]
			a.erase(inst)
			if a.is_empty():
				grid.erase(k)


func flush() -> void:
	if dirty.is_empty():
		return
	for inst: GMObject in dirty:
		inst._grid_dirty = false
		if inst._destroyed:
			remove(inst)
			continue
		if inst._bb_dirty:
			inst._bb_update()
		if inst._mask_spr == null:
			remove(inst)
			continue
		var x0: int = floori(inst._bl / CELL)
		var y0: int = floori(inst._bt / CELL)
		var x1: int = floori(inst._br / CELL)
		var y1: int = floori(inst._bbm / CELL)
		if inst._in_grid:
			if x0 == inst._gx0 and y0 == inst._gy0 and x1 == inst._gx1 and y1 == inst._gy1:
				continue
			remove(inst)
		inst._gx0 = x0
		inst._gy0 = y0
		inst._gx1 = x1
		inst._gy1 = y1
		inst._in_grid = true
		for gy: int in range(y0, y1 + 1):
			for gx: int in range(x0, x1 + 1):
				var k: int = _key(gx, gy)
				var a: Variant = grid.get(k)
				if a == null:
					var fresh: Array[GMObject] = [inst]
					grid[k] = fresh
				else:
					(a as Array[GMObject]).append(inst)
	dirty.clear()


## 取出包围盒可能与矩形 [l, r] × [t, b] 相交的实例（不去重于单格情形，调用方不得修改返回值）
func _collect(l: float, t: float, r: float, b: float) -> Array:
	if not dirty.is_empty():
		flush()
	var x0: int = floori(l * INV_CELL)
	var y0: int = floori(t * INV_CELL)
	var x1: int = floori(r * INV_CELL)
	var y1: int = floori(b * INV_CELL)
	if x0 == x1 and y0 == y1:
		var a: Variant = grid.get(_key(x0, y0))
		return _empty if a == null else a
	if (x1 - x0 + 1) * (y1 - y0 + 1) > MAX_QUERY_CELLS:
		_cand.clear()
		for inst: GMObject in GM.instances:
			if inst._in_grid and not inst._destroyed:
				_cand.append(inst)
		return _cand
	_stamp += 1
	var st: int = _stamp
	_cand.clear()
	for gy: int in range(y0, y1 + 1):
		for gx: int in range(x0, x1 + 1):
			var c: Variant = grid.get(_key(gx, gy))
			if c == null:
				continue
			for inst: GMObject in c:
				if inst._qstamp != st:
					inst._qstamp = st
					_cand.append(inst)
	return _cand


# ---------------------------------------------------------------- 查询

func rectangle(me: GMObject, x1: float, y1: float, x2: float, y2: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	var oid: int = ALL
	var oinst: GMObject = null
	if typeof(obj) == TYPE_INT:
		oid = obj
		if oid == NOONE:
			return null
	elif typeof(obj) == TYPE_OBJECT:
		if not is_instance_valid(obj):
			return null
		oinst = obj
	elif obj == null:
		return null
	else:
		oid = int(obj)
		if oid == NOONE:
			return null
	if not dirty.is_empty():
		flush()
	var bl: float = x1
	var br: float = x2
	if x2 < x1:
		bl = x2
		br = x1
	var bt: float = y1
	var bb: float = y2
	if y2 < y1:
		bt = y2
		bb = y1
	# 判定条件（runner 的 Collision_Rectangle，compatibility 模式）：
	#   bl < bbox.right + 1 且 br >= bbox.left 且 bt < bbox.bottom + 1 且 bb >= bbox.top
	var bl1: float = bl - 1.0
	var bt1: float = bt - 1.0
	var gx0: int = floori(bl1 * INV_CELL)
	var gy0: int = floori(bt1 * INV_CELL)
	var gx1: int = floori(br * INV_CELL)
	var gy1: int = floori(bb * INV_CELL)
	var best: GMObject = null
	if (gx1 - gx0 + 1) * (gy1 - gy0 + 1) > MAX_QUERY_CELLS:
		for inst: GMObject in GM.instances:
			if oinst != null:
				if inst != oinst:
					continue
			elif oid != ALL and inst._isa[oid] == 0:
				continue
			if not inst._in_grid or inst._br <= bl1 or br < inst._bl or inst._bbm <= bt1 or bb < inst._bt:
				continue
			if not inst._active or inst._destroyed or (notme and inst == me):
				continue
			if prec and inst._colcheck != COL_BOX and not inst._mask_spr.masks.is_empty():
				if not _precise_rect(inst, GM.gm_round(bl), GM.gm_round(bt), GM.gm_round(br), GM.gm_round(bb)):
					continue
			if best == null or inst._uid < best._uid:
				best = inst
		return best
	# 跨多格的实例会被看到多次，重复判定不影响结果（取创建最早的）
	for gy: int in range(gy0, gy1 + 1):
		var ky: int = ((gy + 32768) & 0xFFFF) << 16
		for gx: int in range(gx0, gx1 + 1):
			var c: Variant = grid.get(((gx + 32768) & 0xFFFF) | ky)
			if c == null:
				continue
			var cell: Array[GMObject] = c
			for inst: GMObject in cell:
				if oinst != null:
					if inst != oinst:
						continue
				elif oid != ALL and inst._isa[oid] == 0:
					continue
				if inst._br <= bl1 or br < inst._bl or inst._bbm <= bt1 or bb < inst._bt:
					continue
				if not inst._active or (notme and inst == me):
					continue
				if prec and inst._colcheck != COL_BOX and not inst._mask_spr.masks.is_empty():
					if not _precise_rect(inst, GM.gm_round(bl), GM.gm_round(bt), GM.gm_round(br), GM.gm_round(bb)):
						continue
				if best == null or inst._uid < best._uid:
					best = inst
	return best


func point(me: GMObject, px: float, py: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	var oid: int = ALL
	var oinst: GMObject = null
	if typeof(obj) == TYPE_INT:
		oid = obj
		if oid == NOONE:
			return null
	elif typeof(obj) == TYPE_OBJECT:
		if not is_instance_valid(obj):
			return null
		oinst = obj
	elif obj == null:
		return null
	else:
		oid = int(obj)
		if oid == NOONE:
			return null
	var best: GMObject = null
	for inst: GMObject in _collect(px - 1.0, py - 1.0, px, py):
		if oinst != null:
			if inst != oinst:
				continue
		elif oid != ALL and inst._isa[oid] == 0:
			continue
		if not inst._active or (notme and inst == me):
			continue
		if not point_test(inst, px, py, prec):
			continue
		if best == null or inst._uid < best._uid:
			best = inst
	return best


## 单个实例对点的判定（鼠标事件也用它）。调用前实例的包围盒必须是最新的。
func point_test(inst: GMObject, px: float, py: float, prec: bool) -> bool:
	if inst._mask_spr == null:
		return false
	if px >= inst._br + 1.0 or px < inst._bl or py >= inst._bbm + 1.0 or py < inst._bt:
		return false
	if not prec or inst._colcheck == COL_BOX or inst._mask_spr.masks.is_empty():
		return true
	var s: GMSprite = inst._mask_spr
	var img: int = s.wrap_mask_index(floori(inst.image_index))
	var ix: float = GM.gm_round(inst.x) - 0.5
	var iy: float = GM.gm_round(inst.y) - 0.5
	var qx: float = GM.gm_round(px)
	var qy: float = GM.gm_round(py)
	var xx: float
	var yy: float
	if absf(inst.image_angle) < 0.0001:
		xx = (qx - ix) / inst.image_xscale + s.xo
		yy = (qy - iy) / inst.image_yscale + s.yo
	else:
		var ss: float = sin(-inst.image_angle * PI / 180.0)
		var cc: float = cos(-inst.image_angle * PI / 180.0)
		xx = (cc * (qx - ix) + ss * (qy - iy)) / inst.image_xscale + s.xo
		yy = (cc * (qy - iy) - ss * (qx - ix)) / inst.image_yscale + s.yo
	return s.mask_set(img, xx, yy, true)


func line(me: GMObject, x1: float, y1: float, x2: float, y2: float, obj: Variant, prec: bool, notme: bool) -> GMObject:
	var oid: int = ALL
	var oinst: GMObject = null
	if typeof(obj) == TYPE_INT:
		oid = obj
		if oid == NOONE:
			return null
	elif typeof(obj) == TYPE_OBJECT:
		if not is_instance_valid(obj):
			return null
		oinst = obj
	elif obj == null:
		return null
	else:
		oid = int(obj)
		if oid == NOONE:
			return null
	var best: GMObject = null
	for inst: GMObject in _collect(minf(x1, x2) - 1.0, minf(y1, y2) - 1.0, maxf(x1, x2), maxf(y1, y2)):
		if oinst != null:
			if inst != oinst:
				continue
		elif oid != ALL and inst._isa[oid] == 0:
			continue
		if not inst._active or (notme and inst == me):
			continue
		if not _line_test(inst, x1, y1, x2, y2, prec):
			continue
		if best == null or inst._uid < best._uid:
			best = inst
	return best


## place_meeting / instance_place：把 me 假想放到 (px, py)，找与它重叠的 obj 实例（恒为精确判定）
func place(me: GMObject, px: float, py: float, obj: Variant) -> GMObject:
	var oid: int = ALL
	var oinst: GMObject = null
	if typeof(obj) == TYPE_INT:
		oid = obj
		if oid == NOONE:
			return null
	elif typeof(obj) == TYPE_OBJECT:
		if not is_instance_valid(obj):
			return null
		oinst = obj
	elif obj == null:
		return null
	else:
		oid = int(obj)
		if oid == NOONE:
			return null
	if not dirty.is_empty():
		flush()
	if me._bb_dirty:
		me._bb_update()
	if me._mask_spr == null:
		return null
	var sl: float = me._bl
	var st: float = me._bt
	var sr: float = me._br
	var sb: float = me._bbm
	me._bb_calc(px, py)
	var l: float = me._bl
	var t: float = me._bt
	var r: float = me._br
	var b: float = me._bbm
	me._bl = sl
	me._bt = st
	me._br = sr
	me._bbm = sb
	var best: GMObject = null
	for inst: GMObject in _collect(l - 1.0, t - 1.0, r + 1.0, b + 1.0):
		if inst == me or not inst._active:
			continue
		if oinst != null:
			if inst != oinst:
				continue
		elif oid != ALL and inst._isa[oid] == 0:
			continue
		if inst._bl >= r + 1.0 or inst._br + 1.0 <= l or inst._bt >= b + 1.0 or inst._bbm + 1.0 <= t:
			continue
		if me._colcheck != COL_BOX or inst._colcheck != COL_BOX:
			if not _precise_pair(me, px, py, l, t, r, b, inst):
				continue
		if best == null or inst._uid < best._uid:
			best = inst
	return best


## Collision 事件用：a 与 b 在当前位置是否碰撞（精确判定）。两者的包围盒必须是最新的。
func pair_test(a: GMObject, b: GMObject) -> bool:
	if a == b or a._mask_spr == null or b._mask_spr == null:
		return false
	if b._bl >= a._br + 1.0 or b._br + 1.0 <= a._bl or b._bt >= a._bbm + 1.0 or b._bbm + 1.0 <= a._bt:
		return false
	if a._colcheck != COL_BOX or b._colcheck != COL_BOX:
		return _precise_pair(a, a.x, a.y, a._bl, a._bt, a._br, a._bbm, b)
	return true


## 取出包围盒与 a 的包围盒相交的候选实例（Collision 事件用）
func overlapping(a: GMObject) -> Array:
	return _collect(a._bl - 1.0, a._bt - 1.0, a._br + 1.0, a._bbm + 1.0)


# ---------------------------------------------------------------- 精确判定

func _precise_rect(inst: GMObject, rl: float, rt: float, rr: float, rb: float) -> bool:
	var s: GMSprite = inst._mask_spr
	var img: int = s.wrap_mask_index(floori(inst.image_index))
	var l: int = int(maxf(inst._bl, rl))
	var r: int = int(minf(inst._br, rr))
	var t: int = int(maxf(inst._bt, rt))
	var b: int = int(minf(inst._bbm, rb))
	var px: float = GM.gm_round(inst.x) - 0.5
	var py: float = GM.gm_round(inst.y) - 0.5
	var sx: float = inst.image_xscale
	var sy: float = inst.image_yscale
	var w: float = s.width
	var h: float = s.height
	if sx == 1.0 and sy == 1.0 and absf(inst.image_angle) < 0.0001:
		for i: int in range(l, r + 1):
			var xx: float = i - px + s.xo
			if xx < 0.0 or xx >= w:
				continue
			for j: int in range(t, b + 1):
				var yy: float = j - py + s.yo
				if yy < 0.0 or yy >= h:
					continue
				if s.mask_set(img, xx, yy, false):
					return true
	else:
		var ss: float = sin(-inst.image_angle * PI / 180.0)
		var cc: float = cos(-inst.image_angle * PI / 180.0)
		var ivx: float = 1.0 / sx
		var ivy: float = 1.0 / sy
		for i: int in range(l, r + 1):
			for j: int in range(t, b + 1):
				var xx: float = (cc * (i - px) + ss * (j - py)) * ivx + s.xo
				var yy: float = (cc * (j - py) - ss * (i - px)) * ivy + s.yo
				if xx < 0.0 or xx >= w or yy < 0.0 or yy >= h:
					continue
				if s.mask_set(img, xx, yy, true):
					return true
	return false


## runner 的 OrigPreciseCollision。a 假想位于 (ax, ay)，其包围盒为 al/at/ar/ab。
func _precise_pair(a: GMObject, ax: float, ay: float, al: float, at: float, ar: float, ab: float, b: GMObject) -> bool:
	var s1: GMSprite = a._mask_spr
	var s2: GMSprite = b._mask_spr
	var m1: bool = not s1.masks.is_empty()
	var m2: bool = not s2.masks.is_empty()
	var rot: bool = a.image_angle != 0.0 or b.image_angle != 0.0
	if not m1 and not m2 and not rot:
		return true
	var img1: int = s1.wrap_mask_index(int(a.image_index))
	var img2: int = s2.wrap_mask_index(int(b.image_index))
	var l: int = int(maxf(al, b._bl))
	var r: int = int(minf(ar, b._br))
	var t: int = int(maxf(at, b._bt))
	var bm: int = int(minf(ab, b._bbm))
	var x1: float = GM.gm_round(ax)
	var y1: float = GM.gm_round(ay)
	var x2: float = GM.gm_round(b.x)
	var y2: float = GM.gm_round(b.y)
	var w1: float = s1.width
	var h1: float = s1.height
	var w2: float = s2.width
	var h2: float = s2.height
	var xx: float
	var yy: float
	if not rot and a.image_xscale == 1.0 and a.image_yscale == 1.0 and b.image_xscale == 1.0 and b.image_yscale == 1.0:
		for i: int in range(l, r + 1):
			for j: int in range(t, bm + 1):
				xx = i - x1 + s1.xo
				yy = j - y1 + s1.yo
				if xx < 0.0 or xx >= w1 or yy < 0.0 or yy >= h1:
					continue
				if m1 and not s1.mask_set(img1, xx, yy, false):
					continue
				xx = i - x2 + s2.xo
				yy = j - y2 + s2.yo
				if xx < 0.0 or xx >= w2 or yy < 0.0 or yy >= h2:
					continue
				if m2 and not s2.mask_set(img2, xx, yy, false):
					continue
				return true
		return false
	var ivx1: float = 1.0 / a.image_xscale
	var ivy1: float = 1.0 / a.image_yscale
	var ivx2: float = 1.0 / b.image_xscale
	var ivy2: float = 1.0 / b.image_yscale
	if not rot:
		for i: int in range(l, r + 1):
			for j: int in range(t, bm + 1):
				xx = (i - x1) * ivx1 + s1.xo
				yy = (j - y1) * ivy1 + s1.yo
				if xx < 0.0 or xx >= w1 or yy < 0.0 or yy >= h1:
					continue
				if m1 and not s1.mask_set(img1, xx, yy, true):
					continue
				xx = (i - x2) * ivx2 + s2.xo
				yy = (j - y2) * ivy2 + s2.yo
				if xx < 0.0 or xx >= w2 or yy < 0.0 or yy >= h2:
					continue
				if m2 and not s2.mask_set(img2, xx, yy, true):
					continue
				return true
		return false
	var ss1: float = sin(-a.image_angle * PI / 180.0)
	var cc1: float = cos(-a.image_angle * PI / 180.0)
	var ss2: float = sin(-b.image_angle * PI / 180.0)
	var cc2: float = cos(-b.image_angle * PI / 180.0)
	for i: int in range(l, r + 1):
		for j: int in range(t, bm + 1):
			xx = (cc1 * (i - x1) + ss1 * (j - y1)) * ivx1 + s1.xo
			yy = (cc1 * (j - y1) - ss1 * (i - x1)) * ivy1 + s1.yo
			if xx < 0.0 or xx >= w1 or yy < 0.0 or yy >= h1:
				continue
			if m1 and not s1.mask_set(img1, xx, yy, true):
				continue
			xx = (cc2 * (i - x2) + ss2 * (j - y2)) * ivx2 + s2.xo
			yy = (cc2 * (j - y2) - ss2 * (i - x2)) * ivy2 + s2.yo
			if xx < 0.0 or xx >= w2 or yy < 0.0 or yy >= h2:
				continue
			if m2 and not s2.mask_set(img2, xx, yy, true):
				continue
			return true
	return false


func _line_test(inst: GMObject, x1: float, y1: float, x2: float, y2: float, prec: bool) -> bool:
	if inst._mask_spr == null:
		return false
	var bl: float = inst._bl
	var br: float = inst._br + 1.0
	var bt: float = inst._bt
	var bb: float = inst._bbm + 1.0
	if minf(x1, x2) >= br or maxf(x1, x2) < bl or minf(y1, y2) >= bb or maxf(y1, y2) < bt:
		return false
	if x2 < x1:
		var tx: float = x2
		x2 = x1
		x1 = tx
		var ty: float = y2
		y2 = y1
		y1 = ty
	if x1 < bl:
		y1 = y1 + (bl - x1) * (y2 - y1) / (x2 - x1)
		x1 = bl
	if x2 > br:
		y2 = y2 + (br - x2) * (y2 - y1) / (x2 - x1)
		x2 = br
	if (y1 < bt and y2 < bt) or (y1 >= bb and y2 >= bb):
		return false
	if not prec or inst._colcheck == COL_BOX or inst._mask_spr.masks.is_empty():
		return true
	# runner 的 PreciseCollisionLine：沿主轴逐像素取样
	var s: GMSprite = inst._mask_spr
	var img: int = s.wrap_mask_index(floori(inst.image_index))
	var xl: float = GM.gm_round(x1)
	var yl: float = GM.gm_round(y1)
	var xr: float = GM.gm_round(x2)
	var yr: float = GM.gm_round(y2)
	if xl == xr or yl == yr:
		return _precise_rect(inst, xl, minf(yl, yr), xr, maxf(yl, yr))
	var ss: float = sin(-inst.image_angle * PI / 180.0)
	var cc: float = cos(-inst.image_angle * PI / 180.0)
	var px: float = GM.gm_round(inst.x) - 0.5
	var py: float = GM.gm_round(inst.y) - 0.5
	var sx: float = inst.image_xscale
	var sy: float = inst.image_yscale
	if absf(xr - xl) >= absf(yr - yl):
		if xr < xl:
			var t0: float = xr
			xr = xl
			xl = t0
			t0 = yr
			yr = yl
			yl = t0
		var slope: float = (yr - yl) / (xr - xl)
		for i: int in range(int(maxf(inst._bl, xl)), int(minf(inst._br, xr)) + 1):
			var yv: float = yl + (i - xl) * slope
			var xx: float = (cc * (i - px) + ss * (yv - py)) / sx + s.xo
			var yy: float = (cc * (yv - py) - ss * (i - px)) / sy + s.yo
			if s.mask_set(img, xx, yy, true):
				return true
	else:
		if yr < yl:
			var t1: float = xr
			xr = xl
			xl = t1
			t1 = yr
			yr = yl
			yl = t1
		var slope2: float = (xr - xl) / (yr - yl)
		for i: int in range(int(maxf(inst._bt, yl)), int(minf(inst._bbm, yr)) + 1):
			var xv: float = xl + (i - yl) * slope2
			var xx2: float = (cc * (xv - px) + ss * (i - py)) / sx + s.xo
			var yy2: float = (cc * (i - py) - ss * (xv - px)) / sy + s.yo
			if s.mask_set(img, xx2, yy2, true):
				return true
	return false
