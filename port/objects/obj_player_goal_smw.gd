# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_parent.gd"

var pose: float = 0.0
var helmet: float = 0.0
var can_walk: float = 0.0
var xx: float = 0.0
var swim: float = 0.0
var modo_lava: float = 0.0


# from objects/obj_player_goal_smw/Create_0.gml
func _create() -> void:
	var _o1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(3)
		inst.alarm[2] = 0.0
		inst.alarm[4] = -1.0
		inst.temp_ready = 0.0
	GM.other = _o1
	blend_star = GM.c_white
	flashAlpha = 1.0
	cp = 0.0
	cp_cont = 0.0
	GM.aset(color, 0.0, GM.make_colour_rgb(255.0, 255.0, 72.0))
	GM.aset(color, 1.0, GM.make_colour_rgb(254.0, 138.0, 139.0))
	GM.aset(color, 2.0, GM.make_colour_rgb(102.0, 245.0, 157.0))
	pose = 0.0
	helmet = 0.0
	can_walk = 1.0
	xx = 0.0
	hspeed = 0.0
	alarm[2] = 440.0
	if GM.instance_exists(A.obj_goalgate):
		for inst in GM.with_list(A.obj_goalgate):
			inst.alarm[0] = 240.0
	if GM.instance_exists(A.obj_mario_pballon):
		for inst in GM.with_list(A.obj_mario_pballon):
			inst.speed = 0.0
			inst.mov = 1.0
	swimming = 0.0
	swim = 0.0
	modo_lava = 0.0
	super._create()
	# DESACTIVARCONTROL


# from objects/obj_player_goal_smw/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_3()
	if G.powerup != -82.0:
		_user_4()
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swim = 1.0
	if G.star_flash == 1.0:
		if cp_cont == 0.0:
			flashAlpha -= 0.15
			if flashAlpha < 0.3:
				cp_cont = 1.0
				if cp < 2.0:
					cp += 1.0
				else:
					cp = 0.0
		else:
			flashAlpha += 0.15
			if flashAlpha > 0.9:
				cp_cont = 0.0
		blend_star = color[int(cp)]
	if gravity == 0.0 and G.powerup != -82.0:
		if can_walk == 1.0:
			if swimming == 1.0:
				hspeed += 0.125
				if hspeed > 0.5:
					hspeed = 0.5
			else:
				hspeed += 0.125
				if hspeed > 1.5:
					hspeed = 1.5
			direct = 1.0
		if GM.instance_exists(A.obj_ground3):
			if x >= (GM.instance_find(A.obj_ground3, 0).x + 106.0):
				hspeed = 0.0
				can_walk = 0.0
				direct = -1.0
				sprite_index = Scr.scr_marioidle(self)
				image_speed = 0.0
				image_index = 0.0
		elif x >= (xstart + 106.0):
			hspeed = 0.0
			direct = -1.0
			can_walk = 0.0
			sprite_index = Scr.scr_marioidle(self)
			image_speed = 0.0
			image_index = 0.0


# from objects/obj_player_goal_smw/Step_2.gml
func _step_end() -> void:
	if G.powerup == 0.0:
		mask_index = A.spr_smallmask
	elif G.powerup == -77.0:
		mask_index = A.spr_megamask
	elif G.powerup == -85.0:
		mask_index = A.spr_smallmask
	else:
		mask_index = A.spr_bigmask
	if gravity == 0.0:
		if hspeed == 0.0:
			if pose == 1.0:
				sprite_index = Scr.scr_mariogoal(self)
				image_speed = 0.0
				if helmet == 1.0:
					for inst in GM.with_list(A.obj_helmet):
						inst.instance_destroy()
					image_index = 1.0
				elif helmet == 2.0:
					for inst in GM.with_list(A.obj_helmet_spiny):
						inst.instance_destroy()
					image_index = 2.0
				else:
					image_index = 0.0
		elif hspeed != 0.0 or can_walk == 2.0:
			sprite_index = Scr.scr_mariowalk(self)
			if hspeed != 0.0:
				image_speed = absf((hspeed / 10.0))
			else:
				image_speed = 0.15
	elif swimming == 1.0 and swim == 1.0:
		sprite_index = Scr.scr_marioswimhold(self)
		image_speed = 0.15
	else:
		if vspeed > 0.0:
			sprite_index = Scr.scr_mariodrop(self)
		else:
			sprite_index = Scr.scr_mariojump(self)
		image_speed = 0.0


# from objects/obj_player_goal_smw/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_ground3) and x >= (GM.instance_find(A.obj_ground3, 0).x + 104.0):
		pose = 1.0
	else:
		hspeed = 0.0
		can_walk = 0.0
		sprite_index = Scr.scr_marioidle(self)
		image_speed = 0.0
		image_index = 0.0
		alarm[3] = 30.0


# from objects/obj_player_goal_smw/Alarm_3.gml
func _alarm_3() -> void:
	sprite_index = Scr.scr_marioduck(self)
	image_speed = 0.0
	image_index = 0.0
	direct = -1.0


# from objects/obj_player_goal_smw/Alarm_4.gml
func _alarm_4() -> void:
	can_walk = 1.0


# from objects/obj_player_goal_smw/Other_13.gml
func _user_3() -> void:
	xx = absf(hspeed)
	if (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null):
		hspeed = 0.0
		if can_walk == 1.0:
			can_walk = 2.0
	if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null:
		x += xx
	if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null:
		x -= xx
	if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null:
		x += xx
	if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null:
		x -= xx
	if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null:
		x += xx
	if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null:
		x -= xx
	if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null:
		x += xx
	if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null:
		x -= xx


# from objects/obj_player_goal_smw/Draw_0.gml
func _gm_draw() -> void:
	var jump: float  # 局部变量提升（GML 的 var 是函数作用域）
	var pos: float  # 局部变量提升（GML 的 var 是函数作用域）
	var s_yoshi: int  # 局部变量提升（GML 的 var 是函数作用域）
	var s_yoshi_jump: int  # 局部变量提升（GML 的 var 是函数作用域）
	var sprite  # 局部变量提升（GML 的 var 是函数作用域）
	if G.yoshi > 0.0:
		if GM.instance_exists(A.obj_yoshi_red):
			s_yoshi = A.spr_yoshi_red
			s_yoshi_jump = A.spr_yoshi_jump_red
		elif GM.instance_exists(A.obj_yoshi_blue):
			s_yoshi = A.spr_yoshi_blue
			s_yoshi_jump = A.spr_yoshi_jump_blue
		else:
			s_yoshi = A.spr_yoshi
			s_yoshi_jump = A.spr_yoshi_jump
		if vspeed != 0.0:
			if vspeed < 0.0:
				jump = 0.0
			else:
				jump = 1.0
			GM.draw_sprite_ext(s_yoshi_jump, jump, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - 8.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
				GM.shader_set(A.sha_blendreplace)
				GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - 8.0), direct, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
				GM.shader_reset()
		else:
			if pose == 1.0:
				pos = 0.0
				sprite = Scr.scr_mario_yoshi_goal(self)
			else:
				pos = image_index
				sprite = Scr.scr_marioride(self)
			GM.draw_sprite_ext(s_yoshi, pos, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(sprite, image_index, GM.gm_round(x), (y - 8.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
				GM.shader_set(A.sha_blendreplace)
				GM.draw_sprite_ext(sprite, image_index, GM.gm_round(x), (y - 8.0), direct, 1.0, 0.0, blend_star, flashAlpha)
				GM.shader_reset()
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
