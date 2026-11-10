extends Node
## 粗略性能基准：3000 个静止方块 + 200 个每步做 6 次碰撞查询的移动实例。
##   godot --headless --path port res://tests/bench.tscn


func _ready() -> void:
	GM.auto_tick = false
	var rs: GMSprite = null
	for s: GMSprite in GM.sprites:
		if s.kind == 1 and s.width == 16 and s.height == 16:
			rs = s
			break
	var o_box: int = GM.register_object("t_box", load("res://tests/objs/t_base.gd") as GDScript, -1, rs.index)
	TLog.ids["t_box"] = o_box
	var o_mv: int = GM.register_object("t_bench_mover", load("res://tests/objs/t_bench_mover.gd") as GDScript, -1, rs.index)
	for i: int in 3000:
		GM.instance_create(float(i % 200) * 16.0, 200.0 + float(i / 200) * 16.0, o_box)
	for i: int in 200:
		var m: GMObject = GM.instance_create(float(i) * 15.0, 184.0, o_mv)
		m.hspeed = 1.0 + float(i % 3)
	for i: int in 30:
		GM.tick()
	var t0: int = Time.get_ticks_usec()
	for i: int in 300:
		GM.tick()
	var dt: float = float(Time.get_ticks_usec() - t0) / 300.0 / 1000.0
	print("bench: %.3f ms/tick（3000 静止 + 200 移动；60 fps 的预算是 16.7 ms）" % dt)
	# 各阶段分别计时
	var names: Array[String] = ["input", "remember+animate", "step", "positions", "collision", "step_end", "draw"]
	var acc: Array[int] = [0, 0, 0, 0, 0, 0, 0]
	for i: int in 100:
		var t: int = Time.get_ticks_usec()
		GM._input_begin_step()
		acc[0] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._phase_remember_and_animate()
		acc[1] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._refresh_lists()
		GM._run_list(GM._l_step, &"_step")
		acc[2] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._phase_positions()
		acc[3] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._phase_collision()
		acc[4] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._run_list(GM._l_step_end, &"_step_end")
		acc[5] += Time.get_ticks_usec() - t
		t = Time.get_ticks_usec()
		GM._phase_draw()
		acc[6] += Time.get_ticks_usec() - t
	for k: int in names.size():
		print("  %-18s %.3f ms" % [names[k], float(acc[k]) / 100000.0])
	# 每 tick 把全部方块休眠再唤醒视野内的（obj_levelmanager 的做法）
	t0 = Time.get_ticks_usec()
	var td: int = 0
	var ta: int = 0
	var tr: int = 0
	for i: int in 300:
		var t1: int = Time.get_ticks_usec()
		GM.instance_deactivate_object(o_box)
		var t2: int = Time.get_ticks_usec()
		GM.instance_activate_region(0.0, 0.0, 800.0, 600.0, true)
		var t3: int = Time.get_ticks_usec()
		GM._refresh_lists()
		var t4: int = Time.get_ticks_usec()
		td += t2 - t1
		ta += t3 - t2
		tr += t4 - t3
		GM.tick()
	print("  deactivate_object %.3f ms, activate_region %.3f ms, 重建阶段表 %.3f ms" % [float(td) / 300000.0, float(ta) / 300000.0, float(tr) / 300000.0])
	dt = float(Time.get_ticks_usec() - t0) / 300.0 / 1000.0
	print("bench: %.3f ms/tick（同上，外加每 tick 休眠/按区域唤醒）" % dt)
	GM._reset_for_test()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(0)
