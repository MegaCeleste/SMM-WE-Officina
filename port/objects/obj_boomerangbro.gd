# from objects/obj_boomerangbro（第 6e 批移植，已核对）
extends "res://objects/obj_hammerbro.gd"


# from objects/obj_boomerangbro/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_hammerbro = A.spr_SMB_boomerangbro
			s_hammerbro_jump = A.spr_SMB_boomerangbro
			s_hammerbro_throw = A.spr_SMB_boomerangbro_throw
			sprite_wings = A.spr_SMB_wings
		1.0:
			s_hammerbro = A.spr_SMB3_boomerangbro
			s_hammerbro_jump = A.spr_SMB3_boomerangbro_jump
			s_hammerbro_throw = A.spr_SMB3_boomerangbro_throw
			sprite_wings = A.spr_SMB3_wings
		2.0:
			s_hammerbro = A.spr_boomerangbro
			s_hammerbro_jump = A.spr_boomerangbro_jump
			s_hammerbro_throw = A.spr_boomerangbro_throw
			sprite_wings = A.spr_wings
		3.0:
			s_hammerbro = A.spr_NSMBU_boomerangbro
			sprite_index = A.spr_NSMBU_boomerangbro
			s_hammerbro_jump = A.spr_NSMBU_boomerangbro_jump
			s_hammerbro_throw = A.spr_NSMBU_boomerangbro_throw
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	direct = 1.0
	prev_hspeed = 0.4
	swimming = 0.0
	jump_high = -6.0
	throughsolid = 0.0
	jump_start = y
	hammers = GM.choose(1.0, 2.0)
	trow = 0.0
	throw_lanzar = 0.0
	salto = "big"
	start = y
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
		alarm[7] = 360.0
	else:
		image_speed = 0.125
		alarm[1] = 360.0
	alarm[2] = 17.0


# from objects/obj_boomerangbro/Alarm_2.gml
func _alarm_2() -> void:
	if sprite_index == A.spr_NSMBU_boomerangbro_jump:
		alarm[2] = 5.0
		return
	if hammers > 0.0:
		trow = 1.0
		hammers -= 1.0
		if hspeed != 0.0:
			prev_hspeed = hspeed
		hspeed = 0.0
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_boomerangbro_throw
			image_index = 0.0
			image_speed = 0.5
		else:
			alarm[3] = 10.0
			alarm[2] = 90.0
	else:
		trow = 0.0
		hammers = GM.choose(1.0, 2.0)
		hspeed = prev_hspeed
		if G.apariencia == 3.0:
			alarm[2] = 120.0
		else:
			alarm[2] = 120.0


# from objects/obj_boomerangbro/Alarm_3.gml
func _alarm_3() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_hammer_throw)
		GM.audio_play_sound(A.snd_NSMBU_hammer_throw, 0.0, false)
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > x:
			for inst in GM.with_list(GM.instance_create((x + 3.0), (y - 8.0), A.obj_boomerang)):
				inst.hspeed = 2.0
				inst.parent = self
				inst.direct = 1.0
		elif GM.instance_find(A.obj_mario, 0).x < x:
			for inst in GM.with_list(GM.instance_create((x - 3.0), (y - 8.0), A.obj_boomerang)):
				inst.hspeed = -2.0
				inst.parent = self
				inst.direct = -1.0
	else:
		for inst in GM.with_list(GM.instance_create((x + 3.0), (y - 8.0), A.obj_boomerang)):
			inst.hspeed = (2.0 * self.direct)
			inst.parent = self
			inst.direct = 1.0
	trow = 2.0
	if G.apariencia != 3.0:
		alarm[6] = 5.0


# from objects/obj_boomerangbro/Alarm_7.gml
func _alarm_7() -> void:
	if sprite_index == A.spr_NSMBU_boomerangbro_throw:
		alarm[7] = 5.0
		return
	sprite_index = A.spr_NSMBU_boomerangbro_jump
	image_index = 0.0
	image_speed = 0.5
	if hspeed != 0.0:
		prev_hspeed = hspeed
	hspeed = 0.0


# from objects/obj_boomerangbro/Other_7.gml
func _animation_end() -> void:
	if G.apariencia != 3.0:
		pass
	if sprite_index == A.spr_NSMBU_boomerangbro_throw:
		sprite_index = A.spr_NSMBU_boomerangbro
		image_speed = 0.5
		alarm[2] = 10.0
		alarm[6] = 1.0
	elif sprite_index == A.spr_NSMBU_boomerangbro_jump:
		sprite_index = A.spr_NSMBU_boomerangbro
		image_speed = 0.5
		hspeed = prev_hspeed


# from objects/obj_boomerangbro/Other_17.gml
func _user_7() -> void:
	if G.apariencia == 3.0:
		if sprite_index == A.spr_NSMBU_boomerangbro_throw:
			if image_index >= 17.0 and image_index < 17.5:
				alarm[3] = 1.0
		elif sprite_index == A.spr_NSMBU_boomerangbro_jump:
			if image_index >= 7.0 and image_index < 7.5:
				alarm[1] = 1.0
			elif image_index >= 17.0 and vspeed != 0.0 and image_speed != 0.0:
				image_speed = 0.0
				image_index = 17.0
			elif vspeed == 0.0 and image_index > 7.5:
				if image_index <= 17.0:
					image_index = 18.0
					image_speed = 0.5
