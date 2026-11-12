# 第 4 批移植，已核对。
extends "res://objects/obj_holdparent.gd"

var time: float = 0.0


# from objects/obj_link_bomb/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 0.0
	time = 0.0
	held = 1.0
	walk = 0.0
	depth = -7.0
	gravity = 0.0
	speed = 0.0
	alarm[4] = 50.0
	alarm[5] = 110.0
	alarm[6] = 190.0
	alarm[10] = 10.0


# from objects/obj_link_bomb/Step_0.gml
func _step() -> void:
	var valor: float = 0.0
	if y < -20.0 and vspeed < 0.0:
		y = -20.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if held == 0.0:
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
		if GM.instance_exists(A.obj_mario):
			if inwall == 0.0:
				_user_3()
				_user_4()
				if walk == 0.0:
					if gravity == 0.0:
						valor = 0.15
					else:
						valor = 0.015
					hspeed = (maxf(0.0, (absf(hspeed) - valor)) * GM.gm_sign(hspeed))
					if absf(hspeed) < valor:
						hspeed = 0.0
				elif walk == 1.0:
					_user_6()
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) and vspeed < 0.0:
					hspeed = 0.0
					inwall = 1.0
			else:
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x += 1.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
					x += 1.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
					x += 1.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
					x += 1.0
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null):
					inwall = 0.0
		elif GM.instance_exists(A.obj_deadmario):
			vspeed = 0.0
			gravity = 0.0
		else:
			_user_3()
			_user_4()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
			alarm[6] = 1.0
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
			alarm[6] = 1.0
		elif y > GM.room_height and held == 0.0:
			instance_destroy()


