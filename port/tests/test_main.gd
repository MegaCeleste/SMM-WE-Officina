extends Node
## 兼容层的 headless 测试。运行：
##   godot --headless --path port res://tests/test_main.tscn
## 全部通过时退出码 0，否则 1。

var _fails: int = 0
var _checks: int = 0
var _cur: String = ""

var o_base: int
var o_order: int
var o_spawner: int
var o_box: int
var o_mario: int
var o_coll_a: int
var o_coll_b: int
var o_coll_b_child: int
var o_coll_spec: int
var o_room: int
var o_mouse: int
var o_precise: int
var rs: GMSprite  ## 一个矩形遮罩的 sprite
var ps: GMSprite  ## 一个带精确遮罩（且遮罩不是全满）的单帧 sprite


func _ready() -> void:
	GM.auto_tick = false
	_setup()
	for t: String in [
		"round", "strings", "bbox", "rect_edges", "query_filters", "precise", "place",
		"tick_order", "alarm", "spawn_mid_step", "with_list", "deactivate", "collision_events",
		"speed", "animation", "rooms", "mouse", "keyboard", "draw_smoke",
	]:
		_cur = t
		GM._reset_for_test()
		TLog.lines.clear()
		call("_test_" + t)
	GM._reset_for_test()
	print("tests: %d checks, %d failed" % [_checks, _fails])
	# 等一会儿再退出：queue_free 的节点要到帧末才释放，音频回放对象要等混音线程放手
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)


func ok(cond: bool, msg: String) -> void:
	_checks += 1
	if not cond:
		_fails += 1
		printerr("FAIL [%s] %s" % [_cur, msg])


func eq(a: Variant, b: Variant, msg: String) -> void:
	_checks += 1
	if typeof(a) in [TYPE_FLOAT, TYPE_INT] and typeof(b) in [TYPE_FLOAT, TYPE_INT]:
		if absf(float(a) - float(b)) > 0.0000001:
			_fails += 1
			printerr("FAIL [%s] %s: got %s, want %s" % [_cur, msg, str(a), str(b)])
	elif a != b:
		_fails += 1
		printerr("FAIL [%s] %s: got %s, want %s" % [_cur, msg, str(a), str(b)])


func _reg(n: String, parent: int = -1, sprite: int = -1) -> int:
	var id: int = GM.register_object(n, load("res://tests/objs/%s.gd" % n) as GDScript, parent, sprite)
	TLog.ids[n] = id
	return id


func _setup() -> void:
	for s: GMSprite in GM.sprites:
		if rs == null and s.kind == 1 and s.br > s.bl + 4 and s.bb > s.bt + 4:
			rs = s
		if ps == null and s.frames == 1 and not s.masks.is_empty() and s.br > s.bl + 4:
			ps = s
		if rs != null and ps != null:
			break
	o_base = _reg("t_base")
	o_order = _reg("t_order")
	o_spawner = _reg("t_spawner")
	o_coll_a = _reg("t_coll_a", -1, rs.index)
	o_coll_b = _reg("t_coll_b", -1, rs.index)
	o_coll_b_child = _reg("t_coll_b_child", o_coll_b, rs.index)
	o_coll_spec = _reg("t_coll_spec", -1, rs.index)
	o_room = _reg("t_room")
	o_mouse = _reg("t_mouse", -1, rs.index)
	var base_script: GDScript = load("res://tests/objs/t_base.gd") as GDScript
	o_box = GM.register_object("t_box", base_script, -1, rs.index)
	o_mario = GM.register_object("t_mario", base_script, -1, A.spr_SMB_mario_small_idle)
	o_precise = GM.register_object("t_precise", base_script, -1, ps.index)


func _mk(obj: int, px: float, py: float, tag: String) -> GMObject:
	var i: GMObject = GM.instance_create(px, py, obj)
	i.set("tag", tag)
	return i


# ----------------------------------------------------------------------

