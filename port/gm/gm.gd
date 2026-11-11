extends "res://gm/gm_input.gd"
## autoload `GM`：实例表、固定 60 tick 的事件循环、room 切换、休眠。
##
## 每个 tick 的阶段顺序照 GameMaker HTML5 runner 的 GameMaker_DoAStep（docs/port-plan.md §4）：
##   锁存输入 → 记录 xprevious + 推进动画 + Animation End → Begin Step → Alarm → 键盘/鼠标事件
##   → Step → 内置运动 → 出界事件 → Collision → End Step → 清理已销毁实例 → Draw / Draw GUI
## 任一阶段里调用了 room_goto，剩余阶段跳过，换完 room 后在同一帧里再跑一个完整的 step。
## 同一阶段内实例按创建顺序执行。 UNVERIFIED(U4)：HTML5 runner 的 Step 类事件是按创建顺序的
## 逆序执行的，Windows runner 的顺序没有资料，这里取创建顺序；顺序只在本文件的各 _phase_* 里出现。

var col: GMCollision = GMCollision.new()

## GML 的 other：Collision 事件执行期间是碰撞的对方，其余时候为 null。
## 碰撞事件里调用的 user event / 脚本通过它拿到 other（方法参数 other 只在事件方法内可见）。
var other: GMObject = null

## false 时不自动推进，由测试手动调 tick()
var auto_tick: bool = true
var tick_count: int = 0
var current_time: float = 0.0  ## 由 tick 推算，不是墙上时钟（port-plan Q5）
var fps: float = 60.0
var room: int = -1
var room_persistent: bool = false

## room 创建代码：room 名 → Callable()；实例创建代码：room 实例名 → Callable(inst)
var room_code: Dictionary = {}
var room_inst_code: Dictionary = {}

var instances: Array[GMObject] = []  ## 全部存活实例（含休眠），按创建顺序
var _pools: Array = []  ## object 编号 → 该 object 及其后代的实例数组（含休眠）
var _n_active: PackedInt32Array = PackedInt32Array()  ## object 编号 → 活动实例数（含后代）
var _dead: Array[GMObject] = []
var _movers: Array[GMObject] = []  ## 速度/重力/阻力被设过的实例；内置运动阶段只遍历它们
var _inactive_nogrid: Dictionary = {}  ## 休眠且不在碰撞网格里（没有 sprite）的实例
var _tmp_cnt: PackedInt32Array = PackedInt32Array()
var _tmp_touched: Array[int] = []
var _next_uid: int = 1
var _create_counter: int = 0
var _inst_root: Node = null
var _shell_script: GDScript = null
var _shell_warned: Dictionary = {}
var _pending_room: int = -1
var _game_started: bool = false
var _quit_requested: bool = false

# 各阶段的实例表（只含活动实例，按创建顺序）。休眠状态变化或有实例销毁后重建。
var _lists_dirty: bool = true
var _act: Array[GMObject] = []
var _l_step_begin: Array[GMObject] = []
var _l_step: Array[GMObject] = []
var _l_step_end: Array[GMObject] = []
var _l_alarm: Array[GMObject] = []
var _l_coll: Array[GMObject] = []
var _l_mouse: Array[GMObject] = []
var _l_key: Array[GMObject] = []
var _l_other: Array[GMObject] = []
var _l_anim_end: Array[GMObject] = []

# 绘制：按 depth 分桶，桶内按加入顺序
var _buckets: Dictionary = {}
var _depths: Array[float] = []
var _depths_dirty: bool = false


func _ready() -> void:
	process_physics_priority = -1000
	_load_tables()
	_pools.resize(classes.size())
	for i: int in classes.size():
		_pools[i] = []
	_n_active.resize(classes.size())
	_tmp_cnt.resize(classes.size())
	_shell_script = load("res://gm/gm_object.gd") as GDScript
	GMObject.COL = col
	_inst_root = Node.new()
	_inst_root.name = "GMInstances"
	add_child(_inst_root)
	_init_draw()
	_init_audio()
	_init_input()


func _physics_process(_delta: float) -> void:
	if auto_tick:
		tick()
		fps = Engine.get_frames_per_second()


# ======================================================================
# object（类）
# ======================================================================

func _class_of(obj: int) -> GMClass:
	var c: GMClass = classes[obj]
	if c.gd == null:
		var path: String = "res://objects/%s.gd" % c.name
		if ResourceLoader.exists(path):
			c.gd = load(path) as GDScript
		if c.gd == null:
			# 还没移植的 object：用空壳顶上（port-plan R6）
			if not _shell_warned.has(obj):
				_shell_warned[obj] = true
				push_warning("GM: object %s 还没有移植，用空壳代替" % c.name)
			c.gd = _shell_script
	return c


