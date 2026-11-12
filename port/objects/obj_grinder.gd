# from objects/obj_grinder（第 6b 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var effect_helmet: float = 0.0


# from objects/obj_grinder/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	hardness = 99.0
	stomp = 2.0
	edible = 2.0
	direct = 1.0
	modo_lava = 0.0
	depth = -7.0
	effect_helmet = 0.0
	apilar = 0.0
	swimming = 0.0


# from objects/obj_grinder/Step_1.gml
func _step_begin() -> void:
	return


# from objects/obj_grinder/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_deadmario):
		image_angle += 4.0


# from objects/obj_grinder/Alarm_0.gml
func _alarm_0() -> void:
	effect_helmet = 0.0


# from objects/obj_grinder/Alarm_10.gml
func _alarm_10() -> void:
	return


# from objects/obj_grinder/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_grinder/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_stomp)
	GM.audio_play_sound(A.snd_stomp, 0.0, false)
	for inst in GM.with_list(other):
		if inst.rot == 0.0:
			inst.rot = 1.0
	other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, other.y))
	if (other.y + 16.0) < (y - 12.0):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			other.vspeed = -0.5
		else:
			other.vspeed = -1.3
	elif G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
		other.vspeed = 1.5
	else:
		other.vspeed = 3.5


# from objects/obj_grinder/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	return


# from objects/obj_grinder/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	var _o: GMObject = GM.other
	if G.yoshi > 0.0 and (other.y + 16.0) < (y - 12.0):
		if effect_helmet == 0.0:
			GM.audio_stop_sound(A.snd_stomp)
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
			for inst in GM.with_list(GM.instance_create((x - 2.0), (y - 25.0), A.obj_smoke)):
				inst.sprite_index = A.spr_starhelmet
			effect_helmet = 1.0
			alarm[0] = 8.0
		other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o
		if o.isswim == 1.0:
			other.vspeed = -1.225
		else:
			other.vspeed = -4.0
	elif bbox_bottom < ((other.bbox_top - other.vspeed) + 5.0) and vspeed >= 0.0 and o.helmet == 1.0:
		pass
	elif o.invincible != -1.0:
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_grinder/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if G.apariencia == 3.0:
		GM.draw_sprite(A.spr_NSMBU_grinder_support, 0.0, x, y)