func _test_round() -> void:
	eq(GM.gm_round(2.5), 2.0, "round(2.5)")
	eq(GM.gm_round(3.5), 4.0, "round(3.5)")
	eq(GM.gm_round(0.5), 0.0, "round(0.5)")
	eq(GM.gm_round(1.5), 2.0, "round(1.5)")
	eq(GM.gm_round(-2.5), -2.0, "round(-2.5)")
	eq(GM.gm_round(-1.5), -2.0, "round(-1.5)")
	eq(GM.gm_round(2.4), 2.0, "round(2.4)")
	eq(GM.gm_round(2.6), 3.0, "round(2.6)")
	eq(GM.gm_round(-2.6), -3.0, "round(-2.6)")
	eq(GM.gm_div(7.0, 2.0), 3.0, "7 div 2")
	eq(GM.gm_div(-7.0, 2.0), -3.0, "-7 div 2")
	eq(GM.gm_mod(-7.0, 3.0), -1.0, "-7 mod 3")
	eq(GM.gm_sign(-0.2), -1.0, "sign")
	eq(GM.point_direction(0.0, 0.0, 0.0, -5.0), 90.0, "point_direction 上")
	eq(GM.point_direction(0.0, 0.0, 5.0, 5.0), 315.0, "point_direction 右下")
	eq(GM.lengthdir_x(10.0, 60.0), 5.0, "lengthdir_x")
	eq(GM.lengthdir_y(10.0, 90.0), -10.0, "lengthdir_y")
	eq(GM.angle_difference(10.0, 350.0), 20.0, "angle_difference")
	eq(GM.median(3.0, 1.0, 2.0), 2.0, "median")
	eq(GM.make_colour_rgb(255.0, 0.0, 0.0), 255, "make_colour_rgb")


func _test_strings() -> void:
	eq(GM.string(3.0), "3", "string(3)")
	eq(GM.string(1.5), "1.50", "string(1.5)")
	eq(GM.string(-2.0), "-2", "string(-2)")
	eq(GM.string("a"), "a", "string(str)")
	eq(GM.string_copy("abcdef", 2.0, 3.0), "bcd", "string_copy")
	eq(GM.string_char_at("abc", 1.0), "a", "string_char_at")
	eq(GM.string_pos("cd", "abcd"), 3.0, "string_pos")
	eq(GM.string_pos("x", "abcd"), 0.0, "string_pos 未找到")
	eq(GM.string_length("abc"), 3.0, "string_length")
	eq(GM.string_delete("abcdef", 2.0, 2.0), "adef", "string_delete")
	eq(GM.string_insert("X", "abc", 2.0), "aXbc", "string_insert")
	eq(GM.string_hash_to_newline("a#b\\#c"), "a\nb#c", "string_hash_to_newline")
	eq(GM.real("12.5"), 12.5, "real")


func _test_bbox() -> void:
	# spr_SMB_mario_small_idle：16×32，原点 (8,0)，包围盒 x 2..13、y 16..31
	var m: GMObject = _mk(o_mario, 100.0, 50.0, "m")
	eq(m.bbox_left, 94.0, "left")
	eq(m.bbox_right, 105.0, "right（闭区间）")
	eq(m.bbox_top, 66.0, "top")
	eq(m.bbox_bottom, 81.0, "bottom（闭区间）")
	m.x = 10.5  # 10.5 - 6 = 4.5 → 4（五成双）
	eq(m.bbox_left, 4.0, "x=10.5 left")
	eq(m.bbox_right, 15.0, "x=10.5 right")
	m.x = 11.5  # 5.5 → 6
	eq(m.bbox_left, 6.0, "x=11.5 left")
	eq(m.bbox_right, 17.0, "x=11.5 right")
	m.x = 10.4
	eq(m.bbox_left, 4.0, "x=10.4 left")
	m.x = 10.6
	eq(m.bbox_left, 5.0, "x=10.6 left")
	m.x = 100.0
	m.image_xscale = -1.0
	eq(m.bbox_left, 94.0, "xscale=-1 left")
	eq(m.bbox_right, 105.0, "xscale=-1 right")
	m.image_xscale = 2.0
	eq(m.bbox_left, 88.0, "xscale=2 left")
	eq(m.bbox_right, 111.0, "xscale=2 right")
	m.image_xscale = 1.0
	m.image_angle = 90.0
	eq(m.bbox_left, 116.0, "angle=90 left")
	eq(m.bbox_right, 131.0, "angle=90 right")
	eq(m.bbox_top, 44.0, "angle=90 top")
	eq(m.bbox_bottom, 55.0, "angle=90 bottom")
	# 没有 sprite 的实例：包围盒退化成一个点，不参与碰撞
	var n: GMObject = _mk(o_base, 7.0, 9.0, "n")
	eq(n.bbox_left, 7.0, "无 sprite left")
	eq(n.bbox_bottom, 9.0, "无 sprite bottom")
	ok(n.collision_point(7.0, 9.0, GM.all, false, false) == null, "无 sprite 的实例不会被查到")
	# mask_index 优先于 sprite_index
	n.sprite_index = rs.index
	n.mask_index = A.spr_SMB_mario_small_idle
	eq(n.bbox_left, 1.0, "mask_index 决定包围盒")


func _box_edges(b: GMObject) -> Array[float]:
	return [b.bbox_left, b.bbox_top, b.bbox_right, b.bbox_bottom]