## 注册一个不在 tables 里的 object（测试用）。返回它的编号。
func register_object(obj_name: String, script: GDScript, parent: int = -1, sprite: int = -1, mask: int = -1, obj_depth: float = 0.0) -> int:
	var c: GMClass = GMClass.new()
	c.id = classes.size()
	c.name = obj_name
	c.gd = script
	c.parent_id = parent
	c.sprite = sprite
	c.mask = mask
	c.depth = obj_depth
	classes.append(c)
	obj_name_to_id[obj_name] = c.id
	_pools.append([])
	_n_active.append(0)
	_tmp_cnt.append(0)
	_rebuild_class_ancestry()
	for inst: GMObject in instances:
		inst._isa = inst._cls.is_a
	return c.id


func object_get_name(obj: int) -> String:
	return classes[obj].name if obj >= 0 and obj < classes.size() else "<undefined>"


## 没有父类时返回 -100（与 GMS 一致）
func object_get_parent(obj: int) -> int:
	var p: int = classes[obj].parent_id
	return p if p >= 0 else -100


func object_is_ancestor(obj: int, par: int) -> bool:
	return obj != par and obj >= 0 and par >= 0 and classes[obj].is_a[par] != 0


func object_exists(obj: int) -> bool:
	return obj >= 0 and obj < classes.size()


func object_get_depth(obj: int) -> float:
	return classes[obj].depth if obj >= 0 and obj < classes.size() else 0.0


## 按名字找资源编号。object、sprite、sound、room 各有各的编号空间，调用方知道自己要的是哪一类；
## 同名资源不存在（gen_runtime 已检查），所以按这个顺序查不会混。
func asset_get_index(asset_name: String) -> int:
	if obj_name_to_id.has(asset_name):
		return obj_name_to_id[asset_name]
	if sprite_name_to_id.has(asset_name):
		return sprite_name_to_id[asset_name]
	if sound_name_to_id.has(asset_name):
		return sound_name_to_id[asset_name]
	if room_name_to_id.has(asset_name):
		return room_name_to_id[asset_name]
	return -1


# ======================================================================
# 实例的创建与销毁
# ======================================================================

func instance_create(px: float, py: float, obj: int) -> GMObject:
	return _spawn(px, py, classes[obj].depth, obj, {})


func instance_create_depth(px: float, py: float, obj_depth: float, obj: int) -> GMObject:
	return _spawn(px, py, obj_depth, obj, {})


func _spawn(px: float, py: float, obj_depth: float, obj: int, preset: Dictionary) -> GMObject:
	var c: GMClass = _class_of(obj)
	var inst: GMObject = c.gd.new() as GMObject
	inst._cls = c
	inst._isa = c.is_a
	inst.object_index = obj
	inst._cc = _create_counter
	inst.x = px
	inst.y = py
	inst.xstart = px
	inst.ystart = py
	inst.xprevious = px
	inst.yprevious = py
	inst.sprite_index = c.sprite
	inst.mask_index = c.mask
	inst.visible = c.visible
	inst.persistent = c.persistent
	inst.depth = obj_depth
	if not preset.is_empty():
		# room 编辑器里设的值，在 Create 之前生效
		inst.image_xscale = float(preset["scaleX"])
		inst.image_yscale = float(preset["scaleY"])
		inst.image_angle = float(preset["rotation"])
		inst.image_index = float(preset["imageIndex"])
		inst.image_speed = float(preset["imageSpeed"])
		var raw: int = int(preset["colour"])
		inst.image_blend = raw & 0xFFFFFF
		inst.image_alpha = float((raw >> 24) & 255) / 255.0
		inst._room_inst_name = preset["name"]
	inst._uid = _next_uid
	_next_uid += 1
	instances.append(inst)
	var p: int = obj
	while p >= 0:
		(_pools[p] as Array).append(inst)
		_n_active[p] += 1
		p = classes[p].parent_id
	if not c.scanned:
		c.scan(inst, obj_name_to_id)
	if not _lists_dirty:
		_list_add(inst)
	_bucket_add(inst)
	inst._grid_dirty = true
	col.dirty.append(inst)
	_inst_root.add_child(inst)
	if c.has_create:
		inst.call(&"_create")
	return inst


