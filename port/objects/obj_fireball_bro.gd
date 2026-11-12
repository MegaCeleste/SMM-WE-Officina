# from objects/obj_fireball_bro（第 6e 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var prevhspeed = null


# from objects/obj_fireball_bro/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_fireball
		1.0:
			sprite_index = A.spr_SMB3_fireball
		3.0:
			sprite_index = A.spr_NSMBU_fireball
	swimming = 0.0
	GM.audio_stop_sound(Scr.scr_snd_fireball(self))
	GM.audio_play_sound(Scr.scr_snd_fireball(self), 0.0, false)
	if G.apariencia == 3.0:
		image_speed = 0.3
		alarm[0] = 5.0
	else:
		image_speed = 0.15
	direct = 1.0
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base):
		_user_0()


# from objects/obj_fireball_bro/Step_0.gml
func _step() -> void:
	prevhspeed = hspeed
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if not GM.instance_exists(A.obj_deadmario):
		_user_3()
		_user_4()
	else:
		speed = 0.0
		gravity = 0.0
	var icecoin = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_icecoin, false, false)
	if icecoin != null:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(icecoin):
			inst.event_user(1)
		GM.other = _o
		_user_0()
	if hspeed != prevhspeed:
		_user_0()
	if Scr.outside_view(self) > 0.5:
		instance_destroy()
	if gravity == 0.0 and (not GM.instance_exists(A.obj_deadmario)):
		vspeed = -2.2
		y -= 1.0


# from objects/obj_fireball_bro/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	return


# from objects/obj_fireball_bro/Collision_obj_bobomb_hold.gml
func _collision_obj_bobomb_hold(other: GMObject) -> void:
	return


# from objects/obj_fireball_bro/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	return


# from objects/obj_fireball_bro/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_fireball_bro/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_smoke)):
		if G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_fireball_destroy
	var icecoin = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_icecoin, false, false)
	if icecoin != null:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(icecoin):
			inst.event_user(1)
		GM.other = _o
		_user_0()
	instance_destroy()