# from objects/obj_link_bomb/Step_2.gml
func _step_end() -> void:
	if held == 1.0:
		swimming = 0.0
		vspeed = 0.0
		if GM.instance_exists(A.obj_mario):
			depth = -7.0
			x = GM.instance_find(A.obj_mario, 0).x
			y = (GM.instance_find(A.obj_mario, 0).y + 1.0)
			shake = 0.0
			alarm[0] = -1.0
			if GM.keyboard_check(G.lanzar_agarrar) and G.powerup == -85.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 2.0
				direct = 1.0
			elif GM.instance_find(A.obj_mario, 0).disablecontrols == 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
				y -= 1.0
				held = 0.0
				depth = 0.0
				shake = 0.0
				alarm[0] = -1.0
				_user_2()
			visible = true
		elif GM.instance_exists(A.obj_player_warp):
			for inst in GM.with_list(A.obj_player_warp):
				inst.myitem = sprite_index
			G.warp_item = sprite_index
			x = GM.instance_find(A.obj_player_warp, 0).x
			y = (GM.instance_find(A.obj_player_warp, 0).y + 1.0)
			for inst in GM.with_list(A.obj_player_warp):
				inst.holding = 2.0
			visible = false
		elif GM.instance_exists(A.obj_doormario):
			for inst in GM.with_list(A.obj_doormario):
				inst.myitem = sprite_index
			x = GM.instance_find(A.obj_doormario, 0).x
			y = (GM.instance_find(A.obj_doormario, 0).y + 1.0)
			for inst in GM.with_list(A.obj_doormario):
				inst.holding = 2.0
			visible = false
		elif GM.instance_exists(A.obj_doormario_exit):
			for inst in GM.with_list(A.obj_doormario_exit):
				inst.myitem = sprite_index
			x = GM.instance_find(A.obj_doormario_exit, 0).x
			y = (GM.instance_find(A.obj_doormario_exit, 0).y + 1.0)
			for inst in GM.with_list(A.obj_doormario_exit):
				inst.holding = 2.0
			visible = false
		elif G.warp_item == -4.0:
			held = 0.0
	else:
		var lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 3.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
		if lava_lift != null and vspeed >= 0.0:
			var check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_solidtop, false, false)
			var phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_physicssolid, false, false)
			if (check != null and check != lava_lift) or phy_check != null:
				return
			y = (lava_lift.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
			var spd = lava_lift.hspeed
			if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
				x += lava_lift.hspeed
			if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
				x -= 1.0
			elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
				x += 1.0


# from objects/obj_link_bomb/Alarm_4.gml
func _alarm_4() -> void:
	if walk == 1.0:
		if sprite_index == A.spr_SMB_bomb_walk:
			sprite_index = A.spr_SMB_bomb_walk2
		else:
			sprite_index = A.spr_SMB_bomb_walk
	elif image_index == 0.0:
		image_index = 1.0
	else:
		image_index = 0.0
	if time < 2.0:
		time += 1.0
		if time != 2.0:
			alarm[4] = 10.0
	elif time > 2.0:
		alarm[4] = 10.0


# from objects/obj_link_bomb/Alarm_5.gml
func _alarm_5() -> void:
	time = 3.0
	alarm[4] = 1.0


# from objects/obj_link_bomb/Alarm_6.gml
func _alarm_6() -> void:
	if GM.instance_exists(A.obj_player_warp) or GM.instance_exists(A.obj_doormario):
		alarm[4] = 50.0
		alarm[5] = 110.0
		alarm[6] = 190.0
	else:
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()


# from objects/obj_link_bomb/Alarm_10.gml
func _alarm_10() -> void:
	if G.modo_noche == 1.0:
		if held == 0.0:
			sprite_index = A.spr_SMB_bomb_walk
			image_speed = 0.15
			walk = 1.0
		else:
			alarm[10] = 2.0


# from objects/obj_link_bomb/Collision_obj_link_atack.gml
func _collision_obj_link_atack(other: GMObject) -> void:
	if not GM.audio_is_playing(Scr.scr_snd_kick(self)):
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	if (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		hspeed = (other.hspeed - (1.0 - swimming))
		direct = -1.0
	else:
		hspeed = (other.hspeed + (1.0 - swimming))
		direct = 1.0
	vspeed = (-0.5 + swimming)
	inmune = 1.0
	alarm[3] = 15.0


# from objects/obj_link_bomb/Collision_obj_link_down_atack.gml
func _collision_obj_link_down_atack(other: GMObject) -> void:
	if not GM.audio_is_playing(Scr.scr_snd_kick(self)):
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	if (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		hspeed = (other.hspeed - (1.0 - swimming))
		direct = -1.0
	else:
		hspeed = (other.hspeed + (1.0 - swimming))
		direct = 1.0
	inmune = 1.0
	alarm[3] = 15.0


# from objects/obj_link_bomb/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	alarm[6] = 1.0


# from objects/obj_link_bomb/Other_12.gml
func _user_2() -> void:
	GM.audio_play_sound(A.snd_SMB_link_throw, 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_mario):
		inst.event_user(7)
	GM.other = _o
	bouncy = 1.0
	if collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 8.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 8.0), A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 8.0), A.obj_physicssolid, false, false) != null:
		y += 16.0
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_physicssolid, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		if GM.instance_find(A.obj_mario, 0).hspeed == 0.0:
			hspeed = (1.0 * GM.instance_find(A.obj_mario, 0).direct)
		else:
			hspeed = (GM.instance_find(A.obj_mario, 0).hspeed / 2.0)
	elif (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_physicssolid, false, false) == null):
		hspeed = (((2.0 - swimming) + absf(GM.instance_find(A.obj_mario, 0).hspeed)) * GM.gm_sign(GM.instance_find(A.obj_mario, 0).direct))
	else:
		inwall = 1.0
	inmune = 1.0
	alarm[3] = 15.0


# from objects/obj_link_bomb/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		var _o: GMObject = GM.other
		GM.other = self
		if hspeed > 0.0 and col_one_left != null:
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
		if hspeed < 0.0 and col_one_right != null:
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
		GM.other = _o
		direct = (-direct)
		hspeed = 0.0
		if walk == 1.0:
			sprite_index = A.spr_SMB_bomb
			image_speed = 0.0
			image_index = 0.0
			walk = 0.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_link_bomb/Other_16.gml
func _user_6() -> void:
	var hs_normal = 0.5
	if direct == 1.0 and hspeed > hs_normal:
		hspeed -= 0.04
		if hspeed <= hs_normal:
			hspeed = hs_normal
	elif direct == -1.0 and hspeed < (-hs_normal):
		hspeed += 0.04
		if hspeed >= (-hs_normal):
			hspeed = (-hs_normal)