## 触发 Destroy、CleanUp 事件并标记销毁；节点在本 tick 的清理阶段释放。
func instance_destroy(target: Variant, execute_event: bool = true) -> void:
	if target is GMObject:
		_destroy_one(target, execute_event)
	elif target != null:
		for inst: GMObject in with_list(target):
			_destroy_one(inst, execute_event)


func _destroy_one(inst: GMObject, execute_event: bool) -> void:
	if not is_instance_valid(inst) or inst._destroyed or inst._dying:
		return
	inst._dying = true  # Destroy 事件里再销毁自己不会重入（runner 的 isBeingDestroyed）
	if execute_event and inst._cls.has_destroy:
		inst.call(&"_destroy")
	if inst._cls.has_cleanup:
		inst.call(&"_cleanup")
	_mark_dead(inst)


func _mark_dead(inst: GMObject) -> void:
	if inst._destroyed:
		return
	inst._destroyed = true
	if inst._active:
		var p: int = inst.object_index
		while p >= 0:
			_n_active[p] -= 1
			p = classes[p].parent_id
	col.remove(inst)
	# 还在待重新入格的列表里的话要拿掉：节点释放后 flush 会碰到已释放的对象（第 2 批发现）
	if inst._grid_dirty:
		col.dirty.erase(inst)
		inst._grid_dirty = false
	_dead.append(inst)
	_lists_dirty = true


func _sweep() -> void:
	if _dead.is_empty():
		return
	var movers_dirty: bool = false
	for inst: GMObject in _dead:
		instances.erase(inst)
		var p: int = inst.object_index
		while p >= 0:
			(_pools[p] as Array).erase(inst)
			p = classes[p].parent_id
		var b: Variant = _buckets.get(inst.depth)
		if b != null:
			(b as Array).erase(inst)
		if inst._mv:
			movers_dirty = true
		_inactive_nogrid.erase(inst)
		inst.queue_free()
	_dead.clear()
	if movers_dirty:
		var keep: Array[GMObject] = []
		for inst: GMObject in _movers:
			if not inst._destroyed:
				keep.append(inst)
		_movers = keep


## 实例是否存在：obj 可以是 object 编号（含后代）、实例、all、noone 或 null
func instance_exists(obj: Variant) -> bool:
	if typeof(obj) == TYPE_OBJECT:
		return is_instance_valid(obj) and obj is GMObject and not (obj as GMObject)._destroyed and (obj as GMObject)._active
	if obj == null:
		return false
	var id: int = int(obj)
	if id == all:
		return _count_active_all() > 0
	if id < 0 or id >= classes.size():
		return false
	return _n_active[id] > 0


func instance_number(obj: int) -> int:
	if obj == all:
		return _count_active_all()
	if obj < 0 or obj >= classes.size():
		return 0
	return _n_active[obj]


func _count_active_all() -> int:
	var n: int = 0
	for inst: GMObject in instances:
		if inst._active and not inst._destroyed:
			n += 1
	return n


func instance_find(obj: int, n: int) -> GMObject:
	var l: Array = with_list(obj)
	return l[n] if n >= 0 and n < l.size() else null


## `with (X)` 的目标列表：进入时取快照，按创建顺序（port-plan §3.3 第 3 条）
func with_list(obj: Variant) -> Array:
	if typeof(obj) == TYPE_OBJECT:
		if not is_instance_valid(obj) or not (obj is GMObject):
			return []
		var o: GMObject = obj
		return [o] if not o._destroyed and o._active else []
	if obj == null:
		return []
	var id: int = int(obj)
	var out: Array = []
	if id == all:
		for inst: GMObject in instances:
			if inst._active and not inst._destroyed:
				out.append(inst)
		return out
	if id < 0 or id >= classes.size():
		return out
	for inst: GMObject in _pools[id]:
		if inst._active and not inst._destroyed:
			out.append(inst)
	return out


func instance_furthest(px: float, py: float, obj: Variant) -> GMObject:
	var best: GMObject = null
	var bd: float = -1.0
	for inst: GMObject in with_list(obj):
		var d: float = (inst.x - px) * (inst.x - px) + (inst.y - py) * (inst.y - py)
		if d > bd:
			bd = d
			best = inst
	return best


func instance_nearest(px: float, py: float, obj: Variant) -> GMObject:
	var best: GMObject = null
	var bd: float = INF
	for inst: GMObject in with_list(obj):
		var d: float = (inst.x - px) * (inst.x - px) + (inst.y - py) * (inst.y - py)
		if d < bd:
			bd = d
			best = inst
	return best


