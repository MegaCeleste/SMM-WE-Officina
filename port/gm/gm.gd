extends "res://gm/gm_particles.gd"
## autoload `GM`：实例表、固定 60 tick 的事件循环、room 切换、休眠。
##
## 每个 tick 的阶段顺序照 GameMaker HTML5 runner 的 GameMaker_DoAStep（docs/port-plan.md §4）：
##   锁存输入 → 记录 xprevious + 推进动画 + Animation End → Begin Step → Alarm → 键盘/鼠标事件
##   → Step → 内置运动 → 出界事件 → Collision → End Step → 清理已销毁实例 → Draw / Draw GUI
## 任一阶段里调用了 room_goto，剩余阶段跳过，换完 room 后在同一帧里再跑一个完整的 step。
## 同一阶段内实例按创建顺序执行。 UNVERIFIED(U4)：HTML5 runner 的 Step 类事件是按创建顺序的
## 逆序执行的，Windows runner 的顺序没有资料，这里取创建顺序；顺序只在本文件的各 _phase_* 里出现。

var col: GMCollision = GMCollision.new()

## GML 的 other：Collision 事件执行期间是碰撞的对方；Step/Alarm/Animation End/Draw/Room Start
## 事件执行期间是实例自身（GML 在没有 with/碰撞上下文时 other 等于 self。 UNVERIFIED(U14)：没有实测）；
## 翻译出来的 with 循环会临时把它设成外层实例（port-plan §3.3 第 17 条）；其余时候为 null。
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
var room_setup: Dictionary = {}  ## room 视图等初始设置，在实例 Create 之前应用

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

# Presentation interpolation never changes game state or dispatches Draw again.
var interpolation_auto: bool = true
var interpolation_profile: bool = false
var interpolation_camera_smoothing: bool = true
var prototype_actor: GMObject = null
var _prototype_item: RID = RID()
var _prototype_hud_item: RID = RID()
var _prototype_default_items: Array[RID] = []
var _prototype_default_offsets: Array[Vector2] = []
var _prototype_default_subpixels: Array[Vector2] = []
var _prototype_layer_items: Array[RID] = []
var _prototype_layer_offsets: Array[Vector2] = []
var _prototype_layer_camera_fixed: Array[bool] = []
var _prototype_layer_history: Dictionary = {}
var _rigid_draw_cache: Dictionary = {}
## Draw implementations audited to contain only this actor's body/attachments.
const _RIGID_DRAW_OWNERS: Array[String] = [
	"obj_physicsparent", "obj_1up", "obj_banzaibill", "obj_beachkoopa", "obj_big_pplant",
	"obj_billbanzai_red", "obj_blooper", "obj_bobomb", "obj_bonybeetle", "obj_boo",
	"obj_bulletbill", "obj_bulletbull_red", "obj_buzzy_ceiling", "obj_buzzybeetle",
	"obj_buzzybeetle_b", "obj_charginchuck", "obj_cheepcheep", "obj_coin", "obj_cooligan",
	"obj_crumblebones", "obj_drybones", "obj_egg", "obj_egg_blue", "obj_egg_red",
	"obj_fishbone", "obj_floruga", "obj_floruga_body", "obj_foo", "obj_galoomba",
	"obj_galoomba_b", "obj_grinder", "obj_grrrol", "obj_grrrol_b", "obj_grrrol_new",
	"obj_hammerbro", "obj_jumppiranha", "obj_koopa", "obj_koopa_b", "obj_koopa_red",
	"obj_koopa_red_b", "obj_lakitu", "obj_magikoopa", "obj_mechakoopa", "obj_monty_chase",
	"obj_ninji", "obj_NSMBU_ninji", "obj_piranhaplant", "obj_plant_fire", "obj_podoboo",
	"obj_pokey", "obj_powerupparent", "obj_rocangrejo", "obj_rocky", "obj_sledgebro",
	"obj_spike", "obj_spiny", "obj_superarcon", "obj_thwomp", "obj_waddlewing",
]
var _prototype_actor_prev: Vector2 = Vector2.ZERO
var _prototype_actor_curr: Vector2 = Vector2.ZERO
var _prototype_display_actor: Vector2 = Vector2.ZERO
var _prototype_actor_subpixel: Vector2 = Vector2.ZERO
var _prototype_camera_prev: Vector2 = Vector2.ZERO
var _prototype_camera_curr: Vector2 = Vector2.ZERO
var _prototype_display_camera: Vector2 = Vector2.ZERO
var _prototype_camera_draw: Vector2 = Vector2.ZERO
var _presentation_camera_follow: Vector2 = Vector2.ZERO
var _presentation_camera_history: Array[Vector2] = []
var _presentation_camera_snap: bool = false
var _prototype_valid: bool = false
var prototype_draw_count: int = 0
var prototype_tick_ms: Array[float] = []
var prototype_draw_ms: Array[float] = []
var prototype_present_ms: Array[float] = []


