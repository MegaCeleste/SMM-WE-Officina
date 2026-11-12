# 第 4 批移植，已核对。
extends "res://objects/obj_spinner.gd"

var ready_boss: float = 0.0


# from objects/obj_link_atack/Create_0.gml
func _create() -> void:
	GM.audio_play_sound(A.snd_SMB_link_sword, 0.0, false)
	image_speed = 0.5
	ready_v = 0.0
	ready_boss = 0.0
	if GM.instance_exists(A.obj_mario):
		GM.instance_find(A.obj_mario, 0).visible = false


# from objects/obj_link_atack/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -85.0 and m.holding == 0.0:
			x = GM.gm_round(m.x)
			y = GM.gm_round(m.y)
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_link_atack/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.explode = 1.0
		inst.event_user(6)
	GM.other = _o


# from objects/obj_link_atack/Collision_obj_blockparent.gml
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


# from objects/obj_link_atack/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.vspeed >= 0.0:
		GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
		GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
		var _o: GMObject = GM.other
		if other.object_index == A.obj_koopa or other.object_index == A.obj_koopa_red or other.object_index == A.obj_koopa_b or other.object_index == A.obj_koopa_red_b or other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_buzzybeetle_b or other.object_index == A.obj_snow_ball_held or other.object_index == A.obj_shell_held:
			GM.other = self
			for inst in GM.with_list(other):
				GM.other = inst
				for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_spinthump
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = self
				inst.event_user(5)
			GM.other = _o
		elif other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
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


# from objects/obj_link_atack/Collision_obj_grrrol.gml
func _collision_obj_grrrol(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.x < x and other.hspeed < 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -1.0
		elif m.x > x and other.hspeed > 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 1.0


# from objects/obj_link_atack/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if m.x < x and other.hspeed < 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -1.0
		elif m.x > x and other.hspeed > 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 1.0