## 变量存在性（port-plan §3.3 第 8 条）：没在 Create 里赋值的实例变量声明成不带类型、初值 null，
## “存在”= 类里声明了并且已经赋过值。
func variable_instance_exists(inst: Variant, var_name: String) -> bool:
	if not (inst is Object) or not is_instance_valid(inst):
		return false
	return var_name in inst and (inst as Object).get(var_name) != null


func show_debug_message(v: Variant) -> void:
	print(string(v))


# ======================================================================
# 休眠（instance_deactivate_* / instance_activate_*）
# 休眠实例不跑事件、不参与碰撞、with / instance_exists 找不到；它们仍留在碰撞网格里，
# 查询时按 _active 过滤。
# ======================================================================

func _set_active(inst: GMObject, flag: bool) -> void:
	if inst._active == flag or inst._destroyed:
		return
	_flip(inst, flag)
	_flip_commit(flag)


## 批量开关休眠的两步：_flip 只改标记并按类计数，_flip_commit 再把计数一次性加到 _n_active 上
## （原版每个 tick 都会把几百个实例休眠再唤醒，逐个沿继承链改计数太慢）。
func _flip(inst: GMObject, flag: bool) -> void:
	inst._active = flag
	var oi: int = inst.object_index
	if _tmp_cnt[oi] == 0:
		_tmp_touched.append(oi)
	_tmp_cnt[oi] += 1
	if flag:
		if not inst._in_grid:
			_inactive_nogrid.erase(inst)
	elif not inst._in_grid:
		_inactive_nogrid[inst] = true


func _flip_commit(flag: bool) -> void:
	if _tmp_touched.is_empty():
		return
	for oi: int in _tmp_touched:
		var n: int = _tmp_cnt[oi] if flag else -_tmp_cnt[oi]
		_tmp_cnt[oi] = 0
		var p: int = oi
		while p >= 0:
			_n_active[p] += n
			p = classes[p].parent_id
	_tmp_touched.clear()
	_lists_dirty = true


func instance_deactivate_object(obj: Variant) -> void:
	col.flush()
	if obj is GMObject:
		_set_active(obj, false)
		return
	if obj == null:
		return
	var id: int = int(obj)
	if id == all:
		for inst: GMObject in instances:
			if inst._active and not inst._destroyed:
				_flip(inst, false)
	elif id >= 0 and id < classes.size():
		for inst: GMObject in _pools[id]:
			if inst._active and not inst._destroyed:
				_flip(inst, false)
	_flip_commit(false)


func instance_activate_object(obj: Variant) -> void:
	if obj is GMObject:
		_set_active(obj, true)
		return
	if obj == null:
		return
	var id: int = int(obj)
	if id == all:
		for inst: GMObject in instances:
			if not inst._active and not inst._destroyed:
				_flip(inst, true)
	elif id >= 0 and id < classes.size():
		for inst: GMObject in _pools[id]:
			if not inst._active and not inst._destroyed:
				_flip(inst, true)
	_flip_commit(true)


## GML 的 instance_deactivate_all(notme)；me 是调用者（GML 里是隐含的 self）
func instance_deactivate_all(notme: bool, me: GMObject) -> void:
	col.flush()
	for inst: GMObject in instances:
		if not inst._active or inst._destroyed or (notme and inst == me):
			continue
		_flip(inst, false)
	_flip_commit(false)


func instance_activate_all() -> void:
	for inst: GMObject in instances:
		if not inst._active and not inst._destroyed:
			_flip(inst, true)
	_flip_commit(true)


## 实例的包围盒是否与区域相交；没有 sprite 的实例看它的坐标点
func _in_region(inst: GMObject, left: float, top: float, w: float, h: float) -> bool:
	if inst._bb_dirty:
		inst._bb_update()
	return not (inst._br < left or inst._bl > left + w or inst._bbm < top or inst._bt > top + h)


func instance_activate_region(left: float, top: float, w: float, h: float, inside: bool) -> void:
	col.flush()
	var x0: int = floori(left / GMCollision.CELL)
	var y0: int = floori(top / GMCollision.CELL)
	var x1: int = floori((left + w) / GMCollision.CELL)
	var y1: int = floori((top + h) / GMCollision.CELL)
	var right: float = left + w
	var bottom: float = top + h
	if inside and (x1 - x0 + 1) * (y1 - y0 + 1) < instances.size():
		# 休眠实例仍在网格里：只看区域覆盖的格子，不用扫全部实例
		var grid: Dictionary = col.grid
		for gy: int in range(y0, y1 + 1):
			var ky: int = ((gy + 32768) & 0xFFFF) << 16
			for gx: int in range(x0, x1 + 1):
				var c: Variant = grid.get(((gx + 32768) & 0xFFFF) | ky)
				if c == null:
					continue
				var cell: Array[GMObject] = c
				for inst: GMObject in cell:
					if inst._active or inst._destroyed:
						continue
					if not (inst._br < left or inst._bl > right or inst._bbm < top or inst._bt > bottom):
						_flip(inst, true)
		for inst: GMObject in _inactive_nogrid.keys():
			if _in_region(inst, left, top, w, h):
				_flip(inst, true)
		_flip_commit(true)
		return
	for inst: GMObject in instances:
		if inst._active or inst._destroyed:
			continue
		if _in_region(inst, left, top, w, h) == inside:
			_flip(inst, true)
	_flip_commit(true)