func _ready() -> void:
	process_physics_priority = -1000
	_load_tables()
	_pools.resize(classes.size())
	for i: int in classes.size():
		_pools[i] = []
	_n_active.resize(classes.size())
	_tmp_cnt.resize(classes.size())
	_shell_script = load("res://gm/gm_shell.gd") as GDScript
	GMObject.COL = col
	_inst_root = Node.new()
	_inst_root.name = "GMInstances"
	add_child(_inst_root)
	_init_draw()
	_init_audio()
	_init_input()
	preload("res://rooms/rm_editor.gd").install()
	RenderingServer.frame_pre_draw.connect(_present_interpolation)


func _physics_process(_delta: float) -> void:
	if auto_tick:
		if interpolation_auto:
			_update_interpolation_target()
		var start_us: int = Time.get_ticks_usec() if interpolation_profile and prototype_actor != null else 0
		tick()
		if start_us != 0:
			if prototype_tick_ms.size() >= 3600:
				prototype_tick_ms.clear()
			prototype_tick_ms.append(float(Time.get_ticks_usec() - start_us) / 1000.0)
		fps = Engine.get_frames_per_second()


func _update_interpolation_target() -> void:
	var target: GMObject = null
	var manager: GMObject = instance_find(A.obj_levelmanager, 0)
	if manager != null and float(manager.get("editor")) == 0.0:
		target = instance_find(A.obj_mario, 0)
	var current: GMObject = prototype_actor if is_instance_valid(prototype_actor) else null
	if current != target or (current == null and prototype_actor != null):
		prototype_interpolate_actor(target)


func _present_interpolation() -> void:
	if not _prototype_valid or not _prototype_item.is_valid():
		return
	if get_tree().paused:
		return
	var start_us: int = Time.get_ticks_usec() if interpolation_profile else 0
	var fraction: float = Engine.get_physics_interpolation_fraction()
	var actor_offset: Vector2 = _prototype_actor_prev.lerp(_prototype_actor_curr, fraction) - _prototype_actor_curr + _prototype_actor_subpixel
	_prototype_display_actor = _prototype_actor_prev.lerp(_prototype_actor_curr, fraction)
	var cam: Vector2 = _prototype_camera_prev.lerp(_prototype_camera_curr, fraction)
	_prototype_display_camera = cam
	RenderingServer.canvas_item_set_transform(_prototype_item, Transform2D(0.0, actor_offset))
	for i: int in _prototype_default_offsets.size():
		RenderingServer.canvas_item_set_transform(_prototype_default_items[i], Transform2D(0.0, _prototype_default_offsets[i] * (1.0 - fraction) + _prototype_default_subpixels[i]))
	for i: int in _prototype_layer_offsets.size():
		var offset: Vector2 = cam - _prototype_camera_draw if _prototype_layer_camera_fixed[i] else _prototype_layer_offsets[i] * (1.0 - fraction)
		RenderingServer.canvas_item_set_transform(_prototype_layer_items[i], Transform2D(0.0, offset))
	if _prototype_hud_item.is_valid():
		# The level HUD is recorded in world coordinates relative to the tick camera.
		# Cancel the interpolated camera movement without re-running its Draw event.
		RenderingServer.canvas_item_set_transform(_prototype_hud_item, Transform2D(0.0, cam - _prototype_camera_draw))
	_apply_world_transform(cam)
	if start_us != 0:
		if prototype_present_ms.size() >= 3600:
			prototype_present_ms.clear()
		prototype_present_ms.append(float(Time.get_ticks_usec() - start_us) / 1000.0)


func prototype_interpolate_actor(actor: GMObject) -> void:
	prototype_actor = actor
	_prototype_valid = false
	prototype_draw_count = 0
	prototype_tick_ms.clear()
	prototype_draw_ms.clear()
	prototype_present_ms.clear()
	if not _prototype_item.is_valid():
		_prototype_item = RenderingServer.canvas_item_create()
		RenderingServer.canvas_item_set_parent(_prototype_item, _ci_world)
		_prototype_hud_item = RenderingServer.canvas_item_create()
		RenderingServer.canvas_item_set_parent(_prototype_hud_item, _ci_world)
	else:
		RenderingServer.canvas_item_clear(_prototype_item)
		RenderingServer.canvas_item_clear(_prototype_hud_item)
	for item: RID in _prototype_default_items:
		RenderingServer.canvas_item_clear(item)
	_prototype_default_offsets.clear()
	_prototype_default_subpixels.clear()
	for item: RID in _prototype_layer_items:
		RenderingServer.canvas_item_clear(item)
	_prototype_layer_offsets.clear()
	_prototype_layer_camera_fixed.clear()
	_prototype_layer_history.clear()
	_presentation_camera_history.clear()
	if actor == null:
		_apply_world_transform(Vector2(_cam_x[0], _cam_y[0]))


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
	if not object_exists(obj):
		push_error("GM.instance_create: invalid object %d" % obj)
		return null
	return _spawn(px, py, classes[obj].depth, obj, {})


