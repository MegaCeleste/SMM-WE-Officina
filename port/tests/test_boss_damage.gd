extends "res://tests/test_enemies.gd"
## 第 8 批针对性事件测试。四种画风按 scr_edit_to_play 的对象映射载入真实关卡，
## 随后直接派发有明确前置条件的碰撞/Alarm/Animation End，验证伤害与状态转换。
## 期望来自 obj_bossparent、obj_boomboom、obj_bowserjr 及各子类的原始事件。
## 这些测试验证移植逻辑，不等同于与原版 exe 试玩比对。

const BOWSERS: Array[int] = [A.obj_SMB_bowser, A.obj_SMB3_bowser, A.obj_SMW_bowser, A.obj_NSMBU_bowser]
const AMMO: Array[int] = [A.obj_fireball, A.obj_hammer, A.obj_shell_held]
const EVENTS: Array[String] = ["_collision_obj_fireball", "_collision_obj_hammer", "_collision_obj_shell_held"]
const DAMAGE: Array[float] = [1.0, 2.0, 5.0]


func _event(target: GMObject, method: String, source: GMObject) -> void:
	var previous: GMObject = GM.other
	GM.other = source
	target.call(method, source)
	ok(GM.other == source, "%s 恢复 other 上下文" % method)
	GM.other = previous


func _event0(target: GMObject, method: String, source: GMObject) -> void:
	var previous: GMObject = GM.other
	GM.other = source
	target.call(method)
	GM.other = previous


func _new_boss(obj: int) -> GMObject:
	# 放在空中，避免 Create 的查询命中测试地面。key 在原版由 _res 写入。
	var b: GMObject = GM.instance_create(_sx + 80.0, _sy - 96.0, obj)
	b.set("key", 0.0)
	return b


func _stomp(b: GMObject, m: GMObject) -> void:
	b.vspeed = 0.0
	m.x = b.x
	m.y += b.bbox_top + 1.0 - m.bbox_bottom
	m.yprevious = m.y
	m.vspeed = 1.0
	m.set("stompstyle", 0.0)
	m.set("invincible", 0.0)
	G.yoshi = 0.0
	_event(b, "_collision_obj_mario", m)


func _ancestor_step(m: GMObject, style: int) -> void:
	var a: GMObject = _new_boss(A.obj_bossparent)
	var b: GMObject = GM.instance_create(_sx + 400.0, _sy - 96.0, A.obj_bossparent)
	# Enemy Step must dispatch its virtual events on a boss outside the enemy inheritance tree.
	# Use underwater to make its swimming assignment observable and leave a second instance untouched.
	G.bg_level = "underwater"
	a.set("swimming", 0.0)
	b.set("swimming", 7.0)
	a.set("hitpoints", 3.0)
	a.set("inv", 2.0)
	a.set("hardness", 99.0)
	a.set("cooldown", 2.0)
	a.hspeed = -0.5
	_event0(a, "_step", a)
	ok(a.get("swimming") == 1.0, "style %d：跨继承调用 Enemy Step 更新目标 swimming" % style)
	ok(b.get("swimming") == 7.0, "style %d：跨继承调用不更新其他实例" % style)
	ok(a.get("direct") == -1.0 and a.gravity > 0.0, "跨继承调用保留方向和物理虚事件")
	ok(a.get("inv") == 1.0 and a.get("cooldown") == 1.0 and a.get("hardness") == 99.0, "Boss 无敌和冷却分别递减")
	_event0(a, "_step", a)
	ok(a.get("inv") == 0.0 and a.get("hardness") == 99.0, "无敌到零当步仍保留硬度（原文 < 0）")
	_event0(a, "_step", a)
	ok(a.get("inv") == 0.0 and a.get("hardness") == 0.0 and a.get("cooldown") == 0.0, "下一步解除无敌且冷却不降为负数")
	GM.instance_destroy(a)
	GM.instance_destroy(b)
	G.bg_level = "ground"
	m.x = _sx
	m.y = _sy


