# from objects/obj_pblock（第 5 批移植，已核对）
# PORT: mysolid 在“没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例。
# GDScript 里 Object 和 int 用 ==/!= 比较会报运行时错误（Invalid operands），所以占位判断统一写 is_same()。
extends "res://objects/obj_deactivation.gd"

var mysolid = null


# from objects/obj_pblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pblock
		1.0:
			sprite_index = A.spr_SMB3_pblock
		2.0:
			sprite_index = A.spr_pblock
		3.0:
			sprite_index = A.spr_NSMBU_pblock
	image_speed = 0.0
	image_index = 1.0
	mysolid = A.obj_lighting


# from objects/obj_pblock/Destroy_0.gml
func _destroy() -> void:
	if not is_same(mysolid, A.obj_lighting):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()


# from objects/obj_pblock/Step_0.gml
func _step() -> void:
	if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		if is_same(mysolid, A.obj_lighting):
			mysolid = GM.instance_create(x, y, A.obj_enabledsolid)
		image_index = 0.0
	else:
		if not is_same(mysolid, A.obj_lighting) and GM.instance_exists(mysolid):
			for inst in GM.with_list(mysolid):
				inst.instance_destroy()
			mysolid = A.obj_lighting
		image_index = 1.0


# from objects/obj_pblock/Other_10.gml
func _user_0() -> void:
	var col_enemy
	var col_enemy_held
	var col_munchers
	var col_bosses
	var col_clown
	var col_bullet
	var col_powerup
	var col_cannon
	var col_held
	col_enemy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_enemyparent, false, false)
	col_enemy_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false)
	col_munchers = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_muncher, false, false)
	col_bosses = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bossparent, false, false)
	col_clown = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
	col_bullet = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
	col_powerup = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_powerupparent, false, false)
	col_cannon = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_cannon, false, false)
	col_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_holdparent, false, false)
	if col_enemy != null and place_meeting(x, y, A.obj_enemyparent):
		if col_enemy.object_index != A.obj_grinder and col_enemy.object_index != A.obj_podoboo and col_enemy.object_index != A.obj_boo and col_enemy.object_index != A.obj_banzaibill and col_enemy.object_index != A.obj_bulletbill and col_enemy.object_index != A.obj_cannonball and col_enemy.object_index != A.obj_cannonball_red and col_enemy.object_index != A.obj_cheepcheep:
			if col_enemy.object_index == A.obj_bobomb or col_enemy.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(col_enemy):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_enemy):
					inst.event_user(0)
				GM.other = _o
	if col_enemy_held != null and col_enemy_held.held == 0.0 and place_meeting(x, y, A.obj_enemyparent_held):
		if col_enemy_held.object_index == A.obj_bobomb_hold:
			for inst in GM.with_list(col_enemy_held):
				GM.instance_create(inst.x, inst.y, A.obj_explosion)
				inst.instance_destroy()
		else:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_enemy_held):
				inst.event_user(0)
			GM.other = _o2
	if col_munchers != null and place_meeting(x, y, A.obj_muncher):
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_munchers):
			inst.event_user(0)
		GM.other = _o3
	if col_bosses != null and place_meeting(x, y, A.obj_bossparent):
		var _o4: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_bosses):
			inst.event_user(0)
		GM.other = _o4
	if col_clown != null and place_meeting(x, y, A.obj_clown):
		var _o5: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_clown):
			inst.event_user(0)
		GM.other = _o5
	if col_bullet != null and place_meeting(x, y, A.obj_bullebill_base):
		var _o6: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_bullet):
			inst.event_user(0)
		GM.other = _o6
	if col_powerup != null and place_meeting(x, y, A.obj_powerupparent):
		for inst in GM.with_list(col_powerup):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_held != null and place_meeting(x, y, A.obj_holdparent):
		for inst in GM.with_list(col_held):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_cannon != null and place_meeting(x, y, A.obj_cannon):
		var _o7: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_cannon):
			inst.event_user(0)
		GM.other = _o7
