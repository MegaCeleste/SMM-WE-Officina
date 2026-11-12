extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0
var w_wings: float = 0.0
var lastdir: float = 0.0
var anim: float = 0.0
var homing: float = 0.0


# from objects/obj_bulletbull_red/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bulletbill_red
		1.0:
			sprite_index = A.spr_SMB3_bulletbill_red
		2.0:
			sprite_index = A.spr_bulletbill_red
		3.0:
			sprite_index = A.spr_NSMBU_bulletbill_red_right
	if G.apariencia == 3.0:
		image_speed = 0.15
	else:
		image_speed = 0.0
		image_index = 0.0
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	wings = 0.0
	w_wings = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	alarm[0] = 15.0
	lastdir = direction
	anim = 0.0
	homing = 0.0
	alarm[2] = 10.0
	alarm[3] = 600.0


# from objects/obj_bulletbull_red/Step_0.gml
func _step() -> void:
	var new_dir: float
	var diff: float
	if homing == 1.0:
		if GM.instance_exists(A.obj_mario):
			var _m: GMObject = GM.instance_find(A.obj_mario, 0)
			new_dir = GM.point_direction(x, y, _m.x, (_m.y + 16.0))
			diff = GM.angle_difference(direction, new_dir)
			direction -= minf((1.0 * GM.gm_sign(diff)), absf(diff))
			lastdir = direction
		else:
			direction = lastdir
	elif homing == 2.0:
		direction = lastdir
	if G.apariencia == 3.0:
		anim += 0.3
	if Scr.outside_view(self) > 0.5 and y < GM.room_height and depth != 10.0:
		instance_destroy()


# from objects/obj_bulletbull_red/Alarm_0.gml
func _alarm_0() -> void:
	depth = -8.0


# from objects/obj_bulletbull_red/Alarm_2.gml
func _alarm_2() -> void:
	homing = 1.0
	GM.audio_stop_sound(A.snd_bulletbill_red)
	GM.audio_play_sound(A.snd_bulletbill_red, 0.0, false)


# from objects/obj_bulletbull_red/Alarm_3.gml
func _alarm_3() -> void:
	homing = 2.0


# from objects/obj_bulletbull_red/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_bulletbull_red/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.image_angle = direction
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_bulletbull_red/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = image_index
	imdead.image_angle = direction
	imdead.hspeed = 0.6
	imdead.vspeed = 0.1
	imdead.alarm[0] = -1.0
	instance_destroy()


# from objects/obj_bulletbull_red/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0:
		GM.draw_sprite_ext(A.spr_NSMBU_bullet_smoke, anim, x, y, 1.0, 1.0, direction, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, direction, GM.c_white, 1.0)