func _boom_stomps(m: GMObject, style: int) -> void:
	var b: GMObject = _new_boss(A.obj_NSMBU_boomboom if style == 3 else A.obj_boomboom)
	# Alarm 10 is the source's transition into a vulnerable walking state.
	_event0(b, "_alarm_10", b)
	_stomp(b, m)
	ok(b.get("hitpoints") == 2.0 and b.get("ready_v") == 1.0 and b.get("stomp") == -1.0, "style %d：踩 Boom Boom 从 3HP 降到 2HP 并进入保护" % style)
	ok(m.vspeed < 0.0, "踩 Boom Boom 后 Mario 弹起")
	_stomp(b, m)
	ok(b.get("hitpoints") == 2.0, "保护期间重复踩踏不再扣 HP")
	_event0(b, "_alarm_2", b)
	_event0(b, "_alarm_10", b)
	_stomp(b, m)
	ok(b.get("hitpoints") == 1.0 and b.get("increment") == 2.0, "恢复后第二次踩踏降到 1HP 并提速")
	_event0(b, "_alarm_2", b)
	_event0(b, "_alarm_10", b)
	b.set("key", 1.0)
	var keys: int = int(GM.instance_number(A.obj_key_appear))
	_stomp(b, m)
	ok(int(GM.instance_number(A.obj_key_appear)) == keys + 1 and b.get("key") == 0.0, "最后一踩释放钥匙且不重复释放")
	if style == 3:
		ok(b.get("increment") == 3.0 and b.sprite_index == A.spr_NSMBU_boomboom_hurt, "NSMBU Boom Boom 进入独有的致命受伤动画")
		_event0(b, "_animation_end", m)
		ok(b.sprite_index == A.spr_NSMBU_boomboom_dead and b.alarm[9] == 10.0 and b.vspeed < 0.0, "NSMBU 致命动画结束后弹起并安排 Alarm 9")
		_event0(b, "_alarm_9", b)
		ok(b.get("increment") == 4.0, "NSMBU Alarm 9 标记落地终结状态")
		# from NSMBU Boom Boom/Other_14: downward contact with solidtop invokes user 7.
		b.x = 400.0
		b.y += 383.0 - b.bbox_bottom
		b.yprevious = b.y
		b.vspeed = 1.0
		var dead: int = int(GM.instance_number(A.obj_enemy_dead))
		_event0(b, "_user_4", m)
		ok(b._destroyed and int(GM.instance_number(A.obj_enemy_dead)) == dead + 1, "NSMBU 致命弹起落地后转换为死亡对象")
		var corpse: GMObject = b.get("imdead")
		ok(corpse != null and corpse.sprite_index == A.spr_NSMBU_boomboom_dead2 and GM.eq(corpse.vspeed, -3.2), "NSMBU 落地终结使用 dead2 精灵并以 -3.2 弹起")
	else:
		ok(b.alarm[0] == 120.0 and not b._destroyed, "普通 Boom Boom 致命踩踏保留 120 步死亡过场")
		var dead: int = int(GM.instance_number(A.obj_enemy_dead))
		_event0(b, "_alarm_0", m)
		ok(b._destroyed and int(GM.instance_number(A.obj_enemy_dead)) == dead + 1, "死亡 Alarm 将 Boom Boom 转成死亡对象")


func _junior_shell(m: GMObject, style: int, big: bool = false) -> void:
	var kind: int = A.obj_NSMBU_bowserjr_b if big else (A.obj_NSMBU_bowserjr if style == 3 else A.obj_bowserjr)
	var b: GMObject = _new_boss(kind)
	b.set("key", 1.0)
	b.set("wings", 1.0)
	_stomp(b, m)
	ok(b.get("hitpoints") == 2.0 and b.get("stomp") == -1.0, "style %d big=%s：踩 Junior 减 1HP 并关闭踩踏" % [style, big])
	if style == 3:
		ok(b.get("ready_v") == 1.0 and b.alarm[2] == 60.0, "NSMBU Junior 受伤后等待收壳动画")
		_stomp(b, m)
		ok(b.get("hitpoints") == 2.0, "NSMBU Junior 受伤期间重复踩不扣 HP")
		_event0(b, "_alarm_2", m)
		ok(b.sprite_index == A.spr_NSMBU_bowserjr_shell_inside, "NSMBU Alarm 2 切到收壳动画")
		_event0(b, "_animation_end", m)
		ok(b.alarm[7] == 1.0, "收壳动画结束安排转换")
	else:
		ok(b.alarm[7] == 15.0, "普通 Junior 踩踏安排 15 步后收壳")
	_event0(b, "_alarm_7", m)
	var shell: GMObject = GM.instance_find(A.obj_bowserjr_shell, 0)
	ok(b._destroyed and shell != null, "Junior 转成壳")
	if shell == null:
		return
	ok(shell.get("hitpoints") == 2.0 and shell.get("firehitpoints") == 5.0 and shell.get("key") == 1.0 and shell.get("wings") == 1.0, "收壳保留 HP、火伤害计数、钥匙与翅膀")
	m.x = shell.x - 32.0
	_event0(shell, "_alarm_1", m)
	if style == 3:
		ok(shell.sprite_index == A.spr_NSMBU_bowserjr_shell_outside and shell.get("stomp") == -1.0, "NSMBU 壳先播放出壳动画")
		_event0(shell, "_animation_end", m)
	var restored: GMObject = GM.instance_find(A.obj_NSMBU_bowserjr if style == 3 else A.obj_bowserjr, 0)
	ok(shell._destroyed and restored != null, "出壳恢复正常 Junior 对象（包括 big 的原文转换）")
	if restored != null:
		ok(restored.get("hitpoints") == 2.0 and restored.get("firehitpoints") == 5.0 and restored.get("key") == 1.0 and restored.get("wings") == 1.0, "出壳保留所有携带状态")
		GM.instance_destroy(restored)