func instance_create_depth(px: float, py: float, obj_depth: float, obj: int) -> GMObject:
	return _spawn(px, py, obj_depth, obj, {})


## 第 9 批：保留实例引用和变量，只切换对象及其事件表。
## 依据 GameMaker-HTML5 Function_Instance.js instance_change_RELEASE。
func instance_change_inst(inst: GMObject, obj: int, perform_events: bool) -> void:
	if inst._destroyed or not object_exists(obj):
		return
	if perform_events:
		if inst._cls.has_destroy:
			inst.call(&"_destroy")
		if inst._cls.has_cleanup:
			inst.call(&"_cleanup")
	var saved: Dictionary = {}
	var readonly: Array[String] = ["bbox_left", "bbox_top", "bbox_right", "bbox_bottom", "image_number", "sprite_width", "sprite_height", "sprite_xoffset", "sprite_yoffset"]
	col.remove(inst)
	col.dirty.erase(inst)
	inst._grid_dirty = false
	for prop: Dictionary in inst.get_property_list():
		var key: String = prop["name"]
		if int(prop["usage"]) & PROPERTY_USAGE_SCRIPT_VARIABLE and not readonly.has(key):
			saved[key] = inst.get(key)
	var p: int = inst.object_index
	while p >= 0:
		(_pools[p] as Array).erase(inst)
		if inst._active:
			_n_active[p] -= 1
		p = classes[p].parent_id
	var c: GMClass = _class_of(obj)
	inst.set_script(c.gd)
	var declared: Dictionary = {}
	for prop: Dictionary in inst.get_property_list():
		declared[prop["name"]] = true
	# Setters must not enqueue duplicate movers/depth buckets during restoration.
	inst._sp_lock = true
	for key: String in saved:
		if key in ["_uid", "_sp_lock", "_cls", "_isa", "object_index"]:
			continue
		if declared.has(key):
			inst.set(key, saved[key])
		else:
			inst._changed_fields[key] = saved[key]
	inst._sp_lock = bool(saved["_sp_lock"])
	inst._uid = int(saved["_uid"])
	inst._cls = c
	inst._isa = c.is_a
	inst.object_index = obj
	inst.sprite_index = c.sprite
	inst.mask_index = c.mask
	inst.visible = c.visible
	inst.persistent = c.persistent
	p = obj
	while p >= 0:
		var pool: Array = _pools[p]
		var at_index: int = 0
		while at_index < pool.size() and pool[at_index]._uid < inst._uid:
			at_index += 1
		pool.insert(at_index, inst)
		if inst._active:
			_n_active[p] += 1
		p = classes[p].parent_id
	if not c.scanned:
		c.scan(inst, obj_name_to_id)
	_lists_dirty = true
	inst._touch()
	if perform_events and c.has_create:
		inst.call(&"_create")


func _spawn(px: float, py: float, obj_depth: float, obj: int, preset: Dictionary) -> GMObject:
	if not object_exists(obj):
		push_error("GM.instance_create_depth: invalid object %d" % obj)
		return null
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
	# 已释放的实例（销毁后节点已 free）：GMS 里对已销毁的 id 什么都不做（第 7 批）
	if typeof(obj) == TYPE_OBJECT and not is_instance_valid(obj):
		return
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
	# 已释放的实例（销毁后节点已 free）：GMS 里对已销毁的 id 什么都不做（第 7 批）
	if typeof(obj) == TYPE_OBJECT and not is_instance_valid(obj):
		return
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
	# 粒子系统自动更新（第 7 批，UNVERIFIED U20）
	_part_update_all()
	_sweep()
	# A play/edit transition or destroyed player can change the target during
	# this tick; resolve it again before capturing any presentation commands.
	if auto_tick and interpolation_auto:
		_update_interpolation_target()
	_phase_draw()


func _run_list(list: Array[GMObject], method: StringName) -> void:
	var c: int = _create_counter
	_create_counter += 1
	for inst: GMObject in list:
		if inst._cc > c or inst._destroyed or not inst._active:
			continue
		# instance_change may replace a later instance's event table within this phase.
		if not inst.has_method(method):
			continue
		other = inst
		inst.call(method)
		other = null
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
					other = inst
					inst.call(&"_animation_end")
					other = null
			elif inst.image_index < 0.0:
				inst.image_index += num
				if inst._cls.has_animation_end and inst._cc <= c:
					other = inst
					inst.call(&"_animation_end")
					other = null
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
				other = inst
				inst.call(ALARM_NAMES[a])
				other = null
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
		if inst.path_index >= 0:
			if _path_step(inst) and inst._cls.has_path_end and not inst._destroyed:
				inst.call(&"_path_end")