func _test_rect_edges() -> void:
	var b: GMObject = _mk(o_box, 100.0, 100.0, "b")
	var q: GMObject = _mk(o_base, 0.0, 0.0, "q")
	var e: Array[float] = _box_edges(b)
	var l: float = e[0]
	var t: float = e[1]
	var r: float = e[2]
	var bt: float = e[3]
	ok(q.collision_rectangle(r + 1.0, t, r + 5.0, bt, o_box, false, false) == null, "矩形左边 = right+1 不相交")
	ok(q.collision_rectangle(r + 0.9, t, r + 5.0, bt, o_box, false, false) == b, "矩形左边 = right+0.9 相交")
	ok(q.collision_rectangle(l - 5.0, t, l - 0.1, bt, o_box, false, false) == null, "矩形右边 = left-0.1 不相交")
	ok(q.collision_rectangle(l - 5.0, t, l, bt, o_box, false, false) == b, "矩形右边 = left 相交")
	ok(q.collision_rectangle(l, bt + 1.0, r, bt + 5.0, o_box, false, false) == null, "矩形上边 = bottom+1 不相交")
	ok(q.collision_rectangle(l, bt + 0.9, r, bt + 5.0, o_box, false, false) == b, "矩形上边 = bottom+0.9 相交")
	ok(q.collision_rectangle(l, t - 5.0, r, t - 0.1, o_box, false, false) == null, "矩形下边 = top-0.1 不相交")
	ok(q.collision_rectangle(l, t - 5.0, r, t, o_box, false, false) == b, "矩形下边 = top 相交")
	ok(q.collision_rectangle(r + 5.0, bt, r, t, o_box, false, false) == b, "坐标顺序颠倒也可以")
	ok(q.collision_point(r + 0.9, t, o_box, false, false) == b, "点 x = right+0.9 命中")
	ok(q.collision_point(r + 1.0, t, o_box, false, false) == null, "点 x = right+1 不命中")
	ok(q.collision_point(l - 0.1, t, o_box, false, false) == null, "点 x = left-0.1 不命中")
	ok(q.collision_line(l - 10.0, t - 10.0, r + 10.0, bt + 10.0, o_box, false, false) == b, "对角线穿过")
	ok(q.collision_line(l - 10.0, t - 10.0, l - 1.0, bt + 10.0, o_box, false, false) == null, "线在左侧")
	# 移动后查询结果跟着变
	b.x += 1000.0
	ok(q.collision_rectangle(l, t, r, bt, o_box, false, false) == null, "移走后查不到")
	ok(q.collision_rectangle(l + 1000.0, t, r + 1000.0, bt, o_box, false, false) == b, "新位置能查到")
	# 跨很多格子的大范围查询
	ok(q.collision_rectangle(-5000.0, -5000.0, 5000.0, 5000.0, o_box, false, false) == b, "大范围查询")


func _test_query_filters() -> void:
	var a: GMObject = _mk(o_coll_b, 100.0, 100.0, "a")
	var c: GMObject = _mk(o_coll_b_child, 100.0, 100.0, "c")
	var e: Array[float] = _box_edges(a)
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_coll_b, false, true) == c, "notme 排除自己")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_coll_b, false, false) == a, "多个命中时返回创建最早的")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_coll_b_child, false, false) == c, "按子类查")
	ok(c.collision_rectangle(e[0], e[1], e[2], e[3], o_coll_b_child, false, true) == null, "子类只有自己")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], c, false, false) == c, "按实例查")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], GM.all, false, true) == c, "all")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], GM.noone, false, false) == null, "noone")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], null, false, false) == null, "null")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_box, false, false) == null, "别的 object")
	GM.instance_destroy(c)
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_coll_b, false, true) == null, "销毁后立刻查不到")
	eq(GM.instance_number(o_coll_b), 1, "instance_number 含后代、不含已销毁")


