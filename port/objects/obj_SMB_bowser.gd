extends "res://objects/obj_bossparent.gd"

var imdead = null


# from objects/obj_SMB_bowser/Create_0.gml
func _create() -> void:
	super._create()
	cooldown = 0.0
	swimming = 0.0
	prevhspeed = 0.0
	image_speed = 0.1
	paracaidas = 0.0
	firehitpoints = 40.0
	key = 0.0
	paracaidas = 0.0
	alarm[10] = 2.0


# from objects/obj_SMB_bowser/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > x:
			if sprite_index == A.spr_SMB_bowser:
				hspeed = 0.6
				if image_speed != 0.0:
					image_speed = 0.2
			else:
				if prevhspeed == 0.0:
					prevhspeed = hspeed
				hspeed = 0.0
			direct = 1.0
		else:
			direct = -1.0
			if sprite_index == A.spr_SMB_bowser:
				if prevhspeed != 0.0:
					hspeed = prevhspeed
					prevhspeed = 0.0
				elif hspeed > 0.0:
					hspeed = 0.3
					if x > (xstart + 64.0):
						hspeed = (-hspeed)
				elif hspeed < 0.0:
					hspeed = -0.3
					if x < (xstart - 64.0):
						hspeed = (-hspeed)
			else:
				if prevhspeed == 0.0:
					prevhspeed = hspeed
				hspeed = 0.0
	_user_3()
	_user_4()
	if gravity > 0.0:
		gravity = 0.1
		if vspeed > 3.2:
			vspeed = 3.2
	if cooldown > 0.0:
		cooldown -= 1.0


# from objects/obj_SMB_bowser/Alarm_0.gml
func _alarm_0() -> void:
	if vspeed == 0.0:
		# ORIG-BUG: 原版顶部检测重复检查 obj_bullebill_base，照搬。
		if collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null:
			vspeed = -0.5
		else:
			vspeed = -3.0
		alarm[0] = 120.0
	else:
		alarm[0] = 120.0


# from objects/obj_SMB_bowser/Alarm_1.gml
func _alarm_1() -> void:
	sprite_index = A.spr_SMB_bowse_fire
	image_speed = 0.0
	image_index = 0.0
	alarm[2] = 20.0


# from objects/obj_SMB_bowser/Alarm_2.gml
func _alarm_2() -> void:
	GM.audio_play_sound(A.snd_SMB3_bowser_fire, 0.0, false)
	if direct == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 29.0), (y - 2.0), A.obj_bowser_fire)):
			inst.hspeed = (1.5 * self.direct)
			inst.direct = self.direct
			inst.decender = GM.choose(0.0, 1.0, 2.0, 1.0, 0.0, 2.0)
	else:
		for inst in GM.with_list(GM.instance_create((x - 29.0), (y - 2.0), A.obj_bowser_fire)):
			inst.hspeed = (1.5 * self.direct)
			inst.direct = self.direct
			inst.decender = GM.choose(0.0, 1.0, 2.0, 1.0, 0.0, 2.0)
	sprite_index = A.spr_SMB_bowser
	image_speed = 0.1
	alarm[1] = GM.choose(90.0, 90.0, 60.0, 90.0)


# from objects/obj_SMB_bowser/Alarm_10.gml
func _alarm_10() -> void:
	hspeed = -0.3
	alarm[0] = GM.choose(100.0, 120.0, 120.0)
	alarm[1] = 90.0


# from objects/obj_SMB_bowser/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0):
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			vspeed = -0.5
		else:
			vspeed = -1.0


# from objects/obj_SMB_bowser/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_invincibility):
		return
	if G.yoshi > 0.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		if GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).get("gran_golpe") == 1.0:
			GM.audio_play_sound(A.snd_SMB_kick, 0.0, false)
			var _other_1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_1
			for inst in GM.with_list(A.obj_kuribo_drybones):
				inst.gran_golpe = 0.0
			_user_0()
		else:
			_user_15()
			firehitpoints -= 1.0
			cooldown = 6.0
			if firehitpoints <= 0.0:
				_user_0()
			other.hspeed = GM.lengthdir_x(3.0, GM.point_direction(x, y, other.x, (other.y + 16.0)))
			var _other_2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _other_2
	else:
		var _other_3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)


		GM.other = _other_3
# from objects/obj_SMB_bowser/Other_10.gml
func _user_0() -> void:
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
	imdead = GM.instance_create(x, y, A.obj_bowser_dead)
	imdead.direct = direct
	imdead.vspeed = -3.5
	if direct == 1.0:
		imdead.hspeed = -1.0
	else:
		imdead.hspeed = 1.0
	instance_destroy()


# from objects/obj_SMB_bowser/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _other_4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_4
		if hspeed < 0.0 and col_one_right != null:
			var _other_5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_5
		if direct == -1.0:
			hspeed = (-hspeed)
		else:
			hspeed = 0.0
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0


# from objects/obj_SMB_bowser/Other_14.gml
func _user_4() -> void:
	var solidtop
	var solidpow
	var solidmuncher
	var solidpinchos
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		solidpow = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_block_pow_hold, false, false)
		solidmuncher = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_muncher, false, false)
		solidpinchos = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_pinchos, false, false)
		if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0):
			y = (solidtop.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidmuncher != null and bbox_bottom < (solidmuncher.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
			y = (solidmuncher.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidpinchos != null and bbox_bottom < (solidpinchos.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
			y = (solidpinchos.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidpow != null and bbox_bottom < (solidpow.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
			y = (solidpow.y + floorf(((y - bbox_bottom) - 0.9)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_pow_hold, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_block_pow_hold, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				if not GM.audio_is_playing(A.snd_oneway):
					GM.audio_play_sound(A.snd_oneway, 0.0, false)
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.2
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null or collision_rectangle((bbox_left + 1.0), (bbox_top - 1.0), (bbox_right - 1.0), bbox_top, A.obj_pinchos, true, false) != null):
		col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
		if col_one_bottom != null:
			var _other_6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_bottom):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_6
		while collision_rectangle((bbox_left + 1.0), bbox_top, (bbox_right - 1.0), bbox_top, A.obj_solid, true, false) != null:
			y += 1.0
		vspeed = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0)):
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_SMB_bowser_dead)
		GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_bowser_dead)):
			inst.direct = self.direct
		instance_destroy()
	elif (bbox_top - 16.0) > GM.room_height and G.bg_level != "castle" and G.bg_level != "forest" and G.bg_level != "beach":
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		GM.audio_stop_sound(A.snd_SMB_bowser_dead)
		GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		if GM.instance_exists(A.obj_levelmanager):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.dead_bowser = 1.0
				inst.alarm[11] = 90.0
		instance_destroy()
	_user_14()


# from objects/obj_SMB_bowser/Draw_0.gml
func _gm_draw() -> void:
	if cooldown > 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.make_colour_rgb(255.0, 60.0, 109.0), (cooldown / 4.0))
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
