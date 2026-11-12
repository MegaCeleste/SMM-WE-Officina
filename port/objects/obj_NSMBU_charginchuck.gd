extends "res://objects/obj_charginchuck.gd"


# from objects/obj_NSMBU_charginchuck/Step_0.gml
func _step() -> void:
	var block_right
	var block_left
	xx = absf(hspeed)
	if sprite_index == s_charginchuck_walk or sprite_index == s_charginchuck_jump:
		if (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null):
			block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_flipblock, true, false)
			block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_flipblock, true, false)
			if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
				for inst in GM.with_list(block_right):
					inst.alarm[2] = 1.0
			elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
				for inst in GM.with_list(block_left):
					inst.alarm[2] = 1.0
			elif gravity == 0.0:
				image_speed = 0.1
				sprite_index = s_charginchuck_jump
				vspeed = (-(4.5 - (2.5 * swimming)))
				y -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= xx
	else:
		if gravity == 0.0:
			hspeed = 0.0
			if image_speed == 0.0:
				image_speed = 0.3
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= xx
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += xx
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= xx
	_user_4()
	_user_8()
	if wings == 1.0 and GM.instance_exists(A.obj_mario):
		if gravity == 0.0:
			wings_anim += 0.12
		else:
			wings_anim += 0.18
	if gravity == 0.0:
		if sprite_index == s_charginchuck_jump:
			sprite_index = s_charginchuck_walk
			if lookout == 0.0:
				image_speed = 0.6
			else:
				image_speed = 0.9
		if GM.instance_exists(A.obj_mario):
			if lookout == 1.0:
				if (hspeed < 0.0 and GM.instance_find(A.obj_mario, 0).x > (x + 32.0)) or (hspeed > 0.0 and GM.instance_find(A.obj_mario, 0).x < (x - 32.0)):
					sprite_index = s_charginchuck
					image_speed = 0.6
					hspeed = 0.0
					lookout = -1.0
					alarm[10] = 22.0
			elif lookout == 0.0:
				if GM.instance_find(A.obj_mario, 0).bbox_bottom > (y - 16.0):
					if (hspeed > 0.0 and GM.instance_find(A.obj_mario, 0).x > x) or (hspeed < 0.0 and GM.instance_find(A.obj_mario, 0).x < x):
						if wings == 1.0:
							hspeed *= 2.5
						else:
							hspeed *= 1.5
						lookout = 1.0
						alarm[1] = -1.0
						image_speed = 0.6
						if gravity == 0.0:
							sprite_index = s_charginchuck_walk
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_NSMBU_charginchuck/Alarm_0.gml
func _alarm_0() -> void:
	alarm[0] = 7.0
	if lookout == 1.0 and gravity == 0.0:
		if sprite_index == s_charginchuck_walk:
			GM.audio_stop_sound(A.snd_bump)
			GM.audio_play_sound(A.snd_bump, 0.0, false)
			if hspeed > 0.0:
				GM.instance_create((x - 16.0), y, A.obj_smoke_steps)
			elif hspeed < 0.0:
				GM.instance_create((x), y, A.obj_smoke_steps)


# from objects/obj_NSMBU_charginchuck/Alarm_1.gml
func _alarm_1() -> void:
	if gravity == 0.0:
		sprite_index = s_charginchuck
		image_speed = 0.3
		hspeed = 0.0
		lookout = -1.0
		alarm[10] = 32.0
	else:
		alarm[1] = 1.0


# from objects/obj_NSMBU_charginchuck/Alarm_10.gml
func _alarm_10() -> void:
	if gravity > 0.0 or (not GM.instance_exists(A.obj_mario)):
		alarm[10] = 1.0
		return
	sprite_index = s_charginchuck_walk
	friction = 0.0
	alarm[0] = 6.0
	if GM.instance_find(A.obj_mario, 0).bbox_bottom < (y - 16.0):
		image_speed = 0.6
		lookout = 0.0
		alarm[1] = 120.0
		if GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -1.0
		else:
			hspeed = 1.0
	else:
		image_speed = 0.9
		lookout = 1.0
		if GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -1.75
		else:
			hspeed = 1.75


# from objects/obj_NSMBU_charginchuck/Other_7.gml
func _animation_end() -> void:
	if sprite_index == s_charginchuck_damage:
		sprite_index = s_charginchuck_damage_recover
		image_speed = 0.6
	elif sprite_index == s_charginchuck_damage_recover:
		sprite_index = s_charginchuck_walk
		alarm[10] = 10.0


# from objects/obj_NSMBU_charginchuck/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = direct
	imdead.sprite_index = s_charginchuck_walk
	imdead.image_speed = 0.3
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_NSMBU_charginchuck/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(A.snd_bump)
	GM.audio_play_sound(A.snd_bump, 0.0, false)
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		return
	if sprite_index != A.spr_NSMBU_charginchuck_damage:
		if hp > 1.0:
			if firehp <= 1.0:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_score)):
					inst.event_user(4)
				GM.other = _o
				_user_0()
			else:
				sprite_index = s_charginchuck_damage
				image_speed = 0.4
				hp -= 1.0
				firehp -= 2.0
				alarm[10] = -1.0
		else:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((((bbox_left + bbox_right) / 2.0) - 8.0), y, A.obj_score)):
				inst.event_user(4)
			GM.other = _o
			_user_0()


# from objects/obj_NSMBU_charginchuck/Other_18.gml
func _user_8() -> void:
	if hspeed == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
	else:
		direct = (1.0 * GM.gm_sign(hspeed))
