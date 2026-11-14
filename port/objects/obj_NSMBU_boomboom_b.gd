# 第 8 批移植；逐事件对照原版。
extends "res://objects/obj_NSMBU_boomboom.gd"


# from objects/obj_NSMBU_boomboom_b/Create_0.gml
func _create() -> void:
	hardness = 0.0
	stomp = 4.0
	edible = 2.0
	direct = -1.0
	polvo = 0.0
	ready_v = 0.0
	inv = 0.0
	fly = 0.0
	hitpoints = 3.0
	firehitpoints = 14.0
	increment = 1.0
	wings = 0.0
	w_wings = 0.0
	paracaidas = 0.0
	apilar = 0.0
	innave = 0.0
	dead_h = 0.0
	key = 0.0
	cooldown = 0.0
	grito = 0.0
	swimming = 0.0
	image_speed = 0.5
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = -1.0
	else:
		hspeed = 1.0
	alarm[10] = 80.0


# from objects/obj_NSMBU_boomboom_b/Step_2.gml
func _step_end() -> void:
	if hspeed != 0.0 and fly == 0.0 and sprite_index != A.spr_NSMBU_boomboom_standup_b:
		# ORIG-BUG: 赋值后立即比较，下一分支恒为假。
		prevhspeed = hspeed
		if hspeed != prevhspeed:
			hspeed = (GM.gm_sign(hspeed) * 4.0)
			if gravity == 0.0:
				vspeed = -2.0
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed -= 0.0448
			if hspeed < (-1.8 * increment):
				hspeed = (-1.8 * increment)
			if polvo < 7.0:
				polvo += 1.0
			else:
				for inst in GM.with_list(GM.instance_create(x, (y + 16.0), A.obj_smoke)):
					inst.image_speed = 0.8
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
				polvo = 0.0
			# ORIG-BUG: 左侧阈值是 -0.9，右侧是 1.8；保留原文。
			if hspeed <= -0.9:
				sprite_index = A.spr_NSMBU_boomboom_run_b
			else:
				sprite_index = A.spr_NSMBU_boomboom_b
		else:
			hspeed += 0.0448
			if hspeed > (1.8 * increment):
				hspeed = (1.8 * increment)
			if polvo < 7.0:
				polvo += 1.0
			else:
				for inst in GM.with_list(GM.instance_create(x, (y + 16.0), A.obj_smoke)):
					inst.image_speed = 0.8
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
				polvo = 0.0
			if hspeed >= 1.8:
				sprite_index = A.spr_NSMBU_boomboom_run_b
			else:
				sprite_index = A.spr_NSMBU_boomboom_b
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			if grito == 0.0 and (Scr.outside_view(self) <= 0.5):
				GM.audio_stop_sound(A.snd_boomboom_grito1)
				GM.audio_stop_sound(A.snd_boomboom_grito2)
				GM.audio_play_sound(A.snd_boomboom_grito1, 0.0, false)
				grito = 1.0
			direct = -1.0
		else:
			if grito == 1.0 and (Scr.outside_view(self) <= 0.5):
				GM.audio_stop_sound(A.snd_boomboom_grito1)
				GM.audio_stop_sound(A.snd_boomboom_grito2)
				GM.audio_play_sound(A.snd_boomboom_grito2, 0.0, false)
				grito = 0.0
			direct = 1.0
	if sprite_index == A.spr_NSMBU_boomboom_fly_b and (not GM.audio_is_playing(A.snd_boomboom_ruleta)):
		GM.audio_play_sound(A.snd_boomboom_ruleta, 1.0, true)
	elif sprite_index != A.spr_NSMBU_boomboom_fly_b or Scr.outside_view(self) > 0.5:
		GM.audio_stop_sound(A.snd_boomboom_ruleta)
	if gravity == 0.0 and sprite_index == A.spr_NSMBU_boomboom_standup_b:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.24)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.24:
			hspeed = 0.0


# from objects/obj_NSMBU_boomboom_b/Alarm_2.gml
func _alarm_2() -> void:
	sprite_index = A.spr_NSMBU_boomboom_in_b
	image_index = 0.0
	image_speed = 0.5
	stomp = 1.0
	alarm[3] = 90.0


# from objects/obj_NSMBU_boomboom_b/Alarm_3.gml
func _alarm_3() -> void:
	sprite_index = A.spr_NSMBU_boomboom_out_b
	image_index = 0.0
	image_speed = 0.5


# from objects/obj_NSMBU_boomboom_b/Alarm_4.gml
func _alarm_4() -> void:
	if vspeed == 0.0:
		sprite_index = A.spr_NSMBU_boomboom_atack_b
		image_speed = 0.5
		GM.audio_play_sound(A.snd_boomboom_grito3, 0.0, false)
		hspeed = 0.0
		alarm[1] = -1.0
		alarm[9] = -1.0
		alarm[10] = -1.0
		alarm[11] = -1.0
		alarm[3] = -1.0
		alarm[4] = -1.0
	else:
		alarm[4] = GM.choose(120.0, 320.0, 120.0, 120.0)


# from objects/obj_NSMBU_boomboom_b/Alarm_5.gml
func _alarm_5() -> void:
	sprite_index = A.spr_NSMBU_boomboom_fly_b
	image_speed = 0.5
	stomp = 4.0
	ready_v = 0.0
	fly = 1.0
	vspeed = (-(6.125 - (4.0 * swimming)))
	alarm[6] = 10.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = (-1.2 * increment)
	else:
		hspeed = (1.2 * increment)


