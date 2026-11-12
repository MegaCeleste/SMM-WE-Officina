# from objects/obj_coin_pow（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var modo_lava: float = 0.0
var bounces: float = 0.0
var type: float = 0.0


# from objects/obj_coin_pow/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_dark
				"ghost":
					sprite_index = A.spr_SMB_coin_night
				"underground":
					sprite_index = A.spr_SMB_coin_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_night
					else:
						sprite_index = A.spr_SMB_coin
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_dark
				"ghost":
					sprite_index = A.spr_SMB3_coin_night
				"underground":
					sprite_index = A.spr_SMB3_coin_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_night
					else:
						sprite_index = A.spr_SMB3_coin
		2.0:
			sprite_index = A.spr_coin
		3.0:
			sprite_index = A.spr_NSMBU_coin
	modo_lava = 0.0
	swimming = 0.0
	bounces = 3.0
	type = 10.0
	alarm[0] = 480.0
	alarm[1] = 600.0


# from objects/obj_coin_pow/Step_0.gml
func _step() -> void:
	super._step()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
				if G.apariencia == 1.0:
					inst.sprite_index = A.spr_SMB3_splash_lava
				elif G.apariencia == 2.0:
					inst.sprite_index = A.spr_splash_lava
				inst.depth = -12.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = 1.0
			inst.image_speed = 0.15
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
				if G.apariencia == 1.0:
					inst.sprite_index = A.spr_SMB3_splash_lava
				elif G.apariencia == 2.0:
					inst.sprite_index = A.spr_splash_lava
				inst.depth = -12.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = 1.0
			inst.image_speed = 0.15
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 8.0), A.obj_smoke)):
				if G.apariencia == 1.0:
					inst.sprite_index = A.spr_SMB3_splash_lava_purple
				elif G.apariencia == 2.0:
					inst.sprite_index = A.spr_splash_lava_purple
				inst.depth = -12.0
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = 1.0
			inst.image_speed = 0.15
		instance_destroy()
	if gravity == 0.0 and absf(hspeed) > 1.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.1)) * GM.gm_sign(hspeed))


# from objects/obj_coin_pow/Alarm_0.gml
func _alarm_0() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[0] = 5.0


# from objects/obj_coin_pow/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_coin_pow/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if sprite_index == A.spr_coin or sprite_index == A.spr_SMB3_coin or sprite_index == A.spr_SMB3_coin_night or sprite_index == A.spr_SMB3_coin_dark or sprite_index == A.spr_SMB_coin or sprite_index == A.spr_SMB_coin_night or sprite_index == A.spr_SMB_coin_dark or sprite_index == A.spr_NSMBU_coin:
		GM.audio_stop_sound(Scr.scr_snd_coin(self))
		GM.audio_play_sound(Scr.scr_snd_coin(self), 0.0, false)
		G.coins += 1.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(12)
		GM.other = _o
		if G.apariencia != 0.0:
			GM.instance_create(x, y, A.obj_sparkles_coin)
		instance_destroy()
	else:
		match G.apariencia:
			2.0:
				GM.audio_stop_sound(A.snd_coin10)
				GM.audio_play_sound(A.snd_coin10, 0.0, false)
			3.0:
				GM.audio_stop_sound(A.snd_NSMBU_coin10)
				GM.audio_play_sound(A.snd_NSMBU_coin10, 0.0, false)
			_:
				GM.audio_stop_sound(A.snd_SMB3_coin10)
				GM.audio_play_sound(A.snd_SMB3_coin10, 0.0, false)
		match type:
			50.0:
				G.coins += 50.0
			30.0:
				G.coins += 30.0
			_:
				G.coins += 10.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
			inst.event_user(12)
		GM.other = _o
		if G.apariencia != 0.0:
			GM.instance_create(x, y, A.obj_sparkles_coin)
		instance_destroy()


# from objects/obj_coin_pow/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if bounces > 0.0:
				vspeed = (-((vspeed / 2.0)))
				bounces -= 1.0
			else:
				vspeed = 0.0
	elif not (swimming > 0.5):
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
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_coin_pow/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
