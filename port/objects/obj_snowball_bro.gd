# from objects/obj_snowball_bro（第 6e 批移植，已核对）
extends "res://objects/obj_snowball.gd"


# from objects/obj_snowball_bro/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_snowball
		1.0:
			sprite_index = A.spr_SMB3_snowball
		2.0:
			sprite_index = A.spr_snowball
		3.0:
			sprite_index = A.spr_NSMBU_snowball
	swimming = 0.0
	cont = 0.0
	ready_v = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
	alarm[1] = 10.0
	if G.apariencia == 3.0:
		image_speed = 0.0
		alarm[0] = 10.0
	else:
		image_speed = 0.15
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base):
		_user_0()


# from objects/obj_snowball_bro/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	return


# from objects/obj_snowball_bro/Collision_obj_fireball.gml
func _collision_obj_fireball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_snowball_bro/Collision_obj_frozenmario.gml
func _collision_obj_frozenmario(other: GMObject) -> void:
	_user_0()


# from objects/obj_snowball_bro/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (not GM.instance_exists(A.obj_frozenmario)) and (not GM.instance_exists(A.obj_invincibility)) and other.invincible == 0.0:
		GM.audio_stop_sound(A.snd_NSMBU_snowball_freeze)
		GM.audio_play_sound(A.snd_NSMBU_snowball_freeze, 0.0, false)
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_foo
			inst.image_speed = 0.5
		var frozen = GM.instance_create(other.x, other.y, A.obj_frozenmario)
		if GM.instance_exists(A.obj_mario_pballon):
			var _mario_pballon = GM.instance_find(A.obj_mario_pballon, 0)
			frozen.sprite = _mario_pballon.sprite_index
			frozen.index = _mario_pballon.image_index
			frozen.rotacion = _mario_pballon.image_angle
			frozen.direct = 1.0
		else:
			frozen.sprite = other.sprite_index
			frozen.index = other.image_index
			frozen.direct = other.direct
		if G.powerup == 3.0 and GM.instance_exists(A.obj_cap_mario):
			var _cap_mario = GM.instance_find(A.obj_cap_mario, 0)
			frozen.cap_sprite = _cap_mario.sprite_index
			frozen.cap_index = _cap_mario.image_index
			frozen.cap_x = _cap_mario.pos_x
			frozen.cap_y = _cap_mario.pos_y
		if GM.instance_exists(A.obj_brickhelmet):
			var _brickhelmet = GM.instance_find(A.obj_brickhelmet, 0)
			frozen.helmet_sprite = _brickhelmet.sprite_index
			frozen.helmet_index = _brickhelmet.image_index
			frozen.helmet_y = _brickhelmet.pos_y
		elif GM.instance_exists(A.obj_helmet_spiny):
			var _helmet_spiny = GM.instance_find(A.obj_helmet_spiny, 0)
			frozen.helmet_sprite = _helmet_spiny.sprite_index
			frozen.helmet_index = _helmet_spiny.image_index
			frozen.helmet_y = _helmet_spiny.pos_y
		elif GM.instance_exists(A.obj_helmet):
			var _helmet = GM.instance_find(A.obj_helmet, 0)
			frozen.helmet_sprite = _helmet.sprite_index
			frozen.helmet_index = _helmet.image_index
			frozen.helmet_y = _helmet.pos_y
		frozen.helmet = other.helmet
		if G.powerup == 0.0 or G.powerup == -85.0:
			frozen.sprite_index = A.spr_frozenblock_32x32_2
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.instance_destroy()
		GM.other = _o
		instance_destroy()


# from objects/obj_snowball_bro/Collision_obj_snow_ball.gml
func _collision_obj_snow_ball(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_snowball_bro/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_snowball_break)
		GM.audio_play_sound(A.snd_NSMBU_snowball_break, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_smoke_snowball
	else:
		GM.instance_create((x - 8.0), y, A.obj_smoke)
	instance_destroy()