func _projectiles(m: GMObject, style: int) -> void:
	var b: GMObject = _new_boss(BOWSERS[style])
	for i: int in AMMO.size():
		var p: GMObject = GM.instance_create(b.x + 16.0, b.y - 32.0, AMMO[i])
		if i == 2:
			p.set("inmune", 0.0)
		var hp: float = float(b.get("firehitpoints"))
		_event(b, EVENTS[i], p)
		ok(float(b.get("firehitpoints")) == hp - DAMAGE[i], "style %d：%s 造成 %s 点火伤害" % [style, EVENTS[i], DAMAGE[i]])
		ok(p._destroyed and not b._destroyed, "弹体消耗，未达阈值的 Bowser 保留")
		ok(b.get("cooldown") == 6.0, "受击闪烁冷却设置为 6")
	# Explicit near-death precondition represents the reachable result of repeated fireball hits.
	b.set("firehitpoints", 1.0)
	b.set("key", 1.0)
	var dead: int = int(GM.instance_number(A.obj_bowser_dead))
	var keys: int = int(GM.instance_number(A.obj_key_appear))
	var final_fire: GMObject = GM.instance_create(b.x + 16.0, b.y - 32.0, A.obj_fireball)
	_event(b, "_collision_obj_fireball", final_fire)
	ok(b._destroyed and final_fire._destroyed, "最后一发火球击败 Bowser 并消耗")
	ok(int(GM.instance_number(A.obj_bowser_dead)) == dead + 1 and int(GM.instance_number(A.obj_key_appear)) == keys + 1, "击败 Bowser 生成死亡对象和钥匙")
	var d: GMObject = b.get("imdead")
	ok(d != null and d.vspeed == -3.5 and absf(d.hspeed) == 1.0, "Bowser 死亡对象按原文弹起")
	if d != null:
		GM.instance_destroy(d)
	# Boss hardness blocks incoming damage and leaves the projectile to its own collision handler.
	var protected_boss: GMObject = _new_boss(A.obj_NSMBU_bowserjr if style == 3 else A.obj_bowserjr)
	protected_boss.set("hardness", 2.0)
	var blocked: GMObject = GM.instance_create(protected_boss.x, protected_boss.y - 32.0, A.obj_fireball)
	_event(protected_boss, "_collision_obj_fireball", blocked)
	ok(protected_boss.get("firehitpoints") == 5.0 and not blocked._destroyed, "硬度 >= 2 阻止 Boss 侧火球伤害处理")
	GM.instance_destroy(blocked)
	GM.instance_destroy(protected_boss)
	m.x = _sx
	m.y = _sy


func _big_junior_threshold(m: GMObject) -> void:
	# Original bossparent checks exactly obj_NSMBU_bowserjr, excluding its _b child.
	# Lock this distinct source branch: _b reaches user 0 at the projectile threshold.
	var b: GMObject = _new_boss(A.obj_NSMBU_bowserjr_b)
	b.set("firehitpoints", 1.0)
	var dead: int = int(GM.instance_number(A.obj_enemy_dead))
	var p: GMObject = GM.instance_create(b.x, b.y - 32.0, A.obj_fireball)
	_event(b, "_collision_obj_fireball", p)
	ok(b._destroyed and p._destroyed and int(GM.instance_number(A.obj_enemy_dead)) == dead + 1, "big NSMBU Junior 原文未列入 HP 重置名单，火伤阈值直接进入死亡事件")
	m.x = _sx
	m.y = _sy


func _hp_projectile_threshold(style: int) -> void:
	# At the damage threshold these two families lose one HP and reset fire HP;
	# Bowser and the exact-id-excluded big Junior use the death event instead.
	for kind: int in [A.obj_NSMBU_boomboom if style == 3 else A.obj_boomboom,
			A.obj_NSMBU_bowserjr if style == 3 else A.obj_bowserjr]:
		var b: GMObject = _new_boss(kind)
		if kind == A.obj_boomboom or kind == A.obj_NSMBU_boomboom:
			_event0(b, "_alarm_10", b)
		b.set("firehitpoints", 1.0)
		var p: GMObject = GM.instance_create(b.x, b.y - 32.0, A.obj_fireball)
		_event(b, "_collision_obj_fireball", p)
		var reset_hp: float = 10.0 if kind == A.obj_boomboom or kind == A.obj_NSMBU_boomboom else 5.0
		ok(not b._destroyed and b.get("hitpoints") == 2.0 and b.get("firehitpoints") == reset_hp,
			"style %d %s：火伤阈值减 1HP 并重置火伤计数" % [style, GM.object_get_name(kind)])
		ok(p._destroyed, "阈值火球同样消耗")
		GM.instance_destroy(b)


func _ready() -> void:
	GM.auto_tick = false
	for style: int in 4:
		print("== BOSS DAMAGE style=", style, " ==")
		var m: GMObject = _start(style)
		ok(m != null, "style %d：真实载入链有 Mario" % style)
		if m == null:
			continue
		_ancestor_step(m, style)
		_boom_stomps(m, style)
		_junior_shell(m, style)
		_projectiles(m, style)
		_hp_projectile_threshold(style)
		if style == 3:
			_junior_shell(m, style, true)
			_big_junior_threshold(m)
	print("boss damage tests: %d checks, %d failed" % [_checks, _fails])
	get_tree().quit(1 if _fails > 0 else 0)
