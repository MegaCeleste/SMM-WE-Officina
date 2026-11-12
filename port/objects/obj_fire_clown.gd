# 第 7 批移植，已核对。
extends "res://objects/obj_fire_clown_small.gd"

var rotacion: float = 0.0


# from objects/obj_fire_clown/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_fire_clown
		1.0:
			sprite_index = A.spr_SMB3_fire_clown_big
		3.0:
			sprite_index = A.spr_NSMBU_fire_clown
	if G.apariencia != 3.0:
		image_speed = 0.2
	direct = 1.0
	rotacion = 0.0
	GM.audio_stop_sound(A.snd_clown_fire)
	GM.audio_play_sound(A.snd_clown_fire, 0.0, false)


# from objects/obj_fire_clown/Step_0.gml
func _step() -> void:
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base) or place_meeting(x, y, A.obj_solidphy):
		_user_0()
	if (place_meeting(x, y, A.obj_onewaygate_right) and hspeed < 0.0) or (place_meeting(x, y, A.obj_onewaygate_left) and hspeed > 0.0):
		_user_0()
	gravity = 0.0
	if G.apariencia == 3.0:
		rotacion -= (12.0 * GM.gm_sign(hspeed))
	if Scr.outside_view(self) > 0.5:
		instance_destroy()


# from objects/obj_fire_clown/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_fireparticle
	alarm[0] = 5.0


# from objects/obj_fire_clown/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario):
		Scr.scr_musicalscale(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
		inst.sprite_index = A.spr_spinthump
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_fire_clown/Collision_obj_boomboom.gml
func _collision_obj_boomboom(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(1)
	GM.other = _o
	_user_0()


# from objects/obj_fire_clown/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0:
		if GM.instance_exists(A.obj_mario):
			Scr.scr_musicalscale(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	elif other.hardness >= 99.0:
		_user_0()


# from objects/obj_fire_clown/Collision_obj_onoffblock.gml
func _collision_obj_onoffblock(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(1)
	GM.other = _o


# from objects/obj_fire_clown/Other_10.gml
func _user_0() -> void:
	GM.instance_create((x + (12.0 * direct)), y, A.obj_clown_explotion)
	instance_destroy()


# from objects/obj_fire_clown/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, rotacion, GM.c_white, 1.0)