# ---- 路径（第 5 批）----
# 数据：tables/paths.json（tools/gen_paths.py）。行为照 HTML5 runner（yyPath.js、yyInstance.js 的 Adapt_Path），
# UNVERIFIED：没有在 Windows runner 上实测。平滑路径（kind 1）还没实现，按折线走并警告一次。
const path_action_stop: int = 0
const path_action_restart: int = 1
const path_action_continue: int = 2
const path_action_reverse: int = 3

var _paths: Array = []  ## 每个 path：{closed, kind, pts: PackedVector3Array (x, y, speed), cum: PackedFloat64Array, len}
var _paths_warned: Dictionary = {}


func _paths_load() -> void:
	var f: FileAccess = FileAccess.open("res://tables/paths.json", FileAccess.READ)
	if f == null:
		push_error("GM: 读不到 res://tables/paths.json，先运行 tools/gen_paths.py")
		return
	var data: Dictionary = (JSON.parse_string(f.get_as_text()) as Dictionary)["paths"]
	f.close()
	_paths.resize(data.size())
	for k: String in data:
		var d: Dictionary = data[k]
		var pts: PackedVector3Array = PackedVector3Array()
		for p: Array in d["points"]:
			pts.append(Vector3(float(p[0]), float(p[1]), float(p[2])))
		if bool(d["closed"]) and pts.size() > 0:
			pts.append(pts[0])
		var cum: PackedFloat64Array = PackedFloat64Array()
		var total: float = 0.0
		for i: int in pts.size():
			if i > 0:
				total += Vector2(pts[i].x - pts[i - 1].x, pts[i].y - pts[i - 1].y).length()
			cum.append(total)
		_paths[int(d["index"])] = {"name": k, "kind": int(d["kind"]), "pts": pts, "cum": cum, "len": total}


func _path_get(path: int) -> Variant:
	if _paths.is_empty():
		_paths_load()
	if path < 0 or path >= _paths.size():
		return null
	var p: Dictionary = _paths[path]
	if int(p["kind"]) != 0 and not _paths_warned.has(path):
		_paths_warned[path] = true
		push_warning("GM: 平滑路径 %s 还没实现，按折线处理" % p["name"])
	return p


## 路径上 t（0–1）处的 (x, y, speed)，按长度线性插值
func _path_pos(p: Dictionary, t: float) -> Vector3:
	var pts: PackedVector3Array = p["pts"]
	var cum: PackedFloat64Array = p["cum"]
	var n: int = pts.size()
	if n == 0:
		return Vector3(0.0, 0.0, 100.0)
	if n == 1 or float(p["len"]) <= 0.0:
		return pts[0]
	var d: float = clampf(t, 0.0, 1.0) * float(p["len"])
	var i: int = 1
	while i < n - 1 and cum[i] < d:
		i += 1
	var seg: float = cum[i] - cum[i - 1]
	var f: float = 0.0 if seg <= 0.0 else (d - cum[i - 1]) / seg
	return pts[i - 1].lerp(pts[i], f)


func path_get_length(path: int) -> float:
	var p: Variant = _path_get(path)
	return 0.0 if p == null else float((p as Dictionary)["len"])


func path_get_x(path: int, t: float) -> float:
	var p: Variant = _path_get(path)
	return 0.0 if p == null else _path_pos(p, t).x


func path_get_y(path: int, t: float) -> float:
	var p: Variant = _path_get(path)
	return 0.0 if p == null else _path_pos(p, t).y


func path_exists(path: int) -> bool:
	return _path_get(path) != null


func path_add() -> int:
	if _paths.is_empty():
		_paths_load()
	var index: int = _paths.size()
	_paths.append({"name": "__dynamic_path_%d" % index, "kind": 0, "pts": PackedVector3Array(), "cum": PackedFloat64Array(), "len": 0.0})
	return index


func path_add_point(path: int, px: float, py: float, point_speed: float) -> void:
	var p: Variant = _path_get(path)
	if p == null:
		return
	var pts: PackedVector3Array = p["pts"]
	var cum: PackedFloat64Array = p["cum"]
	var total: float = p["len"]
	if not pts.is_empty():
		total += Vector2(px - pts[-1].x, py - pts[-1].y).length()
	pts.append(Vector3(px, py, point_speed))
	cum.append(total)
	p["pts"] = pts
	p["cum"] = cum
	p["len"] = total


