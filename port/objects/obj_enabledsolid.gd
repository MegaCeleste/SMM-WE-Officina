# 第 7 批移植，已核对。
extends "res://objects/obj_solid.gd"


# from objects/obj_enabledsolid/Create_0.gml
func _create() -> void:
	_user_0()
	# PORT: 块体里调用了 event_user，按第 17 条维护 GM.other
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_claw):
		if inst.hold == 2.0:
			inst.event_user(1)
			inst.ready_v = 1.0  # PORT: 原名 ready，obj_claw 里已改名 ready_v
			inst.alarm[0] = 40.0
			inst.hold = 0.0
			for inst2 in GM.with_list(A.obj_mario):
				inst2.inclown = 0.0
	GM.other = _o


# from objects/obj_enabledsolid/Step_0.gml
func _step() -> void:
	var pblock
	pblock = collision_rectangle((bbox_right - 3.0), (bbox_top + 3.0), (bbox_left + 3.0), (bbox_bottom - 3.0), A.obj_mario, true, false)
	if pblock != null:
		for inst in GM.with_list(A.obj_mario):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.isduck = 1.0
			inst.jumpnow = 0.0


# from objects/obj_enabledsolid/Other_10.gml
func _user_0() -> void:
	var col_enemy
	var col_enemy_held
	var col_physolid
	var col_bosses
	var col_clown
	var col_bullet
	var col_powerup
	var col_held
	# PORT: 下面各个 with 块里调用了 event_user，按第 17 条在整个方法里维护 GM.other（方法内没有 return，其余代码不用 other）
	var _o: GMObject = GM.other
	GM.other = self
	col_enemy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_enemyparent, false, false)
	col_enemy_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false)
	col_physolid = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
	col_bosses = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bossparent, false, false)
	col_clown = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
	col_bullet = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
	col_powerup = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_powerupparent, false, false)
	col_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_holdparent, false, false)
	if col_enemy != null and place_meeting(x, y, A.obj_enemyparent):
		if col_enemy.object_index != A.obj_grinder and col_enemy.object_index != A.obj_podoboo and col_enemy.object_index != A.obj_boo and col_enemy.object_index != A.obj_banzaibill and col_enemy.object_index != A.obj_bulletbill and col_enemy.object_index != A.obj_cannonball and col_enemy.object_index != A.obj_cannonball_red and col_enemy.object_index != A.obj_cheepcheep:
			if col_enemy.object_index == A.obj_bobomb or col_enemy.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(col_enemy):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				for inst in GM.with_list(col_enemy):
					inst.event_user(0)
	if col_enemy_held != null and col_enemy_held.held == 0.0 and place_meeting(x, y, A.obj_enemyparent_held):
		if col_enemy_held.object_index == A.obj_bobomb_hold:
			for inst in GM.with_list(col_enemy_held):
				GM.instance_create(inst.x, inst.y, A.obj_explosion)
				inst.instance_destroy()
		else:
			for inst in GM.with_list(col_enemy_held):
				inst.event_user(0)
	if col_physolid != null and place_meeting(x, y, A.obj_muncher):
		for inst in GM.with_list(col_physolid):
			inst.event_user(0)
	if col_bosses != null and place_meeting(x, y, A.obj_bossparent):
		for inst in GM.with_list(col_bosses):
			inst.event_user(0)
	if col_clown != null and place_meeting(x, y, A.obj_clown):
		for inst in GM.with_list(col_clown):
			inst.event_user(0)
	if col_bullet != null and place_meeting(x, y, A.obj_bullebill_base):
		for inst in GM.with_list(col_bullet):
			inst.event_user(0)
	if col_powerup != null and place_meeting(x, y, A.obj_powerupparent):
		for inst in GM.with_list(col_powerup):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_held != null and place_meeting(x, y, A.obj_holdparent):
		for inst in GM.with_list(col_held):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	GM.other = _o
