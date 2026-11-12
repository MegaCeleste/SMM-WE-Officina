# 第 4 批移植，已核对。
extends "res://objects/obj_player_goal_smw.gd"

var jump_type: float = 0.0
var fall: float = 0.0
var h: float = 0.0
var pose_dont: float = 0.0
var vol: float = 0.0
var stop: float = 0.0
var anim: float = 0.0
var link_mode: float = 0.0
var ready_v: float = 0.0  # 改名(ready)，同 Node.ready
var ready2: float = 0.0
var ready3: float = 0.0
var ready4: float = 0.0
var readys: float = 0.0
var stream: float = 0.0


# from objects/obj_player_goal_smw_castle/Create_0.gml
func _create() -> void:
	for inst in GM.with_list(A.obj_levelmanager):
		inst.temp_ready = 0.0
	if G.apariencia == 3.0:
		sprite_index = Scr.scr_NSMBU_idle(self, 0.0)
	else:
		sprite_index = Scr.scr_marioidle(self)
		image_index = 0.0
	image_speed = 0.0
	jump_type = 0.0
	fall = 0.0
	h = 1.0
	gravity = 0.0
	image_speed = 0.0
	modo_lava = 0.0
	swim = 0.0
	pose = 0.0
	pose_dont = 0.0
	vol = 0.0
	stop = 0.0
	anim = 0.0
	direct = 1.0
	yview = (y + 32.0)
	helmet = 0.0
	can_walk = 0.0
	link_mode = 0.0
	hspeed = 0.0
	# DESACTIVARCONTROL
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
	ready_v = 0.0
	ready2 = 0.0
	ready3 = 0.0
	ready4 = 0.0
	readys = 0.0
	stream = -1.0
	if GM.instance_exists(A.obj_clown):
		for inst in GM.with_list(A.obj_clown):
			inst.instance_destroy()
	swimming = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	cp = 0.0
	cp_cont = 0.0
	GM.aset(color, 0.0, GM.make_colour_rgb(255.0, 255.0, 72.0))
	GM.aset(color, 1.0, GM.make_colour_rgb(254.0, 138.0, 139.0))
	GM.aset(color, 2.0, GM.make_colour_rgb(102.0, 245.0, 157.0))
	if GM.instance_find(A.obj_persistent, 0).modo_android == 1.0 and G.controles_tactiles == 1.0:
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(4)
			inst.event_user(5)
		GM.other = _o1


# from objects/obj_player_goal_smw_castle/Step_0.gml
func _step() -> void:
	var col_spring_land
	_user_3()
	if fall == 1.0 and G.powerup != -82.0:
		_user_4()
	if readys == 1.0:
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
	if gravity == 0.0:
		col_spring_land = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_spring_land, false, false)
		if hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null:
			hspeed = 0.0
			gravity = 0.0
			image_speed = 1.0
		elif hspeed > 0.0 and col_spring_land != null:
			can_walk = 1.0
			alarm[4] = 20.0
			vspeed = -2.0
			hspeed = -4.0
			var _o1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_spring_land):
				inst.event_user(1)
			GM.other = _o1
		if can_walk == 1.0:
			hspeed += 0.125
			if hspeed > 1.5:
				hspeed = 1.5
			direct = 1.0
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


# from objects/obj_player_goal_smw_castle/Step_2.gml
func _step_end() -> void:
	match G.powerup:
		0.0:
			mask_index = A.spr_smallmask
		-85.0:
			mask_index = A.spr_smallmask
		-77.0:
			mask_index = A.spr_megamask
		_:
			mask_index = A.spr_bigmask
	if G.apariencia == 3.0:
		if gravity == 0.0:
			if hspeed == 0.0:
				if fall == 1.0:
					sprite_index = Scr.scr_NSMBU_idle(self, 0.0)
					image_speed = 0.3
				else:
					image_speed = 0.0
			else:
				sprite_index = Scr.scr_NSMBU_walk(self, 0.0)
				image_speed = 1.2
		elif vspeed > 0.0:
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
	elif gravity == 0.0:
		if hspeed == 0.0:
			if G.powerup == -85.0 and link_mode == 1.0 and G.yoshi == 0.0 and (not GM.instance_exists(A.obj_brickhelmet)):
				match helmet:
					1.0:
						sprite_index = A.spr_SMB_link_victory_helmet
					2.0:
						sprite_index = A.spr_SMB_link_victory_helmet2
					_:
						sprite_index = A.spr_SMB_link_victory
				image_speed = 0.15
			elif fall == 1.0:
				sprite_index = Scr.scr_marioidle(self)
				image_speed = 0.0
				image_index = 0.0
			else:
				image_speed = 0.0
		else:
			sprite_index = Scr.scr_mariowalk(self)
			image_speed = absf((hspeed / 10.0))
	else:
		if vspeed > 0.0:
			sprite_index = Scr.scr_mariodrop(self)
		else:
			sprite_index = Scr.scr_mariojump(self)
		image_speed = 0.0