func path_start_inst(inst: GMObject, path: int, spd: float, endaction: int, absolute: bool) -> void:
	var p: Variant = _path_get(path)
	if p == null:
		inst.path_index = -1
		return
	inst.path_index = path
	inst.path_speed = spd
	inst.path_endaction = endaction
	inst.path_scale = 1.0
	inst.path_orientation = 0.0
	# UNVERIFIED：速度为负时从终点出发（手册：“负速度表示从终点走向起点”）
	inst.path_position = 1.0 if spd < 0.0 else 0.0
	inst.path_positionprevious = inst.path_position
	if absolute:
		inst._path_xs = 0.0
		inst._path_ys = 0.0
		var a: Vector3 = _path_pos(p, inst.path_position)
		inst.x = a.x
		inst.y = a.y
	else:
		var r: Vector3 = _path_pos(p, inst.path_position)
		inst._path_xs = inst.x - r.x
		inst._path_ys = inst.y - r.y
	if not inst._mv:
		inst._join_movers()


## 沿路径走一步；走到端点时返回 true（触发 Path End）
func _path_step(inst: GMObject) -> bool:
	var p: Variant = _path_get(inst.path_index)
	if p == null:
		inst.path_index = -1
		return false
	var pd: Dictionary = p
	var plen: float = float(pd["len"]) * inst.path_scale
	if plen <= 0.0:
		return false
	var orient: float = inst.path_orientation * PI / 180.0
	var cur: Vector3 = _path_pos(pd, inst.path_position)
	var sp: float = inst.path_speed * cur.z / 100.0
	inst.path_positionprevious = inst.path_position
	inst.path_position += sp / plen
	var ended: bool = false
	if inst.path_position >= 1.0 or inst.path_position <= 0.0:
		ended = true
		match inst.path_endaction:
			path_action_stop:
				inst.path_position = clampf(inst.path_position, 0.0, 1.0)
				inst.path_index = -1
			path_action_restart:
				if inst.path_position >= 1.0:
					inst.path_position -= 1.0
				else:
					inst.path_position += 1.0
			path_action_continue:
				var p0: Vector3 = _path_pos(pd, 0.0)
				var p1: Vector3 = _path_pos(pd, 1.0)
				var xd: float = (p1.x - p0.x) * inst.path_scale
				var yd: float = (p1.y - p0.y) * inst.path_scale
				var xx: float = xd * cos(orient) + yd * sin(orient)
				var yy: float = yd * cos(orient) - xd * sin(orient)
				if inst.path_position >= 1.0:
					inst._path_xs += xx
					inst._path_ys += yy
					inst.path_position -= 1.0
				else:
					inst._path_xs -= xx
					inst._path_ys -= yy
					inst.path_position += 1.0
			path_action_reverse:
				if inst.path_position >= 1.0:
					inst.path_position = 2.0 - inst.path_position
				else:
					inst.path_position = -inst.path_position
				inst.path_speed = -inst.path_speed
	var np: Vector3 = _path_pos(pd, inst.path_position)
	var px: float = np.x * inst.path_scale
	var py: float = np.y * inst.path_scale
	inst.x = inst._path_xs + px * cos(orient) + py * sin(orient)
	inst.y = inst._path_ys + py * cos(orient) - px * sin(orient)
	return ended


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
## UNVERIFIED(U5)：实例同时有“对父类”和“对子类”两个碰撞事件、而对方两者都匹配时，只触发最具体的
## 那个（对方所属类最近的祖先）。第 7 批定（用户确认）：obj_flagpole 对 obj_mario 和 obj_marioU 各有一个事件，
## 原版 NSMBU 画风只走 obj_marioU 的。
## cls 对 target 的碰撞事件是否是它对 other_cls 的实例能用的最具体的事件：cls 没有另一个目标 t2，
## 满足 other_cls 属于 t2、且 t2 是 target 的子类（U5）
func _coll_most_specific(cls: GMClass, other_cls: GMClass, target: int) -> bool:
	if cls.collisions.size() < 2:
		return true
	for h: Array in cls.collisions:
		var t2: int = h[0]
		if t2 != target and other_cls.is_a[t2] != 0 and classes[t2].is_a[target] != 0:
			return false
	return true


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
				if not _coll_most_specific(a._cls, b._cls, target):
					continue
				var key: Vector3i = Vector3i(a._uid, b._uid, target)
				if fired.has(key):
					continue
				fired[key] = true
				other = b
				a.call(h[1], b)
				for hb: Array in b._cls.collisions:
					if a._cls.is_a[hb[0]] != 0 and _coll_most_specific(b._cls, a._cls, hb[0]):
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
	_presentation_camera_follow = Vector2(_cam_x[0], _cam_y[0])
	var t: Variant = _cam_target[view_camera[0]]
	var inst: GMObject = null
	if typeof(t) == TYPE_OBJECT and not is_instance_valid(t):
		return
	if t is GMObject:
		if instance_exists(t):
			inst = t
	elif t != null and int(t) >= 0:
		var l: Array = with_list(int(t))
		if not l.is_empty():
			inst = l[0]
	if inst != null:
		var cam: int = view_camera[0]
		var visual_target: Vector2 = Vector2(inst.x, inst.y)
		if prototype_actor != null and inst.object_index == A.obj_levelmanager and int(inst.get("_presentation_round_tick")) == tick_count:
			visual_target += inst.get("_presentation_round_bias") as Vector2
		_presentation_camera_follow = _camera_follow_position(cam, visual_target.x, visual_target.y)
		_camera_follow(cam, inst.x, inst.y)


