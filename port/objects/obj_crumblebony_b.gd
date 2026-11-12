extends "res://objects/obj_crumblebones.gd"


# from objects/obj_crumblebony_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bonybeetle_crumble_b
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_bonybeetle_crumble_b
			image_speed = 0.0
		2.0:
			image_speed = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_bonybeetle_b_desarmar
			image_index = 5.0
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


# from objects/obj_crumblebony_b/Step_2.gml
func _step_end() -> void:
	if sprite_index == A.spr_NSMBU_bonybeetle_b_desarmar and image_speed < 0.0:
		if image_index < 0.25:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_bonybeetle_b)):
				inst.direct = self.direct
			instance_destroy()


# from objects/obj_crumblebony_b/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_drybones_armar)
		GM.audio_play_sound(A.snd_NSMBU_drybones_armar, 0.0, false)
		sprite_index = A.spr_NSMBU_bonybeetle_b_desarmar
		image_speed = -0.25
		return
	if shake < 10.0:
		x += 1.0
		shake += 1.0
		alarm[2] = 5.0
	else:
		alarm[3] = 8.0
		image_index = 0.0


# from objects/obj_crumblebony_b/Alarm_3.gml
func _alarm_3() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bonybeetle_b)):
		inst.direct = self.image_xscale
	instance_destroy()


# from objects/obj_crumblebony_b/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_bonybeetle_b_desarmar:
		image_speed = 0.0
		image_index = 33.0


# from objects/obj_crumblebony_b/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_bonybeetle_deads
		1.0:
			s_dry = A.spr_SMB3_bonybeetle_deads
		2.0:
			s_dry = A.spr_bonybeetle_deads
		3.0:
			s_dry = A.spr_SMB_bonybeetle_deads
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