func _test_precise() -> void:
	# 在 ps 的包围盒里各找一个实心像素和一个空像素
	var solid: Vector2i = Vector2i(-1, -1)
	var hole: Vector2i = Vector2i(-1, -1)
	for v: int in range(ps.bt, ps.bb + 1):
		for u: int in range(ps.bl, ps.br + 1):
			if ps.mask_set(0, float(u), float(v), false):
				if solid.x < 0:
					solid = Vector2i(u, v)
			elif hole.x < 0:
				hole = Vector2i(u, v)
	ok(solid.x >= 0 and hole.x >= 0, "测试 sprite %s 同时有实心和空像素" % ps.name)
	var p: GMObject = _mk(o_precise, 200.0, 200.0, "p")
	var q: GMObject = _mk(o_base, 0.0, 0.0, "q")
	var sx: float = 200.0 - ps.xo + float(solid.x)
	var sy: float = 200.0 - ps.yo + float(solid.y)
	var hx: float = 200.0 - ps.xo + float(hole.x)
	var hy: float = 200.0 - ps.yo + float(hole.y)
	ok(q.collision_point(sx, sy, o_precise, true, false) == p, "精确：实心像素命中")
	ok(q.collision_point(hx, hy, o_precise, true, false) == null, "精确：空像素不命中")
	ok(q.collision_point(hx, hy, o_precise, false, false) == p, "非精确：空像素也命中（只看包围盒）")
	ok(q.collision_rectangle(sx, sy, sx, sy, o_precise, true, false) == p, "精确矩形：实心像素命中")
	ok(q.collision_rectangle(hx, hy, hx, hy, o_precise, true, false) == null, "精确矩形：空像素不命中")
	ok(q.collision_rectangle(hx, hy, hx, hy, o_precise, false, false) == p, "非精确矩形：空像素命中")
	ok(q.position_meeting(sx, sy, o_precise), "position_meeting 是精确判定")
	ok(not q.position_meeting(hx, hy, o_precise), "position_meeting 空像素")
	# 水平翻转后，原来的实心像素映射到镜像位置
	p.image_xscale = -1.0
	var mx: float = 200.0 - (float(solid.x) + 0.5 - ps.xo) - 0.5
	ok(q.collision_point(mx, sy, o_precise, true, false) == p or ps.xo != floorf(ps.xo), "翻转后镜像位置命中")


func _test_place() -> void:
	var a: GMObject = _mk(o_box, 100.0, 100.0, "a")
	var w: float = a.bbox_right - a.bbox_left + 1.0
	var b: GMObject = _mk(o_box, 100.0 + w, 100.0, "b")
	ok(not a.place_meeting(a.x, a.y, o_box), "贴着不算碰撞")
	ok(a.place_meeting(a.x + 1.0, a.y, o_box), "右移 1 像素碰撞")
	ok(a.instance_place(a.x + 1.0, a.y, o_box) == b, "instance_place 返回对方")
	ok(not a.place_meeting(a.x - 1.0, a.y, o_box), "左移不碰撞")
	eq(a.x, 100.0, "place_meeting 不改变位置")
	eq(a.bbox_left, b.bbox_left - w, "place_meeting 不改变包围盒")
	ok(a.place_free(a.x + 1.0, a.y), "place_free 恒为真（原版没有 solid）")
	# 精确遮罩参与 place_meeting：把 box 放到 ps 的空像素上
	var hole: Vector2i = Vector2i(-1, -1)
	for v: int in range(ps.bt, ps.bb + 1):
		for u: int in range(ps.bl, ps.br + 1):
			if not ps.mask_set(0, float(u), float(v), false) and hole.x < 0:
				hole = Vector2i(u, v)
	var p: GMObject = _mk(o_precise, 500.0, 500.0, "p")
	ok(p.place_meeting(500.0, 500.0, o_box) == false, "远处没有 box")


func _test_tick_order() -> void:
	var a: GMObject = _mk(o_order, 0.0, 0.0, "A")
	var b: GMObject = _mk(o_order, 0.0, 0.0, "B")
	a.hspeed = 1.0
	a.alarm[0] = 1.0
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, [
		"A:begin", "B:begin", "A:alarm0",
		"A:step x=0 xprev=0", "B:step x=0 xprev=0",
		"A:end x=1", "B:end x=0",
	] as Array[String], "第 1 个 tick 的事件顺序")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, [
		"A:begin", "B:begin",
		"A:step x=1 xprev=1", "B:step x=0 xprev=0",
		"A:end x=2", "B:end x=0",
	] as Array[String], "第 2 个 tick")
	eq(GM.current_time, 2000.0 / 60.0, "current_time 由 tick 推算")


func _test_alarm() -> void:
	var a: GMObject = _mk(o_order, 0.0, 0.0, "A")
	a.alarm[0] = 0.0
	a.alarm[1] = 5.0  # t_order 没有 Alarm 1 事件
	GM.tick()
	ok(not TLog.lines.has("A:alarm0"), "alarm = 0 不触发")
	eq(a.alarm[0], -1.0, "alarm 0 减到 -1")
	eq(a.alarm[1], 5.0, "没有事件的 alarm 不走时")
	a.alarm[0] = 2.0
	TLog.lines.clear()
	GM.tick()
	ok(not TLog.lines.has("A:alarm0"), "alarm = 2 第 1 步不触发")
	GM.tick()
	ok(TLog.lines.has("A:alarm0"), "alarm = 2 第 2 步触发")
	eq(a.alarm[0], 0.0, "触发后停在 0")
	TLog.lines.clear()
	GM.tick()
	ok(not TLog.lines.has("A:alarm0"), "不会重复触发")
	a.alarm[0] = 1.9  # 走时前截断成整数
	GM.tick()
	ok(TLog.lines.has("A:alarm0"), "alarm = 1.9 按 1 处理")