## Draw（depth 从大到小；相同 depth 按加入顺序）再 Draw GUI
func _phase_draw() -> void:
	var prototype_draw_start: int = Time.get_ticks_usec() if interpolation_profile and prototype_actor != null else 0
	_update_view_follow()
	if prototype_actor != null:
		_prototype_camera_draw = Vector2(_cam_x[0], _cam_y[0])
		var visual_camera: Vector2 = _smooth_presentation_camera(_presentation_camera_follow)
		_prototype_camera_prev = _prototype_camera_curr if _prototype_valid else visual_camera
		_prototype_camera_curr = visual_camera
		if _presentation_camera_snap or _prototype_camera_curr.distance_to(_prototype_camera_prev) >= 32.0:
			_prototype_camera_prev = _prototype_camera_curr
	_update_layers()
	if _depths_dirty or _layers_dirty or _part_dirty:
		_depths_dirty = false
		_layers_dirty = false
		_part_dirty = false
		_depths.assign(_buckets.keys())
		for ld: float in _layer_depths():
			if not _depths.has(ld):
				_depths.append(ld)
		for pd: float in _part_depths():
			if not _depths.has(pd):
				_depths.append(pd)
		_depths.sort()
		_depths.reverse()
	_ordered_world = prototype_actor != null
	_begin_world_draw()
	if _prototype_item.is_valid():
		RenderingServer.canvas_item_clear(_prototype_item)
		RenderingServer.canvas_item_clear(_prototype_hud_item)
	for i: int in _prototype_default_offsets.size():
		RenderingServer.canvas_item_clear(_prototype_default_items[i])
	_prototype_default_offsets.clear()
	_prototype_default_subpixels.clear()
	for i: int in _prototype_layer_offsets.size():
		RenderingServer.canvas_item_clear(_prototype_layer_items[i])
	_prototype_layer_offsets.clear()
	_prototype_layer_camera_fixed.clear()
	var any_gui: bool = false
	var vx0: float = _cam_x[0]
	var vy0: float = _cam_y[0]
	var vx1: float = vx0 + _cam_w[0]
	var vy1: float = vy0 + _cam_h[0]
	# The displayed camera may lag the logic camera during interpolation.
	var cull_margin: float = 32.0 if prototype_actor != null else 0.0
	for d: float in _depths:
		# 同一 depth 上先画背景图层，再画实例（UNVERIFIED U12）
		for l: GMLayer in _layers_at(d):
			if prototype_actor != null:
				_begin_interpolated_layer(l)
			_draw_layer(l)
			if prototype_actor != null:
				_end_interpolated_item()
		if not _buckets.has(d):
			_draw_parts_at(d)
			continue
		for inst: GMObject in _buckets[d]:
			if not inst._active or inst._destroyed or not inst.visible:
				continue
			var cls: GMClass = inst._cls
			var prototype_this: bool = inst == prototype_actor
			var prototype_hud: bool = prototype_actor != null and inst.object_index == A.obj_levelmanager
			var delta: Vector2 = Vector2(inst.xprevious - inst.x, inst.yprevious - inst.y)
			if delta.length() >= 32.0:
				delta = Vector2.ZERO
			var prototype_custom: bool = prototype_actor != null and cls.has_draw and _rigid_actor_draw(inst)
			var fractional: bool = not GM.eq(inst.x, gm_round(inst.x)) or not GM.eq(inst.y, gm_round(inst.y))
			var prototype_default: bool = prototype_actor != null and (not cls.has_draw and inst.sprite_index >= 0 and delta != Vector2.ZERO or prototype_custom and (delta != Vector2.ZERO or fractional))
			if prototype_this or prototype_hud or prototype_default:
				_reset_xf()
				if prototype_this:
					_ci = _prototype_item
				elif prototype_hud:
					_ci = _prototype_hud_item
				else:
					var slot: int = _prototype_default_offsets.size()
					if slot == _prototype_default_items.size():
						var item: RID = RenderingServer.canvas_item_create()
						RenderingServer.canvas_item_set_parent(item, _ci_world)
						_prototype_default_items.append(item)
					_ci = _prototype_default_items[slot]
					_prototype_default_offsets.append(delta)
					_prototype_default_subpixels.append(Vector2.ZERO)
				RenderingServer.canvas_item_set_draw_index(_ci, _next_world_draw_order())
				_ci_root = _ci
				if _shader_on or _blend_mode != bm_normal:
					_new_segment(_current_material())
			if prototype_this or prototype_custom:
				_prototype_capture_anchor = true
				_prototype_anchor_found = false
			if prototype_this:
				prototype_draw_count += 1
			if cls.has_draw:
				_draw_inst = inst
				other = inst
				inst.call(&"_gm_draw")
				other = null
			else:
				# 默认绘制（draw_self）。画在视野外没有任何可观察的效果，直接跳过。
				var si: int = inst.sprite_index
				if si >= 0:
					var ext: float = sprites[si].cull_r * maxf(absf(inst.image_xscale), absf(inst.image_yscale))
					var ix: float = inst.x
					var iy: float = inst.y
					if ix + ext >= vx0 - cull_margin and ix - ext <= vx1 + cull_margin and iy + ext >= vy0 - cull_margin and iy - ext <= vy1 + cull_margin:
						draw_sprite_ext(si, inst.image_index, ix, iy, inst.image_xscale, inst.image_yscale, inst.image_angle, inst.image_blend, inst.image_alpha)
			if prototype_this or prototype_custom:
				_prototype_capture_anchor = false
			if prototype_this:
				var position: Vector2 = Vector2(inst.x, inst.y)
				_prototype_actor_prev = _prototype_actor_curr if _prototype_valid else position
				_prototype_actor_curr = position
				_prototype_actor_subpixel = Vector2.ZERO
				# Mario's normal Draw rounds x/y; use its physical position for
				# even visual velocity, preserving shake and the current sprite pose.
				# The SMB swimming branch already draws at the raw x/y instead.
				var mario_raw_draw: bool = inst.object_index != A.obj_marioU and G.apariencia == 0.0 and float(inst.get("state")) == 3.0
				if _prototype_anchor_found and not mario_raw_draw:
					_prototype_actor_subpixel = position - Vector2(gm_round(position.x), gm_round(position.y))
				if _prototype_actor_curr.distance_to(_prototype_actor_prev) >= 32.0:
					_prototype_actor_prev = _prototype_actor_curr
				_prototype_valid = true
			elif prototype_custom and prototype_default and _prototype_anchor_found:
				var origin: Vector2 = Vector2(gm_round(inst.x), gm_round(inst.y))
				var relative: Vector2 = _prototype_anchor - origin
				var correction: Vector2 = Vector2.ZERO
				if GM.eq(relative.x, gm_round(relative.x)):
					correction.x = inst.x - origin.x
				if GM.eq(relative.y, gm_round(relative.y)):
					correction.y = inst.y - origin.y
				_prototype_default_subpixels[_prototype_default_subpixels.size() - 1] = correction
			if prototype_this or prototype_hud or prototype_default:
				_end_interpolated_item()
			if cls.has_draw_gui:
				any_gui = true
		_draw_parts_at(d)
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
	if prototype_draw_start != 0:
		if prototype_draw_ms.size() >= 3600:
			prototype_draw_ms.clear()
		prototype_draw_ms.append(float(Time.get_ticks_usec() - prototype_draw_start) / 1000.0)