func instance_deactivate_region(left: float, top: float, w: float, h: float, inside: bool, notme: bool, me: GMObject) -> void:
	col.flush()
	for inst: GMObject in instances:
		if not inst._active or inst._destroyed or (notme and inst == me):
			continue
		if _in_region(inst, left, top, w, h) == inside:
			_flip(inst, false)
	_flip_commit(false)


# ======================================================================
# 阶段实例表
# ======================================================================

func _list_add(inst: GMObject) -> void:
	_act.append(inst)
	var m: int = inst._cls.list_mask
	if m == 0:
		return
	if m & 1:
		_l_step_begin.append(inst)
	if m & 2:
		_l_step.append(inst)
	if m & 4:
		_l_step_end.append(inst)
	if m & 8:
		_l_alarm.append(inst)
	if m & 16:
		_l_coll.append(inst)
	if m & 32:
		_l_mouse.append(inst)
	if m & 64:
		_l_key.append(inst)
	if m & 128:
		_l_other.append(inst)
	if m & 256:
		_l_anim_end.append(inst)


func _refresh_lists() -> void:
	if not _lists_dirty:
		return
	_lists_dirty = false
	# 换新数组而不是原地清空：正在遍历旧数组的循环不受影响
	_act = []
	_l_step_begin = []
	_l_step = []
	_l_step_end = []
	_l_alarm = []
	_l_coll = []
	_l_mouse = []
	_l_key = []
	_l_other = []
	_l_anim_end = []
	for inst: GMObject in instances:
		if inst._active and not inst._destroyed:
			if inst._cls.list_mask == 0:
				_act.append(inst)
			else:
				_list_add(inst)


## 一个阶段开始：返回本阶段的计数值。_cc 大于它的实例是阶段开始之后才创建的，本阶段跳过。
func _phase_begin() -> int:
	_refresh_lists()
	var c: int = _create_counter
	_create_counter += 1
	return c


# ======================================================================
# tick
# ======================================================================

func tick() -> void:
	var guard: int = 0
	while guard < 10:
		guard += 1
		_step_once()
		if _pending_room < 0:
			break
		var r: int = _pending_room
		_pending_room = -1
		_switch_room(r)
	if _quit_requested:
		get_tree().quit()


func _step_once() -> void:
	tick_count += 1
	current_time = float(tick_count) * 1000.0 / room_speed
	_input_begin_step()
	_phase_remember_and_animate()
	if _pending_room >= 0:
		_sweep()
		return
	_refresh_lists()
	_run_list(_l_step_begin, &"_step_begin")
	if _pending_room >= 0:
		_sweep()
		return
	_phase_alarm()
	if _pending_room >= 0:
		_sweep()
		return
	_phase_keyboard()
	_phase_mouse()
	if _pending_room >= 0:
		_sweep()
		return
	_refresh_lists()
	_run_list(_l_step, &"_step")
	if _pending_room >= 0:
		_sweep()
		return
	_phase_positions()
	_phase_other()
	if _pending_room >= 0:
		_sweep()
		return
	_phase_collision()
	if _pending_room >= 0:
		_sweep()
		return
	_refresh_lists()
	_run_list(_l_step_end, &"_step_end")
	if _pending_room >= 0:
		_sweep()
		return
	_sweep()
	_phase_draw()


func _run_list(list: Array[GMObject], method: StringName) -> void:
	var c: int = _create_counter
	_create_counter += 1
	for inst: GMObject in list:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		inst.call(method)
		if _pending_room >= 0:
			return