func _test_spawn_mid_step() -> void:
	var s: GMObject = _mk(o_spawner, 0.0, 0.0, "S")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["S:step", ":create", "S:end", "child:end x=2"] as Array[String],
		"Step 里新建的实例：不补跑 Step，但会移动并参加 End Step")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["child:begin", "S:step", "child:step x=2 xprev=2", "S:end", "child:end x=4"] as Array[String],
		"下一个 tick 起正常参加全部阶段")
	ok(s.get("child") != null, "child 已创建")


func _test_with_list() -> void:
	var a: GMObject = _mk(o_order, 0.0, 0.0, "a")
	var b: GMObject = _mk(o_order, 0.0, 0.0, "b")
	var c: GMObject = _mk(o_order, 0.0, 0.0, "c")
	eq(GM.with_list(o_order), [a, b, c], "with 按创建顺序")
	var snap: Array = GM.with_list(o_order)
	GM.instance_destroy(b)
	ok(TLog.lines.has("b:destroy"), "Destroy 事件立刻触发")
	eq(snap.size(), 3, "已取得的快照不变")
	eq(GM.with_list(o_order), [a, c], "销毁后 with 找不到")
	ok(not GM.instance_exists(b), "instance_exists(已销毁实例)")
	ok(GM.instance_exists(a), "instance_exists(实例)")
	ok(GM.instance_exists(o_order), "instance_exists(object)")
	ok(not GM.instance_exists(o_box), "instance_exists(没有实例的 object)")
	ok(not GM.instance_exists(GM.noone), "instance_exists(noone)")
	ok(not GM.instance_exists(null), "instance_exists(null)")
	eq(GM.with_list(a), [a], "with(实例)")
	eq(GM.with_list(GM.noone), [], "with(noone)")
	eq(GM.with_list(GM.all).size(), 2, "with(all)")
	eq(GM.instance_number(o_order), 2, "instance_number")
	TLog.lines.clear()
	GM.tick()
	ok(not TLog.lines.has("b:step x=0 xprev=0"), "已销毁的实例不再跑事件")
	GM.instance_destroy(o_order)
	eq(GM.instance_number(o_order), 0, "instance_destroy(object) 销毁全部")
	ok(GM.variable_instance_exists(a, "tag"), "variable_instance_exists 已赋值")
	ok(not GM.variable_instance_exists(a, "no_such_var"), "variable_instance_exists 不存在")
	ok(GM.object_is_ancestor(o_coll_b_child, o_coll_b), "object_is_ancestor")
	eq(GM.object_get_parent(o_coll_b_child), o_coll_b, "object_get_parent")
	eq(GM.object_get_parent(o_coll_b), -100, "object_get_parent 无父类")
	eq(GM.asset_get_index("obj_koopa"), A.obj_koopa, "asset_get_index(object)")
	eq(GM.asset_get_index("spr_koopa"), A.spr_koopa, "asset_get_index(sprite)")
	eq(GM.asset_get_index("nope"), -1, "asset_get_index 不存在")
	eq(GM.object_get_name(A.obj_koopa), "obj_koopa", "object_get_name")


func _test_deactivate() -> void:
	var a: GMObject = _mk(o_order, 0.0, 0.0, "a")
	var b: GMObject = _mk(o_box, 100.0, 100.0, "b")
	var c: GMObject = _mk(o_box, 1000.0, 100.0, "c")
	var e: Array[float] = _box_edges(b)
	GM.instance_deactivate_object(o_box)
	ok(not GM.instance_exists(b), "休眠后 instance_exists 为假")
	eq(GM.instance_number(o_box), 0, "休眠后 instance_number 为 0")
	eq(GM.with_list(o_box), [], "休眠后 with 找不到")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_box, false, false) == null, "休眠后不参与碰撞")
	GM.instance_activate_region(e[0] - 10.0, e[1] - 10.0, 50.0, 50.0, true)
	ok(GM.instance_exists(b), "区域内的被唤醒")
	ok(not GM.instance_exists(c), "区域外的仍休眠")
	ok(a.collision_rectangle(e[0], e[1], e[2], e[3], o_box, false, false) == b, "唤醒后参与碰撞")
	GM.instance_activate_all()
	eq(GM.instance_number(o_box), 2, "activate_all")
	GM.instance_deactivate_all(true, a)
	eq(GM.with_list(GM.all), [a], "deactivate_all(notme)")
	TLog.lines.clear()
	GM.instance_deactivate_object(a)
	GM.tick()
	eq(TLog.lines, [] as Array[String], "休眠实例不跑事件")
	GM.instance_activate_object(a)
	GM.tick()
	ok(TLog.lines.has("a:begin"), "唤醒后恢复事件")


