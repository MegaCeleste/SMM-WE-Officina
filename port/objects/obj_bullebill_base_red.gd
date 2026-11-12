# from objects/obj_bullebill_base_red（第 6c 批移植，已核对）
extends "res://objects/obj_bullebill_base.gd"

var mybullet = null  # 实例；null 表示 noone（GML 里的 -4）
var mybullet2 = null


# from objects/obj_bullebill_base_red/Create_0.gml
func _create() -> void:
	sprite_anim = A.spr_NSMBU_bullet_red_anim
	anim_shoot = 0.0
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bulletbill_base_red
		1.0:
			sprite_index = A.spr_SMB3_bullebill_base_red
		2.0:
			sprite_index = A.spr_bullebill_base_red
		3.0:
			sprite_index = A.spr_NSMBU_bullebill_base_red
	wings = 0.0
	w_wings = 0.0
	direct = 1.0
	dead_h = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	sprout = 0.0
	shoot_right = 0.0
	shoot_left = 0.0
	index = 0.0
	size_y = 3.0
	mybullet = null
	mybullet2 = null
	image_speed = 0.0
	alarm[0] = 90.0
	solidtop = 0.0
	alarm[1] = 1.0


# from objects/obj_bullebill_base_red/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(solidtop, A.obj_lighting) and GM.instance_exists(solidtop):
		for inst in GM.with_list(solidtop):
			inst.instance_destroy()


# from objects/obj_bullebill_base_red/Step_0.gml
func _step() -> void:
	var coli_red: GMObject
	var coli_blue: GMObject
	var coli_flip: GMObject
	super._step()
	if G.apariencia == 3.0 and anim_shoot > 0.0:
		if anim_shoot >= 12.5:
			anim_shoot = 0.0
		else:
			anim_shoot += 0.5
	if not GM.instance_exists(mybullet):
		mybullet = null
	if not GM.instance_exists(mybullet2):
		mybullet2 = null
	if not GM.veq(solidtop, A.obj_lighting) and GM.instance_exists(solidtop):
		# PORT: solidtop 在 Create 里先赋 0（object 编号），GML 里 `solidtop.x = x` 对数字等于写该 object 的所有实例；用 with_list 保持同样语义
		for inst in GM.with_list(solidtop):
			inst.x = x
			inst.y = y
	if GM.instance_exists(A.obj_mario) and place_meeting(x, y, A.obj_mario) and (GM.instance_find(A.obj_mario, 0).y + 16.0) >= y:
		if GM.instance_find(A.obj_mario, 0).x > (x + 8.0):
			for inst in GM.with_list(A.obj_mario):
				inst.x += 1.0
		else:
			for inst in GM.with_list(A.obj_mario):
				inst.x -= 1.0
	if gravity == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.1:
			hspeed = 0.0
	coli_red = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onoffplatform, false, false)
	coli_blue = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onoffplatform_blue, false, false)
	coli_flip = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_flipblock, false, false)
	if (coli_red != null and coli_red.image_index == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and x > GM.camera_get_view_x(GM.view_get_camera(0)) and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 384.0) and y > GM.camera_get_view_y(GM.view_get_camera(0)) and y < (GM.camera_get_view_x(GM.view_get_camera(0)) + 216.0)) or (coli_blue != null and coli_blue.image_index == 1.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and x > GM.camera_get_view_x(GM.view_get_camera(0)) and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 384.0)):
		_user_0()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach") and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		modo_lava = 1.0


