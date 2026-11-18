extends Node
## 第 3 批：载入原版关卡样本（docs/samples/3.5.1level1.swe）并进入游玩的 headless 测试。
## 运行：godot --headless --path port res://tests/test_level.tscn
## 走原版链路：rm_logo（建 obj_persistent）→ rm_guardabot_play（obj_load_guardabot 读关卡 → scr_edit_to_play）。

var _fails: int = 0
var _checks: int = 0


func ok(cond: bool, msg: String) -> void:
	_checks += 1
	if not cond:
		_fails += 1
		printerr("FAIL ", msg)


func _count(obj: int) -> int:
	var n: int = 0
	for inst: GMObject in GM.instances:
		if not inst._destroyed and inst._isa[obj] != 0:
			n += 1
	return n


func _ready() -> void:
	GM.auto_tick = false
	GM._reset_for_test()
	GM.random_set_seed(1)
	GM.game_start(A.rm_logo)
	# 把样本放到关卡目录（原版是 working_directory + "Niveles\"）
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	GM.directory_create(G.directorio)
	var dst: String = GM._fix_path(G.directorio + "3.5.1level1.swe")
	DirAccess.copy_absolute(src, dst)
	ok(GM.file_exists(G.directorio + "3.5.1level1.swe"), "样本已复制到关卡目录")
	G.levelguardabot = "3.5.1level1.swe"
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)
	GM.tick()
	ok(GM.room == A.rm_guardabot_play, "进入 rm_guardabot_play（实际 room %d）" % GM.room)
	ok(GM._gameplay_sprite_shadows_enabled(), "载入游玩关卡后启用精灵阴影")
	ok(not GM.classes[A.obj_lava_water].casts_sprite_shadow and not GM.classes[A.obj_lave_draw].casts_sprite_shadow, "整片水面和岩浆不产生拼接暗线")
	ok(G.apariencia == 2.0, "画风 = SMW（%s）" % G.apariencia)
	ok(G.bg_level == "castle", "场景 = castle（%s）" % G.bg_level)
	ok(GM.room_width == 1152.0, "关卡宽度 1152（%s）" % GM.room_width)
	print("instances after load: ", GM.instances.size())
	var by: Dictionary = {}
	for inst: GMObject in GM.instances:
		var n: String = GM.object_get_name(inst.object_index)
		by[n] = int(by.get(n, 0)) + 1
	print(by)
	ok(_count(A.obj_mario) == 1, "有 1 个 obj_mario（%d）" % _count(A.obj_mario))
	ok(_count(A.obj_parent_resource) == 0, "_res 物件已全部换掉（剩 %d）" % _count(A.obj_parent_resource))
	ok(_count(A.obj_galoomba) == 3, "3 个 galoomba（%d）" % _count(A.obj_galoomba))
	ok(_count(A.obj_koopa) == 2, "2 个 koopa（%d）" % _count(A.obj_koopa))
	ok(_count(A.obj_blockparent) == 24, "23 砖 + 1 问号块（%d）" % _count(A.obj_blockparent))
	var m: GMObject = null
	for inst: GMObject in GM.instances:
		if inst.object_index == A.obj_mario:
			m = inst
	ok(m != null, "找得到 obj_mario 实例")
	# 启动链留下的定时器（rm_logo 240 步后进 rm_intro）在这里不该再走
	var p: GMObject = GM.instance_find(A.obj_persistent, 0)
	p.alarm[4] = -1.0
	if m != null:
		var n: int = 0
		while n < 400 and not m._active:
			GM.tick()
			n += 1
		ok(m._active, "开场结束后 Mario 被激活（等了 %d 步）" % n)
		for i: int in 30:
			GM.tick()
		var x0: float = m.x
		var y0: float = m.y
		print("idle: pos=(%s,%s) v=(%s,%s) gravity=%s state=%s" % [m.x, m.y, m.hspeed, m.vspeed, m.gravity, m.get("state")])
		ok(GM.room == A.rm_guardabot_play and not m._destroyed, "站着 30 步后还在关卡里")
		GM.keyboard_key_press(int(G.derecha))
		for i: int in 60:
			GM.tick()
		GM.keyboard_key_release(int(G.derecha))
		print("walk: pos=(%s,%s) v=(%s,%s) state=%s" % [m.x, m.y, m.hspeed, m.vspeed, m.get("state")])
		ok(m.x > x0 + 20.0, "按右 60 步后向右走了（%s → %s）" % [x0, m.x])
		ok(absf(m.y - y0) < 1.0, "走路时没有掉下去或浮起来（y %s → %s）" % [y0, m.y])
		for i: int in 60:
			GM.tick()
		# 第 5 批：样本里的耀西蛋移植后会自己孵化，不再挡住栗子，栗子会一路走到 x≈150。
		# 跳跃放回起点做，免得 Mario 在栗子旁边落地被碰死（与原版行为无关，是测试场景的问题）
		m.x = x0
		GM.keyboard_key_press(int(G.saltar))
		var ymin: float = m.y
		for i: int in 20:
			GM.tick()
			ymin = minf(ymin, m.y)
		GM.keyboard_key_release(int(G.saltar))
		for i: int in 90:
			GM.tick()
			ymin = minf(ymin, m.y)
		print("jump: top y=%s, landed pos=(%s,%s) v=(%s,%s)" % [ymin, m.x, m.y, m.hspeed, m.vspeed])
		ok(ymin < y0 - 16.0, "跳起来了（最高 y=%s，地面 y=%s）" % [ymin, y0])
		ok(absf(m.y - y0) < 1.0, "落回地面（y=%s）" % m.y)
		# ---- 踩怪：把 Mario 放到一个栗子正上方让他落下去 ----
		var g: GMObject = GM.instance_find(A.obj_galoomba, 0)
		ok(g != null, "视野里有活动的 galoomba")
		if g != null:
			print("galoomba at (%s,%s) v=(%s,%s); koopa count=%d; powerup=%s" % [g.x, g.y, g.hspeed, g.vspeed, GM.instance_number(A.obj_koopa), G.powerup])
			var ng: int = _count(A.obj_galoomba)
			m.x = g.x
			m.y = g.y - 40.0
			var bounced: bool = false
			for i: int in 40:
				GM.tick()
				if m.vspeed < -1.0:
					bounced = true
			print("after stomp: galoomba=%d galoomba_hold=%d mario pos=(%s,%s) v=(%s,%s) destroyed=%s" % [_count(A.obj_galoomba), _count(A.obj_galoomba_hold), m.x, m.y, m.hspeed, m.vspeed, m._destroyed])
			ok(_count(A.obj_galoomba) < ng, "踩到的 galoomba 没了（%d → %d；栗子挤在一起时会连踩两个）" % [ng, _count(A.obj_galoomba)])
			ok(bounced, "踩怪后 Mario 弹起")
			ok(not m._destroyed, "踩怪后 Mario 还活着")
		# ---- 顶问号块（样本里 sprout=1：蘑菇）----
		var qb: GMObject = GM.instance_find(A.obj_block, 0)
		ok(qb != null, "有问号块 obj_block")
		if qb != null and not m._destroyed:
			# 样本里问号块正下方是一根水管（本批是空壳，不是实心），所以把 Mario 放在块下方的空中向上撞
			m.x = qb.x + 8.0
			m.y = qb.y + 1.0
			m.hspeed = 0.0
			m.vspeed = -3.0
			print("under block: mario=(%s,%s) bbox_top=%s block=(%s,%s) bottom=%s" % [m.x, m.y, m.bbox_top, qb.x, qb.y, qb.bbox_bottom])
			var spr0: int = qb.sprite_index
			var seen_sprout: bool = false
			for i: int in 120:
				GM.tick()
				if _count(A.obj_powerupsprout) > 0 or _count(A.obj_mushroom) > 0:
					seen_sprout = true
			print("after bump: qblock ready=%s sprout=%d mushroom=%d mario=(%s,%s)" % [qb.get("ready_v"), _count(A.obj_powerupsprout), _count(A.obj_mushroom), m.x, m.y])
			ok(seen_sprout, "顶问号块后出了蘑菇")
			# ---- 吃蘑菇 ----
			var mu: GMObject = null
			for q: GMObject in GM.instances:
				if q._isa[A.obj_mushroom] != 0 and not q._destroyed:
					mu = q
			ok(mu != null, "蘑菇出芽完成，变成 obj_mushroom")
			if mu != null:
				var pw0: float = G.powerup
				# 第 7 批：obj_tuberia 移植后样本里那根水管是实心的，蘑菇贴着水管走，把 Mario 瞬移到蘑菇上
				# 会卡进水管被压死。改成 Mario 回到起点站好，把蘑菇挪到 Mario 身上（与原版行为无关，是测试场景的问题）
				m.x = x0
				m.y = y0
				m.hspeed = 0.0
				m.vspeed = 0.0
				for i: int in 200:
					if is_instance_valid(mu) and not mu._destroyed and is_instance_valid(m) and not m._destroyed:
						mu.x = m.x
						mu.y = m.y + 8.0  # 原来的写法是 m.y = mu.y - 8
					GM.tick()
				print("after mushroom: powerup %s -> %s, mushroom left=%d, mario valid=%s" % [pw0, G.powerup, _count(A.obj_mushroom), is_instance_valid(m) and not m._destroyed])
				ok(G.powerup != pw0, "吃蘑菇后 powerup 变了（%s → %s）" % [pw0, G.powerup])
		# ---- 踩乌龟：滑出来的无壳乌龟（obj_beachkoopa）要减速停下，不能一直飞（用户试玩报过） ----
		var kk: GMObject = GM.instance_find(A.obj_koopa, 0)
		if kk != null and is_instance_valid(m) and not m._destroyed:
			m.x = kk.x
			m.y = kk.y - 48.0
			m.hspeed = 0.0
			m.vspeed = 1.0
			var bk: GMObject = null
			var vmax: float = 0.0
			var stop_at: int = -1
			var bx0: float = 0.0
			# 第 7 批：无壳乌龟停下后可能走回去钻进壳里（SMW 原版行为），所以看“出现过壳”，不看结束时还在不在
			var shell_seen: bool = false
			for i: int in 240:
				GM.tick()
				if _count(A.obj_shell) >= 1:
					shell_seen = true
				if bk == null:
					for q: GMObject in GM.instances:
						if q.object_index == A.obj_beachkoopa and not q._destroyed:
							bk = q
							bx0 = q.x
							# 让 Mario 离开，免得落在壳上把它踢走
							m.x -= 64.0
				elif is_instance_valid(bk) and not bk._destroyed:
					vmax = maxf(vmax, absf(bk.hspeed))
					# 停下的标志：ready 从 0 变回 1（obj_beachkoopa/Step_0：|hspeed| 降到 0.05 以内时置 0 并恢复行走）
					if stop_at < 0 and vmax > 0.0 and bk.get("ready_v") == 1.0:
						stop_at = i
			ok(bk != null, "踩乌龟后出现 obj_beachkoopa")
			if bk != null and is_instance_valid(bk):
				print("beachkoopa: vmax=%s stop_at=%d slid=%s ready=%s shells=%d" % [vmax, stop_at, bk.x - bx0, bk.get("ready_v"), _count(A.obj_shell)])
			ok(stop_at >= 0 and stop_at < 120, "无壳乌龟滑出后减速到停（最大速度 %s，第 %d 步停）" % [vmax, stop_at])
			ok(shell_seen, "踩乌龟后留下一个壳")
		# ---- 死亡与重开：小个子 Mario 从侧面撞上乌龟 ----
		var k: GMObject = GM.instance_find(A.obj_koopa, 0)
		ok(k != null, "视野里有活动的 koopa")
		if k != null and is_instance_valid(m) and not m._destroyed:
			G.powerup = 0.0
			m.x = k.x - 10.0
			m.y = k.y - 16.0
			m.vspeed = 0.0
			var died_at: int = -1
			var restarted_at: int = -1
			var lives0: Variant = G.get("lives")
			for i: int in 900:
				GM.tick()
				if died_at < 0 and _count(A.obj_deadmario) > 0:
					died_at = i
				if died_at >= 0 and _count(A.obj_deadmario) == 0 and _count(A.obj_mario) > 0:
					restarted_at = i
					break
			print("death: died_at=%d restarted_at=%d room=%s mario=%d deadmario=%d" % [died_at, restarted_at, GM.room_get_name(GM.room), _count(A.obj_mario), _count(A.obj_deadmario)])
			ok(died_at >= 0, "撞到乌龟后出现 obj_deadmario")
			ok(restarted_at >= 0 and GM.room == A.rm_guardabot_play, "死亡动画后关卡重开，重新有 obj_mario")
			ok(_count(A.obj_galoomba) == 3, "重开后 3 个 galoomba 都回来了（%d）" % _count(A.obj_galoomba))
	print("level tests: %d checks, %d failed" % [_checks, _fails])
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)