## These Draw implementations were checked to draw their body and attachments
## relative to their own x/y. Camera-anchored sun, chained geometry and held
## objects require separate handling and deliberately stay on the tick path.
func _rigid_actor_draw(inst: GMObject) -> bool:
	if inst._isa[A.obj_angrysun] != 0 or inst._isa[A.obj_chain_chomp_free] != 0 or inst._isa[A.obj_enemyparent_held] != 0:
		return false
	if inst._cls.name.contains("_held"):
		return false
	if inst._isa[A.obj_enemyparent] == 0 and inst._isa[A.obj_powerupparent] == 0 and inst._isa[A.obj_coin] == 0:
		return false
	if _rigid_draw_cache.has(inst.object_index):
		return _rigid_draw_cache[inst.object_index]
	var script: Script = inst.get_script()
	var owner: String = ""
	while script != null:
		var base: Script = script.get_base_script()
		if _draw_method_count(script) > _draw_method_count(base):
			owner = script.resource_path.get_file().get_basename()
			break
		script = base
	var approved: bool = owner in _RIGID_DRAW_OWNERS
	_rigid_draw_cache[inst.object_index] = approved
	return approved


func _draw_method_count(script: Script) -> int:
	if script == null:
		return 0
	var count: int = 0
	for method: Dictionary in script.get_script_method_list():
		if method.name == "_gm_draw":
			count += 1
	return count