# from objects/obj_player_goal_smw_castle/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_mario_pballon):
		for inst in GM.with_list(A.obj_mario_pballon):
			inst.mov = 1.0
	else:
		hspeed = 1.5
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_clear_castle_voice, 0.0, false)
	link_mode = 2.0


# from objects/obj_player_goal_smw_castle/Alarm_5.gml
func _alarm_5() -> void:
	if G.powerup != -82.0:
		direct = 1.0


# from objects/obj_player_goal_smw_castle/Alarm_6.gml
func _alarm_6() -> void:
	if (not GM.audio_is_playing(A.snd_SMB_bowser_dead)) and (not GM.audio_is_playing(A.snd_SMB3_bowser_dead)) and (not GM.audio_is_playing(A.snd_bowser_dead)):
		match G.apariencia:
			0.0:
				if G.powerup == -85.0:
					GM.audio_play_sound(A.snd_SMB_clear_castle_link, 0.0, false)
				else:
					GM.audio_play_sound(A.snd_SMB_course_clear_castle, 0.0, false)
			1.0:
				GM.audio_play_sound(A.snd_SMB3_course_clear_castle, 0.0, false)
			2.0:
				GM.audio_play_sound(A.bgm_smwclear_castle, 0.0, false)
			3.0:
				GM.audio_play_sound(A.snd_NSMBU_clear_castle, 0.0, false)
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_levelmanager):
			inst.event_user(3)
			inst.alarm[2] = 0.0
		GM.other = _o1
		if GM.instance_exists(A.obj_castle):
			for inst in GM.with_list(A.obj_castle):
				inst.alarm[0] = 60.0
		if G.powerup == -85.0 and link_mode == 0.0 and G.yoshi == 0.0 and (not GM.instance_exists(A.obj_brickhelmet)):
			GM.audio_play_sound(A.snd_SMB_link_victory, 0.0, false)
			link_mode = 1.0
		alarm[5] = 90.0
		alarm[2] = 110.0
	else:
		alarm[6] = 2.0


# from objects/obj_player_goal_smw_castle/Other_14.gml
func _user_4() -> void:
	var solidtop
	var physolid
	if vspeed >= 0.0:
		solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0):
			y = (solidtop.y + floorf(((y - bbox_bottom) - 0.9)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.y + floorf(((y - bbox_bottom) - 0.9)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.125
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_physicssolid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_bullebill_base, true, false) != null):
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_solid, true, false) != null:
			y += 1.0
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_physicssolid, true, false) != null:
			y += 1.0
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			y += 1.0
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_bullebill_base, true, false) != null:
			y += 1.0
		vspeed = 0.0


# from objects/obj_player_goal_smw_castle/Other_40.gml
func _outside_view_0() -> void:
	if readys == 0.0:
		readys = 1.0
		hspeed = 0.0
		vspeed = 0.0
		gravity = 0.0
		x += 8.0


# from objects/obj_player_goal_smw_castle/Draw_0.gml
func _gm_draw() -> void:
	var s_yoshi: int = 0  # 局部变量提升（GML 的 var 是函数作用域）
	var s_yoshi_jump: int = 0  # 局部变量提升（GML 的 var 是函数作用域）
	if G.yoshi == 1.0:
		if GM.instance_exists(A.obj_yoshi_red):
			s_yoshi = A.spr_yoshi_red
			s_yoshi_jump = A.spr_yoshi_jump_red
		elif GM.instance_exists(A.obj_yoshi_blue):
			s_yoshi = A.spr_yoshi_blue
			s_yoshi_jump = A.spr_yoshi_jump_blue
		elif GM.instance_exists(A.obj_yoshi2):
			s_yoshi = A.spr_yoshi
			s_yoshi_jump = A.spr_yoshi_jump
		if vspeed != 0.0:
			if vspeed < 0.0:
				GM.draw_sprite_ext(s_yoshi_jump, 0.0, GM.gm_round(x), (GM.gm_round(y) + (16.0 + h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
			else:
				GM.draw_sprite_ext(s_yoshi_jump, 1.0, GM.gm_round(x), (GM.gm_round(y) + (16.0 + h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - (9.0 - h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
		elif pose == 1.0:
			GM.draw_sprite_ext(s_yoshi, 0.0, GM.gm_round(x), (GM.gm_round(y) + (16.0 + h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_mario_yoshi_goal(self), image_index, GM.gm_round(x), (y - (9.0 - h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(s_yoshi, image_index, GM.gm_round(x), (GM.gm_round(y) + (16.0 + h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - (9.0 - h)), direct, 1.0, 0.0, GM.c_white, image_alpha)
	elif G.yoshi == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + h), direct, 1.0, 0.0, GM.c_white, image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + h), direct, 1.0, 0.0, GM.instance_find(A.obj_invincibility, 0).blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