## runner 的 RememberOldPositions（含 Animate）+ UpdateImages
func _phase_remember_and_animate() -> void:
	var c: int = _phase_begin()
	for inst: GMObject in _act:
		if inst._destroyed or not inst._active:
			continue
		inst.xprevious = inst.x
		inst.yprevious = inst.y
		if inst.sprite_index >= 0:
			var s: GMSprite = sprites[inst.sprite_index]
			inst.image_index += inst.image_speed * s.tick_speed
			var num: float = float(s.frames)
			if inst.image_index >= num:
				inst.image_index -= num
				if inst._cls.has_animation_end and inst._cc <= c:
					inst.call(&"_animation_end")
			elif inst.image_index < 0.0:
				inst.image_index += num
				if inst._cls.has_animation_end and inst._cc <= c:
					inst.call(&"_animation_end")
		else:
			# UNVERIFIED(U9)：没有 sprite 的实例，HTML5 runner 会每步都触发 Animation End；
			# 这里只累加 image_index，不触发事件。
			inst.image_index += inst.image_speed
		if _pending_room >= 0:
			return


func _phase_alarm() -> void:
	var c: int = _phase_begin()
	for inst: GMObject in _l_alarm:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		# 只有带对应事件的 alarm 才走时；减到恰好 0 的那一步触发（设成 0 不触发）
		for a: int in inst._cls.alarms:
			var al: float = float(int(inst.alarm[a]))
			if al >= 0.0:
				al -= 1.0
				inst.alarm[a] = al
			if al == 0.0:
				inst.call(ALARM_NAMES[a])
				if _pending_room >= 0:
					return


func _phase_keyboard() -> void:
	if not _any_pressed:
		return
	var c: int = _phase_begin()
	for inst: GMObject in _l_key:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		var kp: Dictionary = inst._cls.keypress
		for vk: int in kp:
			if vk == vk_anykey or _key_pressed[vk] != 0:
				inst.call(kp[vk])


func _phase_mouse() -> void:
	if _l_mouse.is_empty() and not _lists_dirty:
		return
	var c: int = _phase_begin()
	var mx: float = mouse_x
	var my: float = mouse_y
	var none_down: bool = _mb_down[1] == 0 and _mb_down[2] == 0 and _mb_down[3] == 0
	var list: Array[GMObject] = _l_mouse
	col.flush()
	for i: int in range(list.size() - 1, -1, -1):
		var inst: GMObject = list[i]
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		var m: Dictionary = inst._cls.mouse_inst
		if m.is_empty():
			continue
		if inst._bb_dirty:
			inst._bb_update()
		if col.point_test(inst, mx, my, true):
			for b: int in range(1, 4):
				if _mb_down[b] != 0 and m.has(b - 1):
					inst.call(m[b - 1])
				if _mb_pressed[b] != 0 and m.has(b + 3):
					inst.call(m[b + 3])
				if _mb_released[b] != 0 and m.has(b + 6):
					inst.call(m[b + 6])
			if none_down and m.has(3):
				inst.call(m[3])
			if not inst._mouse_over:
				inst._mouse_over = true
				if m.has(10):
					inst.call(m[10])
		elif inst._mouse_over:
			inst._mouse_over = false
			if m.has(11):
				inst.call(m[11])
	for inst: GMObject in list:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		var g: Dictionary = inst._cls.mouse_global
		if g.is_empty():
			continue
		for b: int in range(1, 4):
			if _mb_down[b] != 0 and g.has(49 + b):
				inst.call(g[49 + b])
			if _mb_pressed[b] != 0 and g.has(52 + b):
				inst.call(g[52 + b])
			if _mb_released[b] != 0 and g.has(55 + b):
				inst.call(g[55 + b])
		if _wheel_up and g.has(60):
			inst.call(g[60])
		if _wheel_down and g.has(61):
			inst.call(g[61])


## runner 的 UpdatePositions：这一步里新建的实例也会移动（没有 createCounter 检查）。
## 只遍历 _movers；各实例的移动互不影响，所以遍历顺序无关紧要。
func _phase_positions() -> void:
	for inst: GMObject in _movers:
		if inst._destroyed or not inst._active:
			continue
		if inst.friction != 0.0 or inst.gravity != 0.0:
			inst._adapt_speed()
		if inst.hspeed != 0.0 or inst.vspeed != 0.0:
			inst.x += inst.hspeed
			inst.y += inst.vspeed