## The original controller rounds its position on every logic tick. Averaging
## completed camera samples reduces that quantization's alternating velocity;
## this is presentation-only and keeps the logical camera untouched.
func _smooth_presentation_camera(position: Vector2) -> Vector2:
	_presentation_camera_snap = false
	if not interpolation_camera_smoothing:
		_presentation_camera_history.clear()
		return position
	if not _presentation_camera_history.is_empty() and position.distance_to(_presentation_camera_history.back()) >= 32.0:
		_presentation_camera_history.clear()
		_presentation_camera_snap = true
	_presentation_camera_history.append(position)
	if _presentation_camera_history.size() > 3:
		_presentation_camera_history.pop_front()
	var total: Vector2 = Vector2.ZERO
	for sample: Vector2 in _presentation_camera_history:
		total += sample
	return total / float(_presentation_camera_history.size())


func _begin_interpolated_layer(layer: GMLayer) -> void:
	_reset_xf()
	var slot: int = _prototype_layer_offsets.size()
	if slot == _prototype_layer_items.size():
		var item: RID = RenderingServer.canvas_item_create()
		RenderingServer.canvas_item_set_parent(item, _ci_world)
		_prototype_layer_items.append(item)
	var position: Vector2 = Vector2(layer.x, layer.y)
	var previous: Vector2 = position
	var history: Dictionary = _prototype_layer_history.get(layer.id, {})
	if not history.is_empty() and int(history["tick"]) == tick_count - 1:
		previous = history["position"]
	var offset: Vector2 = previous - position
	if offset.length() >= 32.0:
		offset = Vector2.ZERO
	_prototype_layer_history[layer.id] = {"position": position, "tick": tick_count}
	var has_sprite: bool = false
	var has_colour: bool = false
	for element: int in layer.elements:
		var background: GMBackground = _bgs.get(element)
		if background != null and background.visible:
			has_sprite = has_sprite or background.sprite >= 0
			has_colour = has_colour or background.sprite < 0
	# A mixed colour/sprite layer cannot be moved safely as one item.
	if has_colour and has_sprite:
		offset = Vector2.ZERO
	_prototype_layer_offsets.append(offset)
	_prototype_layer_camera_fixed.append(has_colour and not has_sprite)
	_ci = _prototype_layer_items[slot]
	RenderingServer.canvas_item_set_draw_index(_ci, _next_world_draw_order())
	_ci_root = _ci
	if _shader_on or _blend_mode != bm_normal:
		_new_segment(_current_material())


func _end_interpolated_item() -> void:
	_reset_xf()
	_ci_root = _ci_world
	_new_segment(_current_material())


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
	if _prototype_item.is_valid():
		prototype_interpolate_actor(null)
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
	var setup: Variant = room_setup.get(def["name"])
	if setup != null:
		(setup as Callable).call()
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
	# PORT（用户定，2026-11-14）：Room Start 中创建的载入器也收到本次事件。
	# 不改动 tick 中各阶段的快照规则；见 port-plan U23。
	var room_start_index: int = 0
	while room_start_index < instances.size():
		var inst: GMObject = instances[room_start_index]
		room_start_index += 1
		if not inst._destroyed and inst._active and inst._cls.has_room_start:
			other = inst
			inst.call(&"_room_start")
			other = null


## 测试用：清掉全部实例和 room 状态
func _reset_for_test() -> void:
	if _prototype_item.is_valid():
		prototype_interpolate_actor(null)
	for inst: GMObject in instances.duplicate():
		_mark_dead(inst)
	_sweep()
	col.clear()
	_buckets.clear()
	_depths.clear()
	_part_reset()
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
	if RenderingServer.frame_pre_draw.is_connected(_present_interpolation):
		RenderingServer.frame_pre_draw.disconnect(_present_interpolation)
	for item: RID in _prototype_layer_items:
		RenderingServer.free_rid(item)
	for item: RID in _prototype_default_items:
		RenderingServer.free_rid(item)
	if _prototype_item.is_valid():
		RenderingServer.free_rid(_prototype_item)
	if _prototype_hud_item.is_valid():
		RenderingServer.free_rid(_prototype_hud_item)
	super._exit_tree()
	for h: int in _players.keys():
		var pl: AudioStreamPlayer = _players[h]
		pl.stop()
		pl.stream = null  # 放掉回放对象，否则刚开始播放就退出时 ObjectDB 报泄漏
	_players.clear()
	_streams.clear()