# from objects/obj_NSMBU_boomboom_b/Alarm_7.gml
func _alarm_7() -> void:
	sprite_index = A.spr_NSMBU_boomboom_b
	image_speed = 0.5
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	alarm[10] = 20.0


# from objects/obj_NSMBU_boomboom_b/Alarm_10.gml
func _alarm_10() -> void:
	match increment:
		1.0:
			image_speed = 0.45
		1.5:
			image_speed = 0.5
		2.0:
			image_speed = 0.55
	stomp = 4.0
	ready_v = 0.0
	if hspeed == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed = -2.0
		else:
			hspeed = 2.0
	if increment == 2.0:
		alarm[4] = 50.0
	alarm[11] = 60.0


# from objects/obj_NSMBU_boomboom_b/Other_7.gml
func _animation_end() -> void:
	match sprite_index:
		A.spr_NSMBU_boomboom_standup_b:
			image_speed = 0.0
			image_index = 5.0
			alarm[7] = 20.0
		A.spr_NSMBU_boomboom_atack_b:
			alarm[5] = 1.0
		A.spr_NSMBU_boomboom_hurt_b:
			if increment == 3.0:
				sprite_index = A.spr_NSMBU_boomboom_dead_b
				vspeed = (-((4.0 - (2.5 * swimming))))
				alarm[9] = 10.0
		A.spr_NSMBU_boomboom_out_b:
			sprite_index = A.spr_NSMBU_boomboom_b
			if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
				direct = -1.0
			else:
				direct = 1.0
			alarm[10] = 20.0
		A.spr_NSMBU_boomboom_in_b:
			sprite_index = A.spr_NSMBU_boomboom_out_b
			image_speed = 0.0
			image_index = 0.0


# from objects/obj_NSMBU_boomboom_b/Other_10.gml
func _user_0() -> void:
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = (-direct)
	imdead.dead_boss = 1.0
	imdead.sprite_index = A.spr_NSMBU_boomboom_dead_b
	imdead.image_speed = 0.5
	GM.audio_stop_sound(A.snd_boomboom_dead)
	GM.audio_play_sound(A.snd_boomboom_dead, 0.0, false)
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0 and direct == 1.0:
			imdead.hspeed = -1.0
		elif GM.other.hspeed == 0.0 and direct == -1.0:
			imdead.hspeed = 1.0
	instance_destroy()


# from objects/obj_NSMBU_boomboom_b/Other_11.gml
func _user_1() -> void:
	if ready_v == 0.0:
		hspeed = 0.0
		if hitpoints == 1.0:
			i = 0.0
			while i < 11.0:
				alarm[int(i)] = -1.0
				i += 1.0
			for inst in GM.with_list(GM.instance_create(GM.other.x, (GM.other.bbox_bottom - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_effect_stomp_boss
				inst.depth = -3.0
			GM.audio_play_sound(A.snd_boomboom_dead, 0.0, false)
			sprite_index = A.spr_NSMBU_boomboom_hurt_b
			image_index = 0.0
			increment = 3.0
			var _other_0: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create(((GM.gm_round((bbox_left + bbox_right)) / 2.0) - 8.0), bbox_top, A.obj_score)):
				inst.event_user(5)
			GM.other = _other_0
			if key == 1.0:
				for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
					inst.vspeed = -4.0
				key = 0.0
		else:
			sprite_index = A.spr_NSMBU_boomboom_hurt_b
			image_index = 0.0
			if hitpoints == 3.0:
				hitpoints = 2.0
				increment = 1.5
			else:
				hitpoints = 1.0
				increment = 2.0
			vspeed = -4.0
			alarm[2] = 60.0
		ready_v = 1.0
		image_speed = 0.5
		alarm[1] = -1.0
		alarm[9] = -1.0
		alarm[10] = -1.0
		alarm[11] = -1.0
		alarm[3] = -1.0
		alarm[4] = -1.0
		stomp = -1.0


# from objects/obj_NSMBU_boomboom_b/Other_14.gml
func _user_4() -> void:
	var semisolid: GMObject = null
	var physolid: GMObject = null
	var col_one_top: GMObject = null
	var col_one_bottom: GMObject = null
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
			if fly == 2.0:
				GM.audio_play_sound(A.snd_NSMBU_thwomp_original, 0.0, false)
				sprite_index = A.spr_NSMBU_boomboom_standup_b
				image_index = 0.0
				image_speed = 0.5
				fly = 0.0
			if increment == 4.0:
				_user_7()
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _other_1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_1
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, true, false) != null and (not place_meeting(x, y, A.obj_bullebill_base)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _other_2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _other_2
			vspeed = 0.0
	if ((bbox_top - 16.0) > GM.room_height and object_index != A.obj_player_goal_parent and object_index != A.obj_podoboo) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)) and object_index != A.obj_podoboo and object_index != A.obj_player_goal_parent):
		instance_destroy()
	_user_14()


# from objects/obj_NSMBU_boomboom_b/Other_17.gml
func _user_7() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = (-direct)
	imdead.sprite_index = A.spr_NSMBU_boomboom_dead2_b
	imdead.vspeed = (-(3.2 - (1.5 * swimming)))
	imdead.dead_boss = 1.0
	imdead.image_speed = 0.5
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0 and direct == 1.0:
			imdead.hspeed = -1.0
		elif GM.other.hspeed == 0.0 and direct == -1.0:
			imdead.hspeed = 1.0
	instance_destroy()
