extends "res://gm/gm_input.gd"
## 兼容层第 5 层（第 7 批）：粒子系统 part_*。
##
## 原版只有 4 个天气 object（obj_rainmaker/snowmaker/leafmaker/firemaker）用粒子，这里只实现它们
## 用到的函数。语义照 GMS 的旧版粒子 API（part_system_create 等）：
##   - 粒子系统是全局资源，不随 room 清掉，只有 part_system_destroy 才会删（UNVERIFIED U20）；
##   - 自动更新在 End Step 之后、Draw 之前做（gm.gd 的 _step_once，UNVERIFIED U20）；
##   - 一次更新：先按各 emitter 的 stream 生成粒子，再处理寿命（age += 1，age >= life 时消失）、
##     运动（速度、方向的增量，然后按 speed/direction 移动）、外形（大小增量）；
##   - 绘制在 Draw 阶段按系统的 depth 与实例混排，同一 depth 上画在实例之后，旧粒子先画；
##   - wiggle 的周期没有资料，这里取 16 步一个正弦周期，每个粒子相位随机（UNVERIFIED U20）。

const ps_shape_rectangle: int = 0
const ps_shape_ellipse: int = 1
const ps_shape_diamond: int = 2
const ps_shape_line: int = 3
const ps_distr_linear: int = 0
const ps_distr_gaussian: int = 1
const ps_distr_invgaussian: int = 2

const _WIGGLE_PERIOD: float = 16.0


class GMPartType:
	var sprite: int = -1
	var animat: bool = false
	var stretch: bool = false
	var random_frame: bool = false
	var size_min: float = 1.0
	var size_max: float = 1.0
	var size_incr: float = 0.0
	var size_wiggle: float = 0.0
	var life_min: float = 100.0
	var life_max: float = 100.0
	var alpha: float = 1.0
	var colour: int = 0xFFFFFF
	var speed_min: float = 0.0
	var speed_max: float = 0.0
	var speed_incr: float = 0.0
	var speed_wiggle: float = 0.0
	var dir_min: float = 0.0
	var dir_max: float = 0.0
	var dir_incr: float = 0.0
	var dir_wiggle: float = 0.0


class GMParticle:
	var ptype: int = -1
	var x: float = 0.0
	var y: float = 0.0
	var age: float = 0.0
	var life: float = 100.0
	var speed: float = 0.0
	var direction: float = 0.0
	var size: float = 1.0
	var frame: float = 0.0
	var ran: float = 0.0


class GMEmitter:
	var xmin: float = 0.0
	var xmax: float = 0.0
	var ymin: float = 0.0
	var ymax: float = 0.0
	var shape: int = 0
	var distr: int = 0
	var ptype: int = -1
	var number: float = 0.0


class GMPartSystem:
	var depth: float = 0.0
	var automatic_update: bool = true
	var automatic_draw: bool = true
	var emitters: Array = []  ## GMEmitter 或 null（已删）
	var particles: Array[GMParticle] = []


var _part_types: Array = []  ## GMPartType 或 null
var _part_systems: Array = []  ## GMPartSystem 或 null
## 有系统新建、删除或改 depth 时为真；gm.gd 的 _phase_draw 据此重建 depth 列表
var _part_dirty: bool = false


func _psys(ind: float) -> GMPartSystem:
	var i: int = int(ind)
	if i < 0 or i >= _part_systems.size():
		return null
	return _part_systems[i]


func _ptype(ind: float) -> GMPartType:
	var i: int = int(ind)
	if i < 0 or i >= _part_types.size():
		return null
	return _part_types[i]


# ---- 系统 ----

func part_system_create() -> int:
	_part_systems.append(GMPartSystem.new())
	_part_dirty = true
	return _part_systems.size() - 1


func part_system_exists(ind: float) -> bool:
	return _psys(ind) != null


func part_system_destroy(ind: float) -> void:
	if _psys(ind) != null:
		_part_systems[int(ind)] = null
		_part_dirty = true


func part_system_depth(ind: float, d: float) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		ps.depth = d
		_part_dirty = true


func part_system_automatic_update(ind: float, on: Variant) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		ps.automatic_update = truthy(on)


func part_system_automatic_draw(ind: float, on: Variant) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		ps.automatic_draw = truthy(on)


func part_system_clear(ind: float) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		ps.particles.clear()
		ps.emitters.clear()


func part_particles_clear(ind: float) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		ps.particles.clear()


func part_particles_count(ind: float) -> float:
	var ps: GMPartSystem = _psys(ind)
	return float(ps.particles.size()) if ps != null else 0.0


