extends "res://objects/obj_enemyparent.gd"

var s_dry: float = 0.0
var edible: float = 0.0
var big: float = 0.0
var shake: float = 0.0
var imdead2 = null
var imdead3 = null


# from objects/obj_crumblebones/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_drybones_crubles
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_drybones_crumble
			image_speed = 0.0
		2.0:
			image_speed = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_drybones_desarmar
			image_speed = 0.5
	s_dry = A.spr_drybones_deads
	hardness = 100.0
	stomp = -1.0
	edible = 2.0
	big = 0.0
	dead_h = 0.0
	apilar = 0.0
	direct = 1.0
	shake = 0.0
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_drybones_desarmar)
		GM.audio_play_sound(A.snd_NSMBU_drybones_desarmar, 0.0, false)
		alarm[1] = 240.0
	else:
		GM.audio_stop_sound(A.snd_crumble)
		GM.audio_play_sound(A.snd_crumble, 0.0, false)
		alarm[0] = 8.0


# from objects/obj_crumblebones/Alarm_0.gml
func _alarm_0() -> void:
	image_index = 1.0
	alarm[1] = 200.0


# from objects/obj_crumblebones/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_drybones_armar)
		GM.audio_play_sound(A.snd_NSMBU_drybones_armar, 0.0, false)
		sprite_index = A.spr_NSMBU_drybones_armar
		image_index = 0.0
		image_speed = 0.5
		return
	if shake < 10.0:
		x += 1.0
		shake += 1.0
		alarm[2] = 5.0
	else:
		alarm[3] = 8.0
		image_index = 0.0


# from objects/obj_crumblebones/Alarm_2.gml
func _alarm_2() -> void:
	x -= 1.0
	alarm[1] = 5.0


# from objects/obj_crumblebones/Alarm_3.gml
func _alarm_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_drybones)):
		inst.direct = self.image_xscale
	instance_destroy()


# from objects/obj_crumblebones/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_drybones_desarmar:
		image_speed = 0.0
		image_index = 37.0
	elif sprite_index == A.spr_NSMBU_drybones_armar:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_drybones)):
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_crumblebones/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_drybones_deads
		1.0:
			s_dry = A.spr_SMB3_drybones_deads
		2.0:
			s_dry = A.spr_drybones_deads
		3.0:
			s_dry = A.spr_NSMBU_drybones_deads
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = s_dry
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	imdead.gravity = 0.16
	imdead2 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead2.girar = 1.0
	imdead2.sprite_index = s_dry
	imdead2.image_speed = 0.0
	imdead2.image_index = 1.0
	imdead2.direct = direct
	imdead2.gravity = 0.16
	imdead3 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead3.girar = 1.0
	imdead3.sprite_index = s_dry
	imdead3.image_speed = 0.0
	imdead3.image_index = 2.0
	imdead3.direct = direct
	imdead3.gravity = 0.16
	if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = -1.0
		imdead2.hspeed = 1.0
		imdead3.hspeed = 0.3
	elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = 1.0
		imdead2.hspeed = -1.0
		imdead3.hspeed = -0.3
	instance_destroy()


# from objects/obj_crumblebones/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, 1.0, 0.0, GM.c_white, 1.0)
