# 第 4 批移植，已核对。
extends "res://objects/obj_spinner.gd"


# from objects/obj_link_dash_atack/Create_0.gml
func _create() -> void:
	image_speed = 0.5
	ready_v = 0.0
	if GM.instance_exists(A.obj_mario):
		GM.instance_find(A.obj_mario, 0).visible = false


# from objects/obj_link_dash_atack/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -85.0 and m.dash_atack > 0.0:
			x = GM.gm_round(m.x)
			y = GM.gm_round(m.y)
			m.visible = false
			_user_0()
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_link_dash_atack/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.explode = 1.0
		inst.event_user(6)
	GM.other = _o


# from objects/obj_link_dash_atack/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if ready_v == 0.0 and other.ready_v == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s:
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 7.0
				inst.event_user(0)
			else:
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 4.0
				inst.event_user(0)
				inst.event_user(1)
		GM.other = _o
		ready_v = 1.0


# from objects/obj_link_dash_atack/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.visible == true:
		GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
		GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
		var _o: GMObject = GM.other
		if other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
			GM.other = self
			for inst in GM.with_list(GM.instance_create((other.x - 8.0), other.y, A.obj_bobomb_hold)):
				if float(GM.layer_background_get_sprite(Scr.scr_bg_underwater(inst))) > 0.5:
					inst.vspeed = -0.5
				else:
					inst.vspeed = -1.0
				if (GM.instance_find(A.obj_mario, 0).bbox_left + (inst.bbox_right / 2.0)) > (inst.bbox_left + (inst.bbox_right / 2.0)):
					inst.hspeed = -1.2
					inst.direct = -1.0
				else:
					inst.hspeed = 1.2
					inst.direct = 1.0
			for inst in GM.with_list(other):
				GM.instance_destroy(inst)
			GM.other = _o
		else:
			GM.other = self
			for inst in GM.with_list(other):
				GM.other = inst
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = self
				inst.event_user(0)
			GM.other = _o
	elif other.object_index == A.obj_thwomp or other.object_index == A.obj_grrrol:
		if GM.instance_exists(A.obj_mario):
			var m = GM.instance_find(A.obj_mario, 0)
			if m.x < other.x and m.hspeed > 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = -2.0
					inst.dash_atack = 0.0
					inst.dash_cont = 0.0
			elif m.x > other.x and m.hspeed < 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = 2.0
					inst.dash_atack = 0.0
					inst.dash_cont = 0.0


# from objects/obj_link_dash_atack/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.x < x and other.hspeed < 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -2.0
				inst.dash_atack = 0.0
				inst.dash_cont = 0.0
		elif m.x > x and other.hspeed > 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 2.0
				inst.dash_atack = 0.0
				inst.dash_cont = 0.0


# from objects/obj_link_dash_atack/Other_7.gml
func _animation_end() -> void:
	return


# from objects/obj_link_dash_atack/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		var oneway_left = collision_rectangle(bbox_right, bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_onewaygate_left, false, false)
		var oneway_right = collision_rectangle((bbox_left - 1.0), bbox_top, bbox_left, bbox_bottom, A.obj_onewaygate_right, false, false)
		if m.hspeed > 0.0 and (collision_rectangle((bbox_right - 4.0), bbox_top, (bbox_right - 3.0), bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle((bbox_right - 4.0), bbox_top, (bbox_right - 3.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_right - 4.0), bbox_top, (bbox_right - 3.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or (oneway_left != null and oneway_left.object_index != A.obj_shield_left)):
			GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -2.0
				inst.dash_atack = 0.0
				inst.dash_cont = 0.0
		elif m.hspeed < 0.0 and (collision_rectangle((bbox_left + 3.0), bbox_top, (bbox_left + 4.0), bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle((bbox_left + 3.0), bbox_top, (bbox_left + 4.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left + 3.0), bbox_top, (bbox_left + 4.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or (oneway_right != null and oneway_right.object_index != A.obj_shield_right)):
			GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 2.0
				inst.dash_atack = 0.0
				inst.dash_cont = 0.0


# from objects/obj_link_dash_atack/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario) and (not GM.instance_exists(A.obj_link_atack)):
		var m = GM.instance_find(A.obj_mario, 0)
		GM.draw_sprite_ext(sprite_index, image_index, m.x, (m.y + 1.0), m.direct, 1.0, 0.0, GM.c_white, m.image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, m.x, (m.y + 1.0), m.direct, 1.0, 0.0, m.blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