func part_system_update(ind: float) -> void:
	var ps: GMPartSystem = _psys(ind)
	if ps != null:
		_part_update(ps)


# ---- 粒子类型 ----

func part_type_create() -> int:
	_part_types.append(GMPartType.new())
	return _part_types.size() - 1


func part_type_exists(ind: float) -> bool:
	return _ptype(ind) != null


func part_type_destroy(ind: float) -> void:
	if _ptype(ind) != null:
		_part_types[int(ind)] = null


func part_type_sprite(ind: float, spr: int, animat: Variant, stretch: Variant, rand: Variant) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.sprite = spr
		t.animat = truthy(animat)
		t.stretch = truthy(stretch)
		t.random_frame = truthy(rand)


func part_type_size(ind: float, size_min: float, size_max: float, size_incr: float, size_wiggle: float) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.size_min = size_min
		t.size_max = size_max
		t.size_incr = size_incr
		t.size_wiggle = size_wiggle


func part_type_life(ind: float, life_min: float, life_max: float) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.life_min = life_min
		t.life_max = life_max


func part_type_alpha1(ind: float, a: float) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.alpha = a


func part_type_colour1(ind: float, col: int) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.colour = col


func part_type_color1(ind: float, col: int) -> void:
	part_type_colour1(ind, col)


func part_type_speed(ind: float, speed_min: float, speed_max: float, speed_incr: float, speed_wiggle: float) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.speed_min = speed_min
		t.speed_max = speed_max
		t.speed_incr = speed_incr
		t.speed_wiggle = speed_wiggle


func part_type_direction(ind: float, dir_min: float, dir_max: float, dir_incr: float, dir_wiggle: float) -> void:
	var t: GMPartType = _ptype(ind)
	if t != null:
		t.dir_min = dir_min
		t.dir_max = dir_max
		t.dir_incr = dir_incr
		t.dir_wiggle = dir_wiggle


# ---- emitter ----

func part_emitter_create(ps_ind: float) -> int:
	var ps: GMPartSystem = _psys(ps_ind)
	if ps == null:
		return -1
	ps.emitters.append(GMEmitter.new())
	return ps.emitters.size() - 1


func _emitter(ps_ind: float, ind: float) -> GMEmitter:
	var ps: GMPartSystem = _psys(ps_ind)
	if ps == null:
		return null
	var i: int = int(ind)
	if i < 0 or i >= ps.emitters.size():
		return null
	return ps.emitters[i]


func part_emitter_exists(ps_ind: float, ind: float) -> bool:
	return _emitter(ps_ind, ind) != null


func part_emitter_destroy(ps_ind: float, ind: float) -> void:
	if _emitter(ps_ind, ind) != null:
		_psys(ps_ind).emitters[int(ind)] = null


func part_emitter_destroy_all(ps_ind: float) -> void:
	var ps: GMPartSystem = _psys(ps_ind)
	if ps != null:
		ps.emitters.clear()


func part_emitter_region(ps_ind: float, ind: float, xmin: float, xmax: float, ymin: float, ymax: float, shape: int, distr: int) -> void:
	var em: GMEmitter = _emitter(ps_ind, ind)
	if em != null:
		em.xmin = xmin
		em.xmax = xmax
		em.ymin = ymin
		em.ymax = ymax
		em.shape = shape
		em.distr = distr


func part_emitter_stream(ps_ind: float, ind: float, ptype: float, number: float) -> void:
	var em: GMEmitter = _emitter(ps_ind, ind)
	if em != null:
		em.ptype = int(ptype)
		em.number = number


func part_emitter_burst(ps_ind: float, ind: float, ptype: float, number: float) -> void:
	var ps: GMPartSystem = _psys(ps_ind)
	var em: GMEmitter = _emitter(ps_ind, ind)
	if em != null:
		_part_burst(ps, em, int(ptype), number)


func part_particles_create(ps_ind: float, px: float, py: float, ptype: float, number: float) -> void:
	var ps: GMPartSystem = _psys(ps_ind)
	var t: GMPartType = _ptype(ptype)
	if ps == null or t == null:
		return
	for i: int in int(number):
		_part_spawn(ps, t, int(ptype), px, py)


# ---- 内部 ----