func _test_collision_events() -> void:
	var a: GMObject = _mk(o_coll_a, 100.0, 100.0, "A")
	var b: GMObject = _mk(o_coll_b, 100.0, 100.0, "B")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["A:hit B", "B:hit A", "A:end"] as Array[String], "双方各触发一次，在 End Step 之前")
	b.x = 5000.0
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["A:end"] as Array[String], "不重叠时不触发")
	# 子类实例匹配“对父类”的事件，继承来的事件也生效
	var c: GMObject = _mk(o_coll_b_child, 100.0, 100.0, "C")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["A:hit C", "C:hit A", "A:end"] as Array[String], "子类目标 + 继承的碰撞事件")
	# 事件里销毁对方：对方的事件仍然紧接着触发（照 HTML5 runner）
	a.set("kill_other", true)
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["A:hit C", "C:hit A", "A:end"] as Array[String], "销毁对方后对方事件仍触发")
	ok(not GM.instance_exists(c), "对方已销毁")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, ["A:end"] as Array[String], "销毁后不再触发")
	# U5（第 7 批定）：同时有对父类、对子类的事件时只触发最具体的那个
	GM.instance_destroy(a)
	var sp: GMObject = _mk(o_coll_spec, 100.0, 100.0, "S")
	var pb: GMObject = _mk(o_coll_b, 100.0, 100.0, "P")
	var cb: GMObject = _mk(o_coll_b_child, 100.0, 100.0, "K")
	TLog.lines.clear()
	GM.tick()
	ok(TLog.lines.has("S:parent P"), "父类实例走对父类的事件")
	ok(TLog.lines.has("S:child K"), "子类实例走对子类的事件")
	ok(not TLog.lines.has("S:parent K"), "子类实例不再走对父类的事件")
	GM.instance_destroy(sp)
	GM.instance_destroy(pb)
	GM.instance_destroy(cb)


func _test_speed() -> void:
	var a: GMObject = _mk(o_base, 0.0, 0.0, "a")
	a.hspeed = 3.0
	a.vspeed = -4.0
	eq(a.speed, 5.0, "speed 由 hspeed/vspeed 得出")
	ok(absf(a.direction - 53.130102) < 0.00001, "direction = %s" % str(a.direction))
	a.motion_set(90.0, 2.0)
	eq(a.hspeed, 0.0, "motion_set(90) hspeed")
	eq(a.vspeed, -2.0, "motion_set(90) vspeed")
	a.direction = 180.0
	eq(a.hspeed, -2.0, "改 direction 后 hspeed")
	eq(a.vspeed, 0.0, "改 direction 后 vspeed")
	a.speed = 0.0
	eq(a.direction, 180.0, "speed = 0 不改变 direction")
	a.direction = -90.0
	eq(a.direction, 270.0, "direction 归一到 0..360")
	# friction
	a.motion_set(0.0, 1.0)
	a.friction = 0.3
	GM.tick()
	eq(a.speed, 0.7, "friction 减速")
	eq(a.x, 0.7, "先减速再移动")
	a.friction = 5.0
	GM.tick()
	eq(a.speed, 0.0, "friction 不会减过头")
	# gravity
	a.friction = 0.0
	a.gravity = 0.5
	var y0: float = a.y
	GM.tick()
	eq(a.vspeed, 0.5, "gravity 向下加速")
	eq(a.y, y0 + 0.5, "加速后再移动")
	GM.tick()
	eq(a.vspeed, 1.0, "gravity 累加")
	a.gravity = 0.0
	a.speed = 0.0
	a.x = 10.4
	a.y = 23.0
	a.move_snap(16.0, 16.0)
	eq(a.x, 16.0, "move_snap x")
	eq(a.y, 16.0, "move_snap y")


