# from objects/obj_spike_ball_b（第 6e 批移植，已核对）
extends "res://objects/obj_spike_ball.gd"


# from objects/obj_spike_ball_b/Create_0.gml
func _create() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		sud_imagen = 1.0
	else:
		sud_imagen = 0.0
	match G.apariencia:
		0.0:
			imagen = A.spr_SMB_spike_ball_b
		1.0:
			imagen = A.spr_SMB3_spike_ball_b
		2.0:
			imagen = A.spr_spike_ball_b
		3.0:
			imagen = A.spr_NSMBU_spike_ball_b
	image_speed = 0.0
	s_part = A.spr_spike_ball_part
	spike_alone = 0.0
	spike_alone_a = 0.0
	fisica = 0.0
	direct_spike = -1.0
	angle = 0.0
	ready_v = 0.0
	enemy_dead = 0.0
	swimming = 0.0
	modo_lava = 0.0
	paracaidas = 0.0
	alarm[10] = 2.0


# from objects/obj_spike_ball_b/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	match G.apariencia:
		0.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		1.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		2.0:
			s_part = A.spr_spike_ball_part
		3.0:
			s_part = A.spr_NSMBU_spike_ball_part
	i = 0.0
	while i < 6.0:
		imdead = GM.instance_create(x, y, A.obj_enemy_dead)
		imdead.girar = 1.0
		imdead.scale = 2.0
		imdead.sprite_index = s_part
		imdead.image_index = GM.choose(0.0, 1.0, 2.0, 3.0)
		match i:
			0.0:
				imdead.vspeed = -2.0
			1.0:
				imdead.vspeed = -0.6
			2.0:
				imdead.hspeed = 0.6
			3.0:
				imdead.hspeed = 0.6
			4.0:
				imdead.hspeed = -0.6
			5.0:
				imdead.hspeed = -0.6
		i += 1.0
	instance_destroy()


# from objects/obj_spike_ball_b/Other_13.gml
func _user_3() -> void:
	var _o: GMObject = GM.other
	if ((hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null)) and ready_v == 1.0:
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		var pow_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		var pow_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		if hspeed < 0.0 and pow_right != null and pow_right.held == 0.0:
			GM.other = self
			for inst in GM.with_list(pow_right):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o
		if hspeed > 0.0 and pow_left != null and pow_left.held == 0.0:
			GM.other = self
			for inst in GM.with_list(pow_left):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o
		var block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		var block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
			if block_right.object_index == A.obj_onoffblock:
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(1)
				GM.other = _o
			else:
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(2)
				GM.other = _o
		elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
			if block_left.object_index == A.obj_onoffblock:
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.event_user(1)
				GM.other = _o
			else:
				# ORIG-BUG: 这里原文是 with (block_right)（复制粘贴漏改，应为 block_left），照搬
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(2)
				GM.other = _o
		var shield_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_shield_left, true, false)
		var shield_right = collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_shield_right, true, false)
		if hspeed > 0.0 and shield_left != null:
			GM.other = self
			for inst in GM.with_list(shield_left):
				inst.event_user(0)
			GM.other = _o
			fisica = 1.0
			vspeed = -1.0
			hspeed = (-hspeed)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 1.0
		elif hspeed < 0.0 and shield_right != null:
			GM.other = self
			for inst in GM.with_list(shield_right):
				inst.event_user(0)
			GM.other = _o
			fisica = 1.0
			vspeed = -1.0
			hspeed = (-hspeed)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -1.0
		else:
			_user_0()


# from objects/obj_spike_ball_b/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(imagen, sud_imagen, GM.gm_round(x), y, 1.0, 1.0, angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, (y - 16.0), 1.0, 1.0, image_angle, GM.c_white, 1.0)
