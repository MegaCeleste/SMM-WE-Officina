# 第 4 批移植，已核对。
extends "res://objects/obj_onewaygate_left.gd"


# from objects/obj_shield_left/Create_0.gml
func _create() -> void:
	return


# from objects/obj_shield_left/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var o = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -85.0 and o.isduck == 1.0:
			x = GM.gm_round(o.x)
			y = GM.gm_round(o.y)
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_shield_left/Step_2.gml
func _step_end() -> void:
	return


# from objects/obj_shield_left/Collision_obj_banzaibill.gml
func _collision_obj_banzaibill(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Collision_obj_bulletbill.gml
func _collision_obj_bulletbill(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Collision_obj_bulletbull_red.gml
func _collision_obj_bulletbull_red(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Collision_obj_cannonball.gml
func _collision_obj_cannonball(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Collision_obj_lakitu.gml
func _collision_obj_lakitu(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Collision_obj_wrench.gml
func _collision_obj_wrench(other: GMObject) -> void:
	_user_0()
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_shield_left/Other_10.gml
func _user_0() -> void:
	if not GM.audio_is_playing(A.snd_SMB_link_guardbullet):
		GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)


# from objects/obj_shield_left/Draw_0.gml
func _gm_draw() -> void:
	return
