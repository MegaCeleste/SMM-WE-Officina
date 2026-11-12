# 第 4 批移植，已核对。
extends "res://objects/obj_spinner.gd"

var time: float = 0.0


# from objects/obj_link_down_atack/Create_0.gml
func _create() -> void:
	image_speed = 0.5
	ready_v = 0.0
	time = 0.0
	if GM.instance_exists(A.obj_mario):
		GM.instance_find(A.obj_mario, 0).visible = false
	if GM.instance_exists(A.obj_link_atack):
		for inst in GM.with_list(A.obj_link_atack):
			GM.instance_destroy(inst)


# from objects/obj_link_down_atack/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -85.0 and m.down_atack > 0.0:
			x = GM.gm_round(m.x)
			y = (GM.gm_round(m.y) + m.vspeed)
			m.visible = false
			_user_0()
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_link_down_atack/Alarm_0.gml
func _alarm_0() -> void:
	time = 0.0


# from objects/obj_link_down_atack/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.explode = 1.0
		inst.event_user(6)
	GM.other = _o


# from objects/obj_link_down_atack/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if ready_v == 0.0 and other.ready_v == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(3)
		ready_v = 1.0
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = (-((4.0 - (2.5 * inst.isswim))))
			inst.event_user(1)
			inst.down_atack = 0.0
			inst.down_cont = 0.0
		GM.other = _o


# from objects/obj_link_down_atack/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if (other.hardness < 99.0 or other.object_index == A.obj_banzaibill or other.object_index == A.obj_billbanzai_red) and other.visible == true:
		GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
		GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
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
		GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
		GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y + 34.0), A.obj_smoke)):
			inst.sprite_index = A.spr_boltspark
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = (-((4.0 - (2.5 * inst.isswim))))
			inst.event_user(1)
			inst.down_atack = 0.0
			inst.down_cont = 0.0
		GM.other = _o


# from objects/obj_link_down_atack/Collision_obj_grinder.gml
func _collision_obj_grinder(other: GMObject) -> void:
	if (other.y - 16.0) > (y + 32.0):
		GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
		GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, (y + 34.0), A.obj_smoke)):
			inst.sprite_index = A.spr_boltspark
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = (-((4.0 - (2.5 * inst.isswim))))
			inst.event_user(1)
			inst.down_atack = 0.0
			inst.down_cont = 0.0
		GM.other = _o


# from objects/obj_link_down_atack/Collision_obj_onewaygate_bottom.gml
func _collision_obj_onewaygate_bottom(other: GMObject) -> void:
	pass


# from objects/obj_link_down_atack/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_SMB_link_dead_enemigo)
	GM.audio_play_sound(A.snd_SMB_link_dead_enemigo, 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, (y + 34.0), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_mario):
		inst.vspeed = (-((4.0 - (2.5 * inst.isswim))))
		inst.event_user(1)
		inst.down_atack = 0.0
		inst.down_cont = 0.0
	GM.other = _o


# from objects/obj_link_down_atack/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 4.0


# from objects/obj_link_down_atack/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).vspeed > 1.0 and time == 0.0:
		if collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null:
			GM.audio_stop_sound(A.snd_SMB3_thwomp_original)
			GM.audio_play_sound(A.snd_SMB3_thwomp_original, 0.0, false)
			time = 1.0
			alarm[0] = 10.0