## Outside Room（Other_0）、Outside View 0（Other_40）
func _phase_other() -> void:
	_refresh_lists()
	if _l_other.is_empty():
		return
	var c: int = _phase_begin()
	for inst: GMObject in _l_other:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		if inst._bb_dirty:
			inst._bb_update()
		var cls: GMClass = inst._cls
		if cls.has_outside_room:
			var outside: bool = inst._br < 0.0 or inst._bl > room_width or inst._bbm < 0.0 or inst._bt > room_height
			if outside and not inst._was_outside:
				inst._was_outside = true
				inst.call(&"_outside_room")
			else:
				inst._was_outside = outside
		if cls.has_outside_view0 and view_enabled and view_visible[0] and not inst._destroyed:
			if inst._bb_dirty:
				inst._bb_update()
			if inst._br < _cam_x[0] or inst._bl > _cam_x[0] + _cam_w[0] or inst._bbm < _cam_y[0] or inst._bt > _cam_y[0] + _cam_h[0]:
				inst.call(&"_outside_view_0")


## Collision 事件。两个实例重叠（精确判定）时：先触发 a 对 b 的事件，紧接着触发 b 对 a 的事件；
## 同一对实例、同一个事件每 tick 只触发一次。
## UNVERIFIED(U5)：实例同时有“对父类”和“对子类”两个碰撞事件、而对方两者都匹配时，这里两个都触发。
func _phase_collision() -> void:
	_refresh_lists()
	if _l_coll.is_empty():
		return
	var c: int = _phase_begin()
	var fired: Dictionary = {}
	for a: GMObject in _l_coll:
		if a._cc > c or a._destroyed or not a._active:
			continue
		for h: Array in a._cls.collisions:
			var target: int = h[0]
			if _n_active[target] == 0:
				continue
			if a._destroyed or not a._active:
				break
			col.flush()
			if a._bb_dirty:
				a._bb_update()
			if a._mask_spr == null:
				break
			var cands: Array = []
			for b: GMObject in col.overlapping(a):
				if b != a and b._active and not b._destroyed and b._cc <= c and b._cls.is_a[target] != 0:
					cands.append(b)
			if cands.is_empty():
				continue
			if cands.size() > 1:
				cands.sort_custom(func(p: GMObject, q: GMObject) -> bool: return p._uid < q._uid)
			for b: GMObject in cands:
				if a._bb_dirty:
					a._bb_update()
				if b._bb_dirty:
					b._bb_update()
				if not col.pair_test(a, b):
					continue
				var key: Vector3i = Vector3i(a._uid, b._uid, target)
				if fired.has(key):
					continue
				fired[key] = true
				other = b
				a.call(h[1], b)
				for hb: Array in b._cls.collisions:
					if a._cls.is_a[hb[0]] != 0:
						var key2: Vector3i = Vector3i(b._uid, a._uid, hb[0])
						if not fired.has(key2):
							fired[key2] = true
							other = a
							b.call(hb[1], a)
				other = null
				if _pending_room >= 0:
					return


# ======================================================================
# 绘制
# ======================================================================

func _bucket_add(inst: GMObject) -> void:
	var b: Variant = _buckets.get(inst.depth)
	if b == null:
		_buckets[inst.depth] = [inst]
		_depths_dirty = true
	else:
		(b as Array).append(inst)


func _depth_changed(inst: GMObject, old: float) -> void:
	var b: Variant = _buckets.get(old)
	if b != null:
		(b as Array).erase(inst)
	if not inst._destroyed:
		_bucket_add(inst)


func _update_view_follow() -> void:
	var t: Variant = _cam_target[view_camera[0]]
	var inst: GMObject = null
	if t is GMObject:
		if instance_exists(t):
			inst = t
	elif t != null and int(t) >= 0:
		var l: Array = with_list(int(t))
		if not l.is_empty():
			inst = l[0]
	if inst != null:
		_camera_follow(view_camera[0], inst.x, inst.y)


