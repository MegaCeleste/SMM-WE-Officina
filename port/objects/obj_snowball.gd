# from objects/obj_snowball（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var cont: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var prevhspeed: float = 0.0


# from objects/obj_snowball/Create_0.gml
func _create() -> void:
	swimming = 0.0
	cont = 0.0
	ready_v = 1.0
	GM.audio_stop_sound(A.snd_NSMBU_snowball)
	GM.audio_play_sound(A.snd_NSMBU_snowball, 0.0, false)
	image_speed = 0.0
	image_index = 0.0
	alarm[0] = 10.0
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base):
		_user_0()


# from objects/obj_snowball/Step_0.gml
func _step() -> void:
	prevhspeed = hspeed
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if not GM.instance_exists(A.obj_deadmario):
		_user_3()
		_user_4()
	else:
		speed = 0.0
		gravity = 0.0
	if hspeed != prevhspeed:
		_user_0()
	if Scr.outside_view(self) > 0.5:
		instance_destroy()
	if gravity == 0.0 and vspeed == 0.0:
		if cont == 1.0:
			_user_0()
		else:
			cont += 1.0
			vspeed = -4.225
			y -= 1.0


# from objects/obj_snowball/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_deadmario):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_snowball
			inst.image_speed = 0.6
		alarm[0] = 4.0


# from objects/obj_snowball/Alarm_1.gml
func _alarm_1() -> void:
	ready_v = 1.0


# from objects/obj_snowball/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball/Collision_obj_bowser_fire.gml
func _collision_obj_bowser_fire(other: GMObject) -> void:
	for inst in GM.with_list(GM.instance_create(other.x, (other.y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_foo
		inst.image_speed = 0.5
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_snowball/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var xy: float = 0.0
	var frozen: GMObject
	if other.object_index != A.obj_grinder and other.visible == true and ready_v == 1.0:
		if (other.hardness < 99.0 or other.object_index == A.obj_drybones) and other.sprite_height <= 36.0 and other.object_index != A.obj_buzzybeetle_b and other.object_index != A.obj_lakitu and other.object_index != A.obj_floruga and other.object_index != A.obj_floruga_body and other.object_index != A.obj_chain_chomp_free and other.object_index != A.obj_chain_chomp_free_b:
			GM.audio_stop_sound(A.snd_NSMBU_snowball_freeze)
			GM.audio_play_sound(A.snd_NSMBU_snowball_freeze, 0.0, false)
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_foo
				inst.image_speed = 0.5
			if other.object_index == A.obj_pokey:
				xy = (other.y - 4.0)
			else:
				xy = other.y
			frozen = GM.instance_create(other.x, xy, A.obj_enemyfrozen)
			frozen.set("sprite", other.sprite_index)  # PORT: frozen 是 GMObject 静态类型，自定义变量走 set()（obj_enemyfrozen 已声明这些变量）
			frozen.set("index", other.image_index)
			frozen.set("enemy", other.object_index)
			frozen.set("direct", other.direct)
			if (other.object_index == A.obj_cheepcheep or other.object_index == A.obj_cheepcheep2) and other.modo_water == 1.0:
				alarm[4] = -1.0
				alarm[5] = -1.0
			elif other.object_index == A.obj_bulletbull_red:
				frozen.set("enable_gravity", 0.0)
				frozen.set("rotacion", other.direction)
				frozen.set("direct", 1.0)
			elif other.object_index == A.obj_bulletbill:
				frozen.set("enable_gravity", 0.0)
			elif other.object_index == A.obj_pokey:
				frozen.set("enable_gravity", 0.0)
				for inst in GM.with_list(frozen):
					inst.alarm[4] = 120.0
					inst.alarm[6] = 180.0
					inst.set("pos_y", -4.0)
			elif other.vspeed != 0.0:
				frozen.set("enable_gravity", 0.0)
				for inst in GM.with_list(frozen):
					inst.alarm[4] = 120.0
					inst.alarm[6] = 180.0
			else:
				for inst in GM.with_list(frozen):
					inst.alarm[4] = 540.0
					inst.alarm[5] = 600.0
			match other.object_index:
				A.obj_koopa:
					frozen.sprite_index = A.spr_frozenblock_24x36
				A.obj_koopa_red:
					frozen.sprite_index = A.spr_frozenblock_24x36
				A.obj_drybones:
					frozen.sprite_index = A.spr_frozenblock_24x36
				A.obj_jumppiranha:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_piranhaplant:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_plant_fire:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_hammerbro:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_firebro:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_icebro:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_boomerangbro:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_charginchuck:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_monty_chase:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_rocangrejo:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_magikoopa:
					frozen.sprite_index = A.spr_frozenblock_32x32
				A.obj_bulletbill:
					frozen.sprite_index = A.spr_frozenblock_36x24
				A.obj_bulletbull_red:
					frozen.sprite_index = A.spr_frozenblock_32x32
			GM.instance_destroy(other)
		_user_0()


# from objects/obj_snowball/Collision_obj_grrrol.gml
func _collision_obj_grrrol(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball/Collision_obj_magic.gml
func _collision_obj_magic(other: GMObject) -> void:
	_user_0()
	GM.instance_destroy(other)


# from objects/obj_snowball/Collision_obj_plantfire.gml
func _collision_obj_plantfire(other: GMObject) -> void:
	for inst in GM.with_list(GM.instance_create(other.x, (other.y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_foo
		inst.image_speed = 0.5
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_snowball/Collision_obj_podoboo.gml
func _collision_obj_podoboo(other: GMObject) -> void:
	for inst in GM.with_list(GM.instance_create(other.x, (other.y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_foo
		inst.image_speed = 0.5
	_user_0()
	GM.instance_destroy(other)


# from objects/obj_snowball/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	# ORIG-BUG: frozen 在条件判断之前就创建，条件不满足时留下一个孤立的 obj_enemyfrozen，照搬
	var frozen: GMObject = GM.instance_create(other.x, other.y, A.obj_enemyfrozen)
	if other.sprite_height < 30.0 and other.visible == true:
		GM.audio_stop_sound(A.snd_NSMBU_snowball_freeze)
		GM.audio_play_sound(A.snd_NSMBU_snowball_freeze, 0.0, false)
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_foo
			inst.image_speed = 0.5
		frozen.set("sprite", other.sprite_index)
		frozen.set("index", other.image_index)
		frozen.set("enemy", other.object_index)
		frozen.set("direct", other.direct)
		if other.vspeed != 0.0:
			frozen.set("enable_gravity", 0.0)
			for inst in GM.with_list(frozen):
				inst.alarm[4] = 120.0
				inst.alarm[6] = 180.0
		GM.instance_destroy(other)
		_user_0()


# from objects/obj_snowball/Collision_obj_snow_ball.gml
func _collision_obj_snow_ball(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_NSMBU_snowball_break)
	GM.audio_play_sound(A.snd_NSMBU_snowball_break, 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_snowball_destroy
	instance_destroy()


# from objects/obj_snowball/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid: GMObject = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid: GMObject = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 3.0:
			vspeed = 3.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
	else:
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (bbox_bottom - 8.0) < (GM.instance_find(A.obj_lava_water, 0).y - 10.0) and (G.bg_level == "forest" or G.bg_level == "beach"):
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_agua)
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_lava)
			_user_0()
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_lava)
			_user_0()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_posion)
			_user_0()
		else:
			gravity = 0.2
			if vspeed > 3.0:
				vspeed = 3.0
	if vspeed < 0.0 and ((collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null and collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null) or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_hurtsolid2, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solidphy, true, false) != null):
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_solid, true, false) != null:
			y += 1.0
		vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()
