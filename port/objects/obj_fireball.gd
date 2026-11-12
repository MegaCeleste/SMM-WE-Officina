# from objects/obj_fireball（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var prevhspeed = null


# from objects/obj_fireball/Create_0.gml
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
	if place_meeting(x, y, A.obj_solid):
		_user_0()


# from objects/obj_fireball/Step_0.gml
func _step() -> void:
	var icecoin
	prevhspeed = hspeed
	super._step()
	icecoin = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_icecoin, false, false)
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
	if gravity == 0.0 and object_index != A.obj_fire_clown_small:
		vspeed = -2.0
		y -= 1.0


# from objects/obj_fireball/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_fireparticle
	alarm[0] = 5.0


# from objects/obj_fireball/Collision_obj_bobomb.gml
func _collision_obj_bobomb(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
		inst.event_user(0)
	for inst in GM.with_list(other):
		inst.event_user(1)
	GM.other = _o
	_user_0()


# from objects/obj_fireball/Collision_obj_bobomb_hold.gml
func _collision_obj_bobomb_hold(other: GMObject) -> void:
	if (bbox_left + (other.bbox_right / 2.0)) > (other.bbox_left + (other.bbox_right / 2.0)):
		other.hspeed = -1.2
		other.direct = -1.0
	else:
		other.hspeed = 1.2
		other.direct = 1.0
	other.vspeed = -1.5
	_user_0()


# from objects/obj_fireball/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.object_index != A.obj_grinder and other.visible == true:
		if other.hardness < 99.0 and other.hardness != 6.0 and other.stomp != 5.0 and other.object_index != A.obj_buzzybeetle and other.object_index != A.obj_buzzybeetle_b and other.object_index != A.obj_bobomb and other.object_index != A.obj_chain_chomp_free and other.object_index != A.obj_chain_chomp_free_b and other.object_index != A.obj_bulletbill and other.object_index != A.obj_bulletbull_red and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			if object_index == A.obj_fire_clown:
				for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
					inst.sprite_index = A.spr_spinthump
				hspeed = prevhspeed
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
				inst.event_user(0)
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o
		if other.object_index != A.obj_bobomb or other.object_index == A.obj_buzzybeetle or other.object_index == A.obj_buzzybeetle_b or other.object_index == A.obj_chain_chomp_free or other.object_index == A.obj_chain_chomp_free_b or other.object_index == A.obj_bulletbill or other.object_index == A.obj_bulletbull_red or other.object_index == A.obj_cannonball or other.object_index == A.obj_cannonball_red or (other.object_index == A.obj_cheepcheep and other.modo_lava == 1.0) or (other.object_index == A.obj_cheepcheep2 and other.modo_lava == 1.0):
			_user_0()


# from objects/obj_fireball/Collision_obj_grrrol.gml
func _collision_obj_grrrol(other: GMObject) -> void:
	_user_0()


# from objects/obj_fireball/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	_user_0()


# from objects/obj_fireball/Other_10.gml
func _user_0() -> void:
	var icecoin
	GM.audio_stop_sound(Scr.scr_snd_bump(self))
	GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_smoke)):
		if G.apariencia == 3.0:
			inst.sprite_index = A.spr_NSMBU_fireball_destroy
	icecoin = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_icecoin, false, false)
	if icecoin != null:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(icecoin):
			inst.event_user(1)
		GM.other = _o
		_user_0()
	instance_destroy()


# from objects/obj_fireball/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	else:
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (bbox_bottom - 8.0) < (GM.instance_find(A.obj_lava_water, 0).y - 10.0) and (G.bg_level == "forest" or G.bg_level == "beach"):
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 24.0), A.obj_splash_agua)
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0:
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
			instance_destroy()
		else:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()