# from objects/obj_bullebill_base_red/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_mario):
		alarm[0] = 1.0
		return
	if mybullet != null:
		alarm[0] = 1.0
		return
	elif (GM.instance_find(A.obj_mario, 0).x - 2.0) <= x and GM.instance_find(A.obj_mario, 0).x > (x - 256.0) and y >= (GM.instance_find(A.obj_mario, 0).y - 160.0) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_mario, false, false) == null):
		if not GM.veq(shoot_left, A.obj_lighting) and GM.instance_exists(shoot_left):
			alarm[0] = 15.0
		else:
			match G.apariencia:
				2.0:
					GM.audio_play_sound(A.snd_explode_red, 0.0, false)
				3.0:
					GM.audio_play_sound(A.snd_NSMBU_bullet, 0.0, false)
				_:
					GM.audio_play_sound(A.snd_SMB3_explode_red, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.depth = -10.0
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_bullet_explotion
					inst.image_speed = 0.5
					inst.depth = 11.0
			if G.apariencia == 3.0:
				anim_shoot = 1.0
			_user_1()
	elif mybullet2 != null:
		alarm[0] = 1.0
		return
	elif (GM.instance_find(A.obj_mario, 0).x + 2.0) >= (x + 16.0) and GM.instance_find(A.obj_mario, 0).x < (x + 256.0) and y >= (GM.instance_find(A.obj_mario, 0).y - 160.0) and (collision_rectangle((bbox_right + 1.0), y, (bbox_right + 1.0), (y + 15.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_right + 1.0), y, (bbox_right + 1.0), (y + 15.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_right + 1.0), y, (bbox_right + 1.0), (y + 15.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_right + 1.0), y, (bbox_right + 1.0), (y + 15.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_right + 1.0), y, (bbox_right + 1.0), (y + 15.0), A.obj_mario, false, false) == null):
		if not GM.veq(shoot_right, A.obj_lighting) and GM.instance_exists(shoot_right):
			alarm[0] = 15.0
		else:
			match G.apariencia:
				2.0:
					GM.audio_play_sound(A.snd_explode, 0.0, false)
				3.0:
					GM.audio_play_sound(A.snd_NSMBU_bullet, 0.0, false)
				_:
					GM.audio_play_sound(A.snd_SMB3_explode, 0.0, false)
			for inst in GM.with_list(GM.instance_create((x + 16.0), y, A.obj_smoke)):
				inst.depth = -10.0
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_bullet_explotion
					inst.image_speed = 0.5
					inst.depth = 11.0
				inst.direct = -1.0
			if G.apariencia == 3.0:
				anim_shoot = 1.0
			_user_2()
	else:
		alarm[0] = 60.0


# from objects/obj_bullebill_base_red/Alarm_1.gml
func _alarm_1() -> void:
	solidtop = GM.instance_create(x, y, A.obj_solidtop)
	solidtop.image_xscale = image_xscale


# from objects/obj_bullebill_base_red/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create((x + 8.0), (y + 16.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bulletbill_base_deads
			imdead.image_index = 2.0
		1.0:
			imdead.sprite_index = A.spr_SMB3_bulletbill_base_deads
			imdead.image_index = 2.0
		2.0:
			imdead.sprite_index = A.spr_bulletbill_base_deads
			imdead.image_index = 1.0
		3.0:
			imdead.sprite_index = A.spr_NSMBU_bulletbill_base_deads
			imdead.image_index = 1.0
	# ORIG-BUG: other.bbox_left + (bbox_right / 2) 中 bbox_right 是自身的而不是 other 的，other/self 混用，照搬
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_bullebill_base_red/Other_11.gml
func _user_1() -> void:
	var sprite
	var x_pos
	var y_pos
	var spd_h
	var spd_v
	if sprout == 0.0:
		mybullet = GM.instance_create(x, (y + 8.0), A.obj_bulletbull_red)
		for inst in GM.with_list(mybullet):
			inst.hspeed = (-(1.0 - (0.5 * inst.swimming)))
			if G.apariencia == 3.0:
				inst.sprite_index = A.spr_NSMBU_bulletbill_red_left
			else:
				inst.image_index = 1.0
			inst.direct = -1.0
		alarm[0] = 192.0
	else:
		sprite = Scr.scr_constant_get_sprite(self, sprout)
		x_pos = (x - 16.0)
		y_pos = y
		if sprout == -1.0:
			i = 0.0
			while i < 12.0:
				for inst in GM.with_list(GM.instance_create(x_pos, y_pos, A.obj_coin_pow)):
					spd_h = GM.random_range(1.6, 5.0)
					spd_v = GM.random_range(1.0, 1.5)
					inst.hspeed = (-(spd_h - (1.5 * inst.swimming)))
					inst.vspeed = (-(spd_v - (1.0 * inst.swimming)))
				i += 1.0
		elif sprout == -69.0 or sprout == -70.0:
			shoot_left = GM.instance_create(x_pos, y_pos, A.obj_shell_held)
			shoot_left.mytopid = 1.0
			shoot_left.sprite_index = sprite
			shoot_left.hspeed = (-(2.9 - (1.0 * swimming)))
		else:
			shoot_left = Scr.scr_sprite_make_object(self, x_pos, y_pos, sprite)
			for inst in GM.with_list(shoot_left):
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2 or inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star or inst.object_index == A.obj_hen_mushroom or inst.object_index == A.obj_megamushroom:
					inst.alarm[10] = -1.0
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2:
					inst.direct = -1.0
				if inst.object_index == A.obj_1up:
					inst.alarm[11] = 4.0
				inst.hspeed = (-(3.5 - (2.0 * inst.swimming)))
		alarm[0] = 192.0


# from objects/obj_bullebill_base_red/Other_12.gml
func _user_2() -> void:
	var sprite
	var x_pos
	var y_pos
	var spd_h
	var spd_v
	if sprout == 0.0:
		mybullet2 = GM.instance_create((x + 16.0), (y + 8.0), A.obj_bulletbull_red)
		for inst in GM.with_list(mybullet2):
			inst.hspeed = (1.0 - (0.5 * inst.swimming))
			if G.apariencia == 3.0:
				inst.sprite_index = A.spr_NSMBU_bulletbill_red_right
			else:
				inst.image_index = 0.0
			inst.direct = 1.0
		alarm[0] = 192.0
	else:
		sprite = Scr.scr_constant_get_sprite(self, sprout)
		x_pos = (x + 16.0)
		y_pos = y
		if sprout == -1.0:
			i = 0.0
			while i < 12.0:
				for inst in GM.with_list(GM.instance_create(x_pos, y_pos, A.obj_coin_pow)):
					spd_h = GM.random_range(1.6, 5.0)
					spd_v = GM.random_range(1.0, 1.5)
					inst.hspeed = (spd_h - (1.5 * inst.swimming))
					inst.vspeed = (-(spd_v - (1.0 * inst.swimming)))
				i += 1.0
		elif sprout == -69.0 or sprout == -70.0:
			shoot_left = GM.instance_create(x_pos, y_pos, A.obj_shell_held)
			shoot_left.mytopid = 1.0
			shoot_left.sprite_index = sprite
			shoot_left.hspeed = (2.9 - (1.0 * swimming))
		else:
			shoot_left = Scr.scr_sprite_make_object(self, x_pos, y_pos, sprite)
			for inst in GM.with_list(shoot_left):
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2 or inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star or inst.object_index == A.obj_hen_mushroom or inst.object_index == A.obj_megamushroom:
					inst.alarm[10] = -1.0
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2:
					inst.direct = -1.0
				if inst.object_index == A.obj_1up:
					inst.alarm[11] = 4.0
				inst.hspeed = (3.5 - (2.0 * inst.swimming))
		alarm[0] = 192.0


# from objects/obj_bullebill_base_red/Draw_0.gml
func _gm_draw() -> void:
	v = 0.0
	while v < size_y:
		if v == 0.0:
			index = 0.0
		elif v == 1.0:
			index = 1.0
		else:
			index = 2.0
		GM.draw_sprite(sprite, index, x, (y + (v * 16.0)))
		v += 1.0
	if G.apariencia == 3.0 and anim_shoot > 0.0:
		GM.draw_sprite(sprite_anim, anim_shoot, x, y)
