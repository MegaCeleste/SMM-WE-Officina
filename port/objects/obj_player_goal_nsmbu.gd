# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_smb1.gd"

var anim_pole: float = 0.0
var moverse: float = 0.0
var ready_move: float = 0.0
var jump_type: float = 0.0
var salto: float = 0.0


# from objects/obj_player_goal_nsmbu/Create_0.gml
func _create() -> void:
	for inst in GM.with_list(A.obj_levelmanager):
		inst.temp_ready = 0.0
	sprite_index = Scr.scr_NSMBU_climb_pole(self)
	image_speed = 0.5
	GM.audio_play_sound(A.snd_NSMBU_get_vine, 0.0, false)
	anim_pole = 1.0
	moverse = 0.0
	ready_move = 0.0
	jump_type = 1.0
	flagpole = -1.0
	ready4 = 0.0
	salto = 0.0
	in_solid = 0.0
	# DESACTIVARCONTROL
	var _o1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(3)
		inst.alarm[2] = 0.0
		inst.alarm[4] = -1.0
	GM.other = _o1
	anim = 0.0
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	out_view = 0.0
	swimming = 0.0
	swim = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	cp = 0.0
	cp_cont = 0.0
	GM.aset(color, 0.0, GM.make_colour_rgb(255.0, 255.0, 72.0))
	GM.aset(color, 1.0, GM.make_colour_rgb(254.0, 138.0, 139.0))
	GM.aset(color, 2.0, GM.make_colour_rgb(102.0, 245.0, 157.0))
	direct = 1.0
	yview = (y + 32.0)
	G.checkpoint = -4.0
	G.checkpointroom = -4.0
	G.pinkcoins_count = 0.0
	G.pink_coins = 0.0
	G.pink_coin1_x = 0.0
	G.pink_coin1_y = 0.0
	G.pink_coin2_x = 0.0
	G.pink_coin2_y = 0.0
	G.pink_coin3_x = 0.0
	G.pink_coin3_y = 0.0
	G.pink_coin4_x = 0.0
	G.pink_coin4_y = 0.0
	G.pink_coin5_x = 0.0
	G.pink_coin5_y = 0.0
	G.pink_coin6_x = 0.0
	G.pink_coin6_y = 0.0
	G.pink_coin7_x = 0.0
	G.pink_coin7_y = 0.0
	G.pink_coin8_x = 0.0
	G.pink_coin8_y = 0.0
	G.pink_coin9_x = 0.0
	G.pink_coin9_y = 0.0
	G.pink_coin10_x = 0.0
	G.pink_coin10_y = 0.0
	if GM.instance_exists(A.obj_enemyparent):
		for inst in GM.with_list(A.obj_enemyparent):
			if inst.object_index != A.obj_grinder:
				GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
				inst.instance_destroy()
	if GM.instance_exists(A.obj_enemyparent_held):
		for inst in GM.with_list(A.obj_enemyparent_held):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_exists(A.obj_bossparent):
		for inst in GM.with_list(A.obj_bossparent):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_exists(A.obj_clown):
		for inst in GM.with_list(A.obj_clown):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_exists(A.obj_powerupparent):
		for inst in GM.with_list(A.obj_powerupparent):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_exists(A.obj_meteorites_maker):
		for inst in GM.with_list(A.obj_meteorites_maker):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_meteorites):
		for inst in GM.with_list(A.obj_meteorites):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_exists(A.obj_meteorites_big):
		for inst in GM.with_list(A.obj_meteorites_big):
			GM.instance_create(inst.x, inst.y, A.obj_detroy_enemy)
			inst.instance_destroy()
	if GM.instance_find(A.obj_persistent, 0).modo_android == 1.0 and G.controles_tactiles == 1.0:
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(4)
			inst.event_user(5)
		GM.other = _o2