## Draw（depth 从大到小；相同 depth 按加入顺序）再 Draw GUI
func _phase_draw() -> void:
	_update_view_follow()
	_update_layers()
	if _depths_dirty or _layers_dirty:
		_depths_dirty = false
		_layers_dirty = false
		_depths.assign(_buckets.keys())
		for ld: float in _layer_depths():
			if not _buckets.has(ld):
				_depths.append(ld)
		_depths.sort()
		_depths.reverse()
	_begin_world_draw()
	var any_gui: bool = false
	var vx0: float = _cam_x[0]
	var vy0: float = _cam_y[0]
	var vx1: float = vx0 + _cam_w[0]
	var vy1: float = vy0 + _cam_h[0]
	for d: float in _depths:
		# 同一 depth 上先画背景图层，再画实例（UNVERIFIED U12）
		for l: GMLayer in _layers_at(d):
			_draw_layer(l)
		if not _buckets.has(d):
			continue
		for inst: GMObject in _buckets[d]:
			if not inst._active or inst._destroyed or not inst.visible:
				continue
			var cls: GMClass = inst._cls
			if cls.has_draw:
				_draw_inst = inst
				inst.call(&"_gm_draw")
			else:
				# 默认绘制（draw_self）。画在视野外没有任何可观察的效果，直接跳过。
				var si: int = inst.sprite_index
				if si >= 0:
					var ext: float = sprites[si].cull_r * maxf(absf(inst.image_xscale), absf(inst.image_yscale))
					var ix: float = inst.x
					var iy: float = inst.y
					if ix + ext >= vx0 and ix - ext <= vx1 and iy + ext >= vy0 and iy - ext <= vy1:
						draw_sprite_ext(si, inst.image_index, ix, iy, inst.image_xscale, inst.image_yscale, inst.image_angle, inst.image_blend, inst.image_alpha)
			if cls.has_draw_gui:
				any_gui = true
	_reset_xf()
	if any_gui:
		_begin_gui_draw()
		for d: float in _depths:
			if not _buckets.has(d):
				continue
			for inst: GMObject in _buckets[d]:
				if inst._active and not inst._destroyed and inst.visible and inst._cls.has_draw_gui:
					_draw_inst = inst
					inst.call(&"_gm_draw_gui")
		_reset_xf()
	_draw_inst = null


# ======================================================================
# room
# ======================================================================

func room_goto(r: int) -> void:
	if r < 0 or r >= room_defs.size():
		push_error("GM.room_goto: room %d 不存在" % r)
		return
	_pending_room = r


func room_goto_next() -> void:
	room_goto(room + 1)


func room_restart() -> void:
	room_goto(room)


func room_exists(r: int) -> bool:
	return r >= 0 and r < room_defs.size()


func room_get_name(r: int) -> String:
	return room_defs[r]["name"] if room_exists(r) else "<undefined>"


func game_end() -> void:
	# 原版在 Game End 事件里又调了 game_end()（obj_persistent/Other_3.gml），不能重入
	if _quit_requested:
		return
	_quit_requested = true
	for inst: GMObject in with_list(all):
		if inst._cls.has_game_end:
			inst.call(&"_game_end")
	_quit_requested = true


## 启动游戏：进入第一个 room（触发 Game Start 事件）
func game_start(first_room: int) -> void:
	_switch_room(first_room)


func _switch_room(r: int) -> void:
	if room >= 0:
		for inst: GMObject in with_list(all):
			if inst._cls.has_room_end:
				inst.call(&"_room_end")
		# 非 persistent 的实例直接移除：不触发 Destroy，只触发 CleanUp；休眠的也一并移除
		for inst: GMObject in instances.duplicate():
			if not inst.persistent and not inst._destroyed:
				if inst._cls.has_cleanup:
					inst.call(&"_cleanup")
				_mark_dead(inst)
		_sweep()
	room = r
	var def: Dictionary = room_defs[r]
	room_width = float(def["width"])
	room_height = float(def["height"])
	room_persistent = bool(def["persistent"])
	_load_room_layers(def.get("layers", []))
	for it: Dictionary in def["instances"]:
		var inst: GMObject = _spawn(float(it["x"]), float(it["y"]), float(it["depth"]), int(it["object"]), it)
		var code: Variant = room_inst_code.get(it["name"])
		if code != null and not inst._destroyed:
			(code as Callable).call(inst)
	var rc: Variant = room_code.get(def["name"])
	if rc != null:
		(rc as Callable).call()
	if not _game_started:
		_game_started = true
		for inst: GMObject in with_list(all):
			if inst._cls.has_game_start:
				inst.call(&"_game_start")
	for inst: GMObject in with_list(all):
		if inst._cls.has_room_start:
			inst.call(&"_room_start")


## 测试用：清掉全部实例和 room 状态
func _reset_for_test() -> void:
	for inst: GMObject in instances.duplicate():
		_mark_dead(inst)
	_sweep()
	col.clear()
	_buckets.clear()
	_depths.clear()
	_movers.clear()
	_inactive_nogrid.clear()
	_lists_dirty = true
	_pending_room = -1
	room = -1
	_game_started = false
	tick_count = 0
	_create_counter = 0
	_cam_x[0] = 0.0
	_cam_y[0] = 0.0
	_cam_target[0] = noone


func _exit_tree() -> void:
	super._exit_tree()
	for h: int in _players.keys():
		var pl: AudioStreamPlayer = _players[h]
		pl.stop()
		pl.stream = null  # 放掉回放对象，否则刚开始播放就退出时 ObjectDB 报泄漏
	_players.clear()
	_streams.clear()
