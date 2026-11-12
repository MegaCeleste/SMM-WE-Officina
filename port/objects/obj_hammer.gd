# from objects/obj_hammer（第 5 批移植，已核对）
extends "res://objects/obj_brohammer_yoshi.gd"


# from objects/obj_hammer/Create_0.gml
func _create() -> void:
	GM.audio_stop_sound(A.snd_SMB3_fireball)
	GM.audio_play_sound(A.snd_SMB3_fireball, 0.0, false)
	image_speed = 0.0
	image_index = 0.0
	gravity = 0.15
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		vspeed = -1.8
	else:
		vspeed = -3.0
	direct = 1.0


# from objects/obj_hammer/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 14.0) and (G.bg_level == "forest" or G.bg_level == "beach")):
		image_angle -= (6.0 * GM.gm_sign(hspeed))
		if vspeed > 1.0:
			vspeed = 1.0
			gravity = 0.0
	else:
		image_angle -= (15.0 * GM.gm_sign(hspeed))
		if vspeed > 4.0:
			vspeed = 4.0
			gravity = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_lava)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_posion)
		instance_destroy()
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0) or x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 32.0) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 32.0):
		instance_destroy()


# from objects/obj_hammer/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	if other.held == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.explode = 1.0
			inst.event_user(6)
		GM.other = _o
		_user_0()


# from objects/obj_hammer/Collision_obj_bowserjr_shell.gml
func _collision_obj_bowserjr_shell(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_SMB3_kick)
	GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
	_user_0()


# from objects/obj_hammer/Collision_obj_brohammer.gml
func _collision_obj_brohammer(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_SMB3_kick)
	GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()


# from objects/obj_hammer/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.visible == true and other.object_index != A.obj_grinder and other.object_index != A.obj_boo and other.hardness != 101.0:
		GM.audio_stop_sound(A.snd_SMB3_kick)
		GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
		if other.hardness >= 99.0:
			_user_0()


# from objects/obj_hammer/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_SMB3_kick)
	GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_hammer/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	GM.audio_stop_sound(A.snd_SMB3_kick)
	GM.audio_play_sound(A.snd_SMB3_kick, 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o
	_user_0()
