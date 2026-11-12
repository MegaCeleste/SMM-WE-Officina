extends "res://objects/obj_bonybeetle.gd"


# from objects/obj_bonybeetle_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bonybeetle_b
			s_bonybeetle = A.spr_SMB_bonybeetle_b
			s_bonybeetle_shell = A.spr_SMB_bonybeetle_shell_b
			sprite_wings = A.spr_SMB_wings_b
			para_y = 2.0
		1.0:
			sprite_index = A.spr_SMB3_bonybeetle_b
			s_bonybeetle = A.spr_SMB3_bonybeetle_b
			s_bonybeetle_shell = A.spr_SMB3_bonybeetle_shell_b
			sprite_wings = A.spr_SMB3_wings_b
			para_y = 0.0
		2.0:
			s_bonybeetle = A.spr_bonybeetle_b
			s_bonybeetle_shell = A.spr_bonybeetle_shell_b
			sprite_wings = A.spr_wings_b
			para_y = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_bonybeetle_b
			s_bonybeetle = A.spr_NSMBU_bonybeetle_b
			s_bonybeetle_shell = A.spr_SMB_bonybeetle_shell_b
			sprite_wings = A.spr_NSMBU_wings_enemigos_b
			para_y = 0.0
	hardness = 6.0
	stomp = 3.0
	edible = 1.0
	dead_h = 0.0
	s_dry = A.spr_drybones_deads
	innave = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	spiny = 0.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[0] = 180.0


# from objects/obj_bonybeetle_b/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0:
		match sprite_index:
			A.spr_NSMBU_bonybeetle_b_start:
				if image_index >= 29.5:
					sprite_index = A.spr_NSMBU_bonybeetle_b_spiny
					image_index = 0.0
					stomp = 1.0
				else:
					image_speed = 0.5
			A.spr_NSMBU_bonybeetle_b_spiny:
				if image_index >= 18.75:
					if spiny == 2.0:
						sprite_index = A.spr_NSMBU_bonybeetle_b_end
						image_index = 0.0
					else:
						spiny += 1.0
				else:
					image_speed = 0.25
			A.spr_NSMBU_bonybeetle_b_end:
				if image_index >= 11.5:
					sprite_index = A.spr_NSMBU_bonybeetle_b
					image_index = 0.0
					spiny = 0.0
					stomp = 3.0
					alarm[10] = 2.0
					alarm[0] = 180.0
				else:
					image_speed = 0.5
	elif spiny == 1.0:
		if image_index >= 2.85:
			image_speed = 0.0
			image_index = 2.85
	elif spiny == 2.0:
		if image_index <= 0.15:
			sprite_index = s_bonybeetle
			image_speed = 0.15
			image_index = 0.0
			spiny = 0.0
			stomp = 3.0
			alarm[10] = 2.0
			alarm[0] = 180.0


# from objects/obj_bonybeetle_b/Alarm_0.gml
func _alarm_0() -> void:
	hspeed = 0.0
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_bonybeetle_b_start
		image_speed = 0.5
		image_index = 0.0
	else:
		alarm[1] = 10.0


# from objects/obj_bonybeetle_b/Other_10.gml
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
			s_dry = A.spr_NSMBU_bonybeetle_b_deads
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = s_dry
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	imdead.gravity = 0.16
	if G.apariencia != 3.0:
		imdead.scale = 2.0
	imdead2 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead2.girar = 1.0
	imdead2.sprite_index = s_dry
	imdead2.image_speed = 0.0
	imdead2.image_index = 1.0
	imdead2.direct = direct
	imdead2.gravity = 0.16
	if G.apariencia != 3.0:
		imdead2.scale = 2.0
	imdead3 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead3.girar = 1.0
	imdead3.sprite_index = s_dry
	imdead3.image_speed = 0.0
	imdead3.image_index = 2.0
	imdead3.direct = direct
	imdead3.gravity = 0.16
	if G.apariencia != 3.0:
		imdead3.scale = 2.0
	if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = -1.0
		imdead2.hspeed = 1.0
		imdead3.hspeed = 0.3
	elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = 1.0
		imdead2.hspeed = -1.0
		imdead3.hspeed = -0.3
	instance_destroy()


# from objects/obj_bonybeetle_b/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		for inst in GM.with_list(GM.instance_create(GM.gm_round(x), y, A.obj_crumblebony_b)):
			inst.direct = self.direct
		instance_destroy()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.image_xscale = self.direct
		wings = 0.0
		alarm[10] = 2.0