# from objects/obj_player_goal_nsmbu/Step_0.gml
func _step() -> void:
	if G.powerup == 0.0:
		mask_index = A.spr_smallmask
	else:
		mask_index = A.spr_bigmask
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0)):
		swim = 1.0
	else:
		swim = 0.0
	anim += (0.065 + (absf(hspeed) / 7.5))
	if ready_v == 2.0 or ready_v == 3.0:
		if bbox_top > GM.room_height:
			y = (GM.room_height - 64.0)
			visible = false
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			swimming = 1.0
		else:
			swimming = 0.0
		_user_3()
		_user_4()
		if ready_move == 1.0:
			if swim == 1.0:
				hspeed += 0.1
				if hspeed > 0.6:
					hspeed = 0.6
			else:
				hspeed += 0.08
				if hspeed > 1.5:
					hspeed = 1.5
		if ready_v == 2.0:
			if hspeed < 0.0:
				ready_v = 3.0
				event_user(15)
				hspeed = 0.0
	if out_view == 1.0:
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
	if collision_rectangle((bbox_left + 2.0), bbox_bottom, (bbox_right - 2.0), (bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((bbox_left + 2.0), bbox_bottom, (bbox_right - 2.0), (bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null:
		in_solid = 1.0
	if G.star_flash == 1.0:
		if cp_cont == 0.0:
			flashAlpha -= 0.05
			if flashAlpha < 0.6:
				cp_cont = 1.0
				if cp < 1.0:
					cp += 1.0
				else:
					cp = 0.0
		else:
			flashAlpha += 0.05
			if flashAlpha > 0.8:
				cp_cont = 0.0
		blend_star = color[int(cp)]
	_user_13()


# from objects/obj_player_goal_nsmbu/Alarm_4.gml
func _alarm_4() -> void:
	if direct == 1.0:
		direct = -1.0
		x += 8.0
	alarm[11] = 5.0


# from objects/obj_player_goal_nsmbu/Alarm_5.gml
func _alarm_5() -> void:
	if ready4 == 1.0:
		ready_v = 2.0
		anim_pole = 0.0
		GM.audio_play_sound(A.snd_NSMBU_clear, 0.0, false)
		sprite_index = Scr.scr_NSMBU_goal_pole(self)
		image_speed = 0.5
		image_index = 0.0
		alarm[6] = 3.0
		if swimming == 1.0:
			vspeed = -2.125
			hspeed = 1.0
		else:
			vspeed = -3.125
			hspeed = 1.3
		x += 2.0
		direct = 1.0
		if GM.instance_exists(A.obj_flagpole):
			for inst in GM.with_list(A.obj_flagpole):
				inst.alarm[1] = 126.0
				inst.alarm[0] = 360.0
	else:
		alarm[5] = 5.0


# from objects/obj_player_goal_nsmbu/Alarm_6.gml
func _alarm_6() -> void:
	salto = 1.0


# from objects/obj_player_goal_nsmbu/Collision_obj_flagpole.gml
func _collision_obj_flagpole(other: GMObject) -> void:
	if (ready_v == 0.0 and ready4 == 0.0 and GM.instance_exists(A.obj_SMB_flag) and GM.instance_find(A.obj_SMB_flag, 0).ready_v == 1.0 and y > (other.y + 128.0) and in_solid == 0.0) or (ready_v == 0.0 and ready4 == 0.0 and in_solid == 1.0):
		vspeed = 0.0
		if y > (GM.instance_find(A.obj_flagpole, 0).y + 128.0):
			y = (GM.instance_find(A.obj_flagpole, 0).y + 128.0)
		ready4 = 1.0


# from objects/obj_player_goal_nsmbu/Other_7.gml
func _animation_end() -> void:
	if sprite_index == Scr.scr_NSMBU_climb_pole(self):
		image_speed = 0.0
		image_index = 10.0
		alarm[11] = 5.0


# from objects/obj_player_goal_nsmbu/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o1
		if moverse == 1.0:
			ready_move = 0.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
	elif (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		if moverse == 1.0:
			hspeed = 0.0
			ready_move = 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0
	elif moverse == 1.0:
		ready_move = 1.0


# from objects/obj_player_goal_nsmbu/Other_23.gml
func _user_13() -> void:
	if G.powerup == 0.0:
		mask_index = A.spr_smallmask
	else:
		mask_index = A.spr_bigmask
	if ready_move == 1.0:
		if gravity == 0.0:
			sprite_index = Scr.scr_NSMBU_walk(self, swim)
			if swim == 1.0:
				image_speed = 0.5
			else:
				image_speed = 1.5
		elif place_free(x, (y + 1.0)) and vspeed > 0.0:
			match jump_type:
				1.0:
					sprite_index = Scr.scr_NSMBU_jump1(self)
				2.0:
					sprite_index = Scr.scr_NSMBU_jump2(self)
				3.0:
					sprite_index = Scr.scr_NSMBU_jump3(self)
			if image_index >= 34.5:
				image_speed = 0.0
				image_index = 34.0
			else:
				image_speed = 0.5
		else:
			match jump_type:
				1.0:
					sprite_index = Scr.scr_NSMBU_jump1(self)
				2.0:
					sprite_index = Scr.scr_NSMBU_jump2(self)
				3.0:
					sprite_index = Scr.scr_NSMBU_jump3(self)
			if image_index >= 19.5:
				image_speed = 0.0
				image_index = 19.5
			else:
				image_speed = 0.5
	if ready_v < 2.0:
		sprite_index = Scr.scr_NSMBU_climb_pole(self)
	elif sprite_index == Scr.scr_NSMBU_goal_pole(self):
		if image_index >= 13.5:
			image_speed = 0.0
			image_index = 13.0
		else:
			image_speed = 0.5
		if gravity == 0.0 and salto == 1.0:
			sprite_index = Scr.scr_NSMBU_standup_pole(self)
			image_index = 0.0
			hspeed = 0.0
	elif sprite_index == Scr.scr_NSMBU_standup_pole(self):
		if image_index >= 8.7:
			sprite_index = Scr.scr_NSMBU_walk(self, swimming)
			image_index = 0.0
			image_speed = 1.2
			moverse = 1.0
			hspeed = 1.5
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_goal, A.snd_NSMBU_goal2), 0.0, false)
		else:
			image_speed = 0.3
			hspeed = 0.0


# from objects/obj_player_goal_nsmbu/Draw_0.gml
func _gm_draw() -> void:
	var dir: float  # 局部变量提升（GML 的 var 是函数作用域）
	if anim_pole == 1.0:
		dir = 1.0
	else:
		dir = direct
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (GM.gm_round(y) + 1.0), dir, 1.0, 0.0, GM.c_white, image_alpha)
	if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
		GM.shader_set(A.sha_blendreplace)
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (GM.gm_round(y) + 1.0), dir, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
		GM.shader_reset()
