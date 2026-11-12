# 第 4 批移植，已核对。
extends GMObject

var spd: float = 0.0
var direct = null
var rot: float = 0.0
var type: float = 0.0
var swimming: float = 0.0
var ready_v: float = 0.0  # GML 变量名 ready（与 GDScript 冲突改名）
var imdead = null


# from objects/obj_link_arrow/Create_0.gml
func _create() -> void:
	GM.audio_stop_sound(A.snd_SMB_link_guard)
	GM.audio_play_sound(A.snd_SMB_link_guard, 0.0, false)
	image_speed = 0.0
	image_index = 0.0
	spd = 6.5
	direct = 1.0
	rot = 0.0
	type = 2.0
	swimming = 0.0
	ready_v = 0.0
	gravity = 0.18
	gravity_direction = 270.0
	alarm[10] = 1.0
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).isswim == 1.0:
		alarm[0] = 20.0
	else:
		alarm[0] = 15.0


# from objects/obj_link_arrow/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if swimming <= 0.5:
		gravity = 0.18
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	image_angle = direction
	if ready_v == 1.0:
		if swimming == 0.0:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.05)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.05:
				hspeed = 0.0
		else:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.01)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.01:
				hspeed = 0.0
	if (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle") or (GM.instance_exists(A.obj_lava_water) and y > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0):
		instance_destroy()
	# ORIG-BUG: 最后一项是 view_y + view_y + 128（应为 view_height），照搬
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0) or (x > ((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0)) + 128.0) and y < (GM.camera_get_view_y(GM.view_get_camera(0))) or y > ((GM.camera_get_view_y(GM.view_get_camera(0))) + GM.camera_get_view_y(GM.view_get_camera(0))) + 128.0):
		instance_destroy()


# from objects/obj_link_arrow/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 1.0


# from objects/obj_link_arrow/Alarm_10.gml
func _alarm_10() -> void:
	if direct == 1.0:
		match type:
			1.0:
				rot = 60.0
			2.0:
				rot = 0.0
			3.0:
				rot = 330.0
	else:
		match type:
			1.0:
				rot = 120.0
			2.0:
				rot = 180.0
			3.0:
				rot = 210.0
	direction = rot
	if (GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).isswim == 1.0) or (G.bg_level == "sky" and G.modo_noche == 1.0):
		spd = 2.0
	motion_add(direction, spd)
	spd = 0.0


# from objects/obj_link_arrow/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.explode = 1.0
		inst.event_user(6)
	GM.other = _o
	_user_0()


# from objects/obj_link_arrow/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.ready_v == 0.0:
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
	_user_0()


# from objects/obj_link_arrow/Collision_obj_bullebill_base.gml
func _collision_obj_bullebill_base(other: GMObject) -> void:
	_user_0()


# from objects/obj_link_arrow/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.object_index != A.obj_grinder and other.hardness < 99.0 and other.visible == true:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		if other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
			var _o: GMObject = GM.other
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
			_user_0()
		elif other.object_index != A.obj_buzzybeetle and other.object_index != A.obj_buzzybeetle_b:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				var _o2: GMObject = GM.other
				GM.other = inst
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = _o2
				inst.event_user(0)
			GM.other = _o
		_user_1()
	else:
		_user_0()


# from objects/obj_link_arrow/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	if other.object_index == A.obj_bobomb_hold:
		for inst in GM.with_list(other):
			inst.event_user(5)
	else:
		for inst in GM.with_list(other):
			inst.event_user(0)
	GM.other = _o
	_user_1()


# from objects/obj_link_arrow/Collision_obj_link_bomb.gml
func _collision_obj_link_bomb(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(5)
	GM.other = _o
	_user_1()


# from objects/obj_link_arrow/Collision_obj_onewaygate_bottom.gml
func _collision_obj_onewaygate_bottom(other: GMObject) -> void:
	if vspeed < 0.0:
		_user_0()


# from objects/obj_link_arrow/Collision_obj_onewaygate_left.gml
func _collision_obj_onewaygate_left(other: GMObject) -> void:
	if hspeed > 0.0:
		_user_0()


# from objects/obj_link_arrow/Collision_obj_onewaygate_right.gml
func _collision_obj_onewaygate_right(other: GMObject) -> void:
	if hspeed > 0.0:
		_user_0()


# from objects/obj_link_arrow/Collision_obj_physicssolid.gml
func _collision_obj_physicssolid(other: GMObject) -> void:
	_user_0()


# from objects/obj_link_arrow/Collision_obj_solid.gml
func _collision_obj_solid(other: GMObject) -> void:
	_user_0()


# from objects/obj_link_arrow/Collision_obj_solidtop.gml
func _collision_obj_solidtop(other: GMObject) -> void:
	if other.object_index != A.obj_solidphy and vspeed > 0.0 and y < other.y:
		_user_0()


# from objects/obj_link_arrow/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	_user_0()


# from objects/obj_link_arrow/Collision_obj_spring_land.gml
func _collision_obj_spring_land(other: GMObject) -> void:
	_user_0()


# from objects/obj_link_arrow/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_SMB_link_guardbullet)
	GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.rot_max = 1.0
	instance_destroy()


# from objects/obj_link_arrow/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(A.snd_SMB_link_guardbullet)
	GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark
	instance_destroy()


# from objects/obj_link_arrow/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