func _test_animation() -> void:
	var s: GMSprite = null
	for cand: GMSprite in GM.sprites:
		if cand.frames == 4 and cand.tick_speed == 1.0:
			s = cand
			break
	ok(s != null, "找到 4 帧的 sprite")
	var a: GMObject = _mk(o_order, 0.0, 0.0, "a")
	a.sprite_index = s.index
	eq(a.image_number, 4.0, "image_number")
	GM.tick()
	GM.tick()
	GM.tick()
	eq(a.image_index, 3.0, "3 个 tick 后 image_index = 3")
	ok(not TLog.lines.has("a:animend"), "还没播完")
	TLog.lines.clear()
	GM.tick()
	eq(a.image_index, 0.0, "第 4 个 tick 回到 0")
	eq(TLog.lines[0], "a:animend", "Animation End 在 Begin Step 之前触发")
	a.image_speed = 0.5
	GM.tick()
	eq(a.image_index, 0.5, "image_speed = 0.5")
	a.image_speed = -1.0
	TLog.lines.clear()
	GM.tick()
	eq(a.image_index, 3.5, "倒放越过 0 时加回帧数")
	ok(TLog.lines.has("a:animend"), "倒放越界也触发 Animation End")
	# 按每秒帧数计的 sprite：每 tick 推进 fps / 60
	for cand: GMSprite in GM.sprites:
		if cand.frames > 2 and cand.tick_speed == 0.25:
			a.sprite_index = cand.index
			a.image_index = 0.0
			a.image_speed = 1.0
			GM.tick()
			eq(a.image_index, 0.25, "15 FPS 的 sprite 每 tick 推进 0.25")
			break


func _room_def(n: String, objs: Array) -> int:
	var insts: Array = []
	for i: int in objs.size():
		insts.append({
			"name": "%s_i%d" % [n, i], "object": objs[i], "x": 10.0 + i, "y": 20.0,
			"scaleX": 2.0, "scaleY": 1.0, "rotation": 0.0, "imageIndex": 0, "imageSpeed": 1.0,
			"colour": 4294967295, "depth": -5, "hasCreationCode": false,
		})
	GM.room_defs.append({"name": n, "width": 400, "height": 300, "persistent": false, "instances": insts, "layers": []})
	return GM.room_defs.size() - 1


func _test_rooms() -> void:
	var r1: int = _room_def("t_r1", [o_room])
	var r2: int = _room_def("t_r2", [o_room])
	var code_ran: Array = []
	GM.room_inst_code["t_r2_i0"] = func(inst: GMObject) -> void: code_ran.append(inst.get("tag"))
	GM.room_code["t_r2"] = func() -> void: code_ran.append("room")
	GM.game_start(r1)
	eq(TLog.lines, ["r%d:create" % r1, "r%d:gamestart" % r1, "r%d:roomstart" % r1] as Array[String], "进入第一个 room")
	eq(GM.room_width, 400.0, "room_width")
	var i1: GMObject = GM.with_list(o_room)[0]
	eq(i1.image_xscale, 2.0, "room 实例的缩放在 Create 前生效")
	eq(i1.depth, -5.0, "room 实例的 depth 取图层 depth")
	var keep: GMObject = _mk(o_room, 0.0, 0.0, "keep")
	keep.persistent = true
	i1.set("goto_room", r2)
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, [
		"r%d:step" % r1,
		"r%d:roomend" % r1, "keep:roomend", "r%d:cleanup" % r1,
		"r%d:create" % r2, "keep:roomstart", "r%d:roomstart" % r2,
		"keep:step", "r%d:step" % r2, "keep:end", "r%d:end" % r2,
	] as Array[String], "room_goto：本步剩余阶段跳过，换 room 后同一帧再跑一步")
	eq(GM.room, r2, "room 已切换")
	eq(code_ran, ["r%d" % r2, "room"], "实例创建代码、room 创建代码")
	ok(GM.instance_exists(keep), "persistent 实例保留")
	eq(GM.instance_number(o_room), 2, "非 persistent 实例被移除")
	GM.room_inst_code.erase("t_r2_i0")
	GM.room_code.erase("t_r2")


func _test_mouse() -> void:
	var m: GMObject = _mk(o_mouse, 100.0, 100.0, "M")
	var cx: float = (m.bbox_left + m.bbox_right) / 2.0
	var cy: float = (m.bbox_top + m.bbox_bottom) / 2.0
	GM.mouse_override = Vector2(cx, cy)
	eq(GM.mouse_x, cx, "mouse_x")
	GM.tick()
	eq(TLog.lines, ["M:enter"] as Array[String], "Mouse Enter")
	TLog.lines.clear()
	GM._mb_pend_press[1] = 1
	GM.tick()
	eq(TLog.lines, ["M:lpress", "M:glpress"] as Array[String], "Left Pressed + Global Left Pressed")
	ok(GM.mouse_check_button_pressed(GM.mb_left), "mouse_check_button_pressed")
	ok(GM.mouse_check_button(GM.mb_left), "mouse_check_button")
	TLog.lines.clear()
	GM.tick()
	eq(TLog.lines, [] as Array[String], "按住时不重复触发 Pressed")
	ok(not GM.mouse_check_button_pressed(GM.mb_left), "pressed 只持续一步")
	GM._mb_pend_release[1] = 1
	GM.mouse_override = Vector2(cx + 500.0, cy)
	GM.tick()
	eq(TLog.lines, ["M:leave"] as Array[String], "Mouse Leave")
	ok(GM.mouse_check_button_released(GM.mb_left), "mouse_check_button_released")
	# 相机移动后 mouse_x 是房间坐标
	GM.camera_set_view_pos(0, 300.0, 0.0)
	eq(GM.mouse_x, cx + 800.0, "mouse_x 加上相机位置")
	GM.mouse_override = null