func _part_spawn(ps: GMPartSystem, t: GMPartType, ti: int, px: float, py: float) -> void:
	var p: GMParticle = GMParticle.new()
	p.ptype = ti
	p.x = px
	p.y = py
	p.life = floorf(random_range(t.life_min, t.life_max))
	p.speed = random_range(t.speed_min, t.speed_max)
	p.direction = random_range(t.dir_min, t.dir_max)
	p.size = random_range(t.size_min, t.size_max)
	p.ran = random(1.0)
	if t.sprite >= 0 and t.random_frame:
		p.frame = floorf(random(float(sprites[t.sprite].frames)))
	ps.particles.append(p)


## emitter 区域内取一点。线形区域 x、y 用同一个随机数；高斯分布按线性处理（原版只用 linear）
func _part_burst(ps: GMPartSystem, em: GMEmitter, ti: int, number: float) -> void:
	var t: GMPartType = _ptype(ti)
	if ps == null or t == null:
		return
	var n: int = int(number)
	if number < 0.0:
		# 负数：每次有 1/(-number) 的机会生成一个
		n = 1 if random(-number) < 1.0 else 0
	for i: int in n:
		var px: float = 0.0
		var py: float = 0.0
		match em.shape:
			ps_shape_line:
				var r: float = random(1.0)
				px = em.xmin + r * (em.xmax - em.xmin)
				py = em.ymin + r * (em.ymax - em.ymin)
			ps_shape_ellipse:
				var a: float = random(TAU)
				var d: float = sqrt(random(1.0))
				px = (em.xmin + em.xmax) * 0.5 + cos(a) * d * (em.xmax - em.xmin) * 0.5
				py = (em.ymin + em.ymax) * 0.5 + sin(a) * d * (em.ymax - em.ymin) * 0.5
			_:
				px = em.xmin + random(1.0) * (em.xmax - em.xmin)
				py = em.ymin + random(1.0) * (em.ymax - em.ymin)
		_part_spawn(ps, t, ti, px, py)


func _wiggle(p: GMParticle, amount: float) -> float:
	if amount == 0.0:
		return 0.0
	return amount * sin(TAU * (p.age / _WIGGLE_PERIOD + p.ran))


func _part_update(ps: GMPartSystem) -> void:
	for em: Variant in ps.emitters:
		var e: GMEmitter = em
		if e != null and e.number != 0.0:
			_part_burst(ps, e, e.ptype, e.number)
	var keep: Array[GMParticle] = []
	for p: GMParticle in ps.particles:
		p.age += 1.0
		if p.age >= p.life:
			continue
		var t: GMPartType = _ptype(p.ptype)
		if t == null:
			continue
		p.speed = maxf(0.0, p.speed + t.speed_incr)
		p.direction += t.dir_incr
		var spd: float = p.speed + _wiggle(p, t.speed_wiggle)
		var dir: float = p.direction + _wiggle(p, t.dir_wiggle)
		p.x += lengthdir_x(spd, dir)
		p.y += lengthdir_y(spd, dir)
		p.size = maxf(0.0, p.size + t.size_incr)
		if t.animat and not t.stretch:
			p.frame += 1.0
		keep.append(p)
	ps.particles = keep


## gm.gd 在 End Step 之后调用
func _part_update_all() -> void:
	for s: Variant in _part_systems:
		var ps: GMPartSystem = s
		if ps != null and ps.automatic_update:
			_part_update(ps)


func _part_depths() -> Array[float]:
	var out: Array[float] = []
	for s: Variant in _part_systems:
		var ps: GMPartSystem = s
		if ps != null and not out.has(ps.depth):
			out.append(ps.depth)
	return out


## gm.gd 的 _phase_draw 在每个 depth 的实例画完后调用
func _draw_parts_at(d: float) -> void:
	for s: Variant in _part_systems:
		var ps: GMPartSystem = s
		if ps == null or not ps.automatic_draw or ps.depth != d:
			continue
		for p: GMParticle in ps.particles:
			var t: GMPartType = _ptype(p.ptype)
			if t == null:
				continue
			var sz: float = p.size + _wiggle(p, t.size_wiggle)
			if t.sprite >= 0:
				var fr: float = p.frame
				if t.animat and t.stretch:
					fr = floorf(p.age / p.life * float(sprites[t.sprite].frames))
				draw_sprite_ext(t.sprite, fr, p.x, p.y, sz, sz, 0.0, t.colour, t.alpha)
			else:
				# pt_shape_pixel：1 像素
				var c: Color = gm_color(t.colour, t.alpha)
				_reset_xf()
				RenderingServer.canvas_item_add_rect(_ci, Rect2(floorf(p.x), floorf(p.y), maxf(1.0, sz), maxf(1.0, sz)), c)


## 测试用
func _part_reset() -> void:
	_part_systems.clear()
	_part_types.clear()
	_part_dirty = true