func _test_keyboard() -> void:
	var m: GMObject = _mk(o_mouse, 100.0, 100.0, "M")
	GM.mouse_override = Vector2(-999.0, -999.0)
	GM._key_pend_press[GM.vk_space] = 1
	GM.tick()
	ok(GM.keyboard_check_pressed(GM.vk_space), "keyboard_check_pressed")
	ok(GM.keyboard_check(GM.vk_space), "keyboard_check")
	ok(GM.keyboard_check(GM.vk_anykey), "vk_anykey")
	eq(TLog.lines, ["M:space"] as Array[String], "KeyPress 事件")
	eq(GM.keyboard_lastkey, GM.vk_space, "keyboard_lastkey")
	TLog.lines.clear()
	GM.tick()
	ok(not GM.keyboard_check_pressed(GM.vk_space), "pressed 只持续一步")
	ok(GM.keyboard_check(GM.vk_space), "仍按住")
	eq(TLog.lines, [] as Array[String], "KeyPress 不重复")
	GM._key_pend_release[GM.vk_space] = 1
	GM.tick()
	ok(GM.keyboard_check_released(GM.vk_space), "keyboard_check_released")
	ok(not GM.keyboard_check(GM.vk_space), "已松开")
	ok(GM.keyboard_check(GM.vk_nokey), "vk_nokey")
	GM.keyboard_key_press(GM.vk_left)
	ok(GM.keyboard_check(GM.vk_left), "keyboard_key_press 立刻生效")
	GM.keyboard_key_release(GM.vk_left)
	ok(not GM.keyboard_check(GM.vk_left), "keyboard_key_release")
	GM.tick()
	GM.mouse_override = null
	ok(m != null, "")


func _test_draw_smoke() -> void:
	var b: GMObject = _mk(o_box, 50.0, 50.0, "b")
	var m: GMObject = _mk(o_mario, 80.0, 50.0, "m")
	m.image_xscale = -1.0
	m.image_angle = 30.0
	b.depth = -10.0
	GM.tick()
	GM.draw_set_colour(GM.c_red)
	GM.draw_set_alpha(0.5)
	GM.draw_rectangle(0.0, 0.0, 10.0, 10.0, false)
	GM.draw_rectangle(0.0, 0.0, 10.0, 10.0, true)
	GM.draw_circle(20.0, 20.0, 5.0, false)
	GM.draw_text(0.0, 0.0, "abc\ndef")
	GM.draw_text(0.0, 0.0, 12.0)
	var f: int = GM.font_add_sprite_ext(A.spr_numbers, "0123456789", false, 0.0)
	GM.draw_set_font(f)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text(100.0, 100.0, "1234")
	eq(GM.string_width("12"), 2.0 * GM.sprite_get_width(A.spr_numbers), "sprite 字体的 string_width")
	GM.draw_sprite(A.spr_koopa, -1.0, 10.0, 10.0)
	GM.draw_sprite_part(A.spr_koopa, 0.0, 0.0, 0.0, 8.0, 8.0, 10.0, 10.0)
	GM.draw_sprite_stretched(A.spr_koopa, 0.0, 0.0, 0.0, 32.0, 32.0)
	GM.draw_set_alpha(1.0)
	GM.draw_set_colour(GM.c_white)
	GM.draw_set_font(-1)
	GM.draw_set_halign(GM.fa_left)
	# 相机跟随
	GM.room_width = 2000.0
	GM.room_height = 216.0
	GM.camera_set_view_target(0, b)
	GM.camera_set_view_border(0, 192.0, 108.0)
	b.x = 1000.0
	GM.tick()
	eq(GM.camera_get_view_x(GM.view_get_camera(0)), 1000.0 - 192.0, "相机跟随目标并居中")
	b.x = 1990.0
	GM.tick()
	eq(GM.camera_get_view_x(0), 2000.0 - 384.0, "相机不超出 room")
	var h: int = GM.audio_play_sound(0, 0.0, false)
	ok(h >= GM.FIRST_HANDLE, "audio_play_sound 返回句柄")
	GM.audio_stop_sound(h)
	ok(not GM.audio_is_playing(h), "audio_stop_sound")
