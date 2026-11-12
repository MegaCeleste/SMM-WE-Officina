# from objects/obj_snow_ball_held（第 5 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var imagen: int = 0
var koopainside: float = 0.0
var can_dead: float = 0.0
var edible: float = 0.0
var big: float = 0.0
var midair: float = 0.0
var posy: float = 0.0
var fisica: float = 0.0
var empujar: float = 0.0
var direct_spike: float = 0.0
var angle: float = 0.0
var prevhspeed: float = 0.0
var prevvspeed: float = 0.0
var harmplayer: float = 0.0
var inmune: float = 0.0
var imheld = null
var ready_v: float = 0.0  # PORT（第 7 批）：obj_helmet 写入（原名 ready）


# from objects/obj_snow_ball_held/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			imagen = A.spr_SMB_spike_ball
		1.0:
			imagen = A.spr_SMB3_spike_ball
		2.0:
			imagen = A.spr_spike_ball
		3.0:
			imagen = A.spr_NSMBU_spike_ball
	koopainside = 0.0
	can_dead = 0.0
	hardness = 0.0
	stomp = 0.0
	edible = 1.0
	innave = 0.0
	modo_lava = 0.0
	big = 0.0
	midair = 0.0
	posy = 8.0
	fisica = 0.0
	empujar = 0.0
	direct_spike = -1.0
	angle = 0.0
	direct = -1.0
	prevhspeed = 0.0
	prevvspeed = 0.0
	harmplayer = 0.0
	swimming = 0.0
	dead_h = 0.0
	paracaidas = 0.0
	inmune = 0.0
	apilar = 0.0
	image_speed = 0.0


# from objects/obj_snow_ball_held/Step_0.gml
func _step() -> void:
	if hspeed != 0.0:
		angle -= (3.0 * GM.gm_sign(hspeed))
	if hspeed > 1.5:
		hspeed -= 0.08
		if hspeed <= 1.5:
			hspeed = 1.5
	elif hspeed < -1.5:
		hspeed += 0.08
		if hspeed >= -1.5:
			hspeed = -1.5
	_user_3()
	if G.apariencia > 1.0 or fisica == 1.0:
		_user_4()


# from objects/obj_snow_ball_held/Alarm_0.gml
func _alarm_0() -> void:
	can_dead = 1.0
	empujar = 1.0


# from objects/obj_snow_ball_held/Alarm_2.gml
func _alarm_2() -> void:
	inmune = 0.0


# from objects/obj_snow_ball_held/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if can_dead == 1.0:
		if other.hardness < 99.0 and other.object_index != A.obj_grinder and other.object_index != A.obj_podoboo and other.object_index != A.obj_boo and other.object_index != A.obj_banzaibill and other.object_index != A.obj_bulletbill:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_snow_ball_held/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if inmune == 0.0:
		if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.stompstyle == 0.0 and G.yoshi == 0.0:
			if G.apariencia != 4.0:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(1)
				GM.other = _o
				_user_1()
		elif other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and (G.yoshi > 0.0 or other.stompstyle == 1.0):
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(1)
			GM.other = _o2
			_user_0()
		elif GM.instance_exists(A.obj_invincibility):
			_user_0()
		elif empujar == 1.0:
			# ORIG-BUG: (other.bbox_left + (bbox_right / 2)) 疑为 (left + right) / 2 少了括号，照搬
			if (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)) and hspeed < 0.0:
				other.hspeed = -2.5
				_user_0()
			elif (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)) and hspeed > 0.0:
				other.hspeed = 2.5
				_user_0()


# from objects/obj_snow_ball_held/Collision_obj_snow_ball.gml
func _collision_obj_snow_ball(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
		_user_0()


# from objects/obj_snow_ball_held/Other_10.gml
func _user_0() -> void:
	var pos: float
	if sprite_height < 30.0:
		pos = y
	else:
		pos = (y - 16.0)
	for inst in GM.with_list(GM.instance_create(x, pos, A.obj_smoke)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_snow_ball_effect
			2.0:
				inst.sprite_index = A.spr_snow_ball_effect
			_:
				inst.sprite_index = A.spr_SMB3_snow_ball_effect
		inst.image_speed = 0.25
		if self.sprite_height > 30.0:
			inst.scale = 2.0
	instance_destroy()


# from objects/obj_snow_ball_held/Other_11.gml
func _user_1() -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	if sprite_height <= 30.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_snow_ball)):
			inst.alarm[2] = 4.0
	else:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_snow_ball_b)):
			inst.alarm[2] = 4.0
	instance_destroy()


# from objects/obj_snow_ball_held/Other_13.gml
func _user_3() -> void:
	var col_one_left: GMObject
	var col_one_right: GMObject
	var block_right: GMObject
	var block_left: GMObject
	var pow_right: GMObject
	var pow_left: GMObject
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		pow_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		pow_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		if hspeed < 0.0 and pow_right != null:
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pow_right):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o3
		elif hspeed < 0.0 and pow_left != null:
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pow_left):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o4
		if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
			if block_right.object_index == A.obj_onoffblock:
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(1)
				GM.other = _o5
			else:
				var _o6: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o6
		elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
			if block_left.object_index == A.obj_onoffblock:
				var _o7: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.event_user(1)
				GM.other = _o7
			else:
				var _o8: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o8
		_user_0()


# from objects/obj_snow_ball_held/Other_14.gml
func _user_4() -> void:
	var semisolid: GMObject
	var physolid: GMObject
	var col_one_top: GMObject
	var col_one_bottom: GMObject
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
		if hspeed == 0.0:
			hspeed = (1.0 * GM.gm_sign(direct_spike))
		if vspeed > 0.5:
			vspeed = ((-vspeed) / 2.0)
		elif vspeed > 0.0 and vspeed <= 0.5:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif modo_lava == 1.0:
		_user_0()
	elif swimming <= 0.5:
		gravity = 0.2
		if vspeed > 3.5:
			vspeed = 3.5
	else:
		gravity = 0.03
		if vspeed > 0.5:
			vspeed = 0.3
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
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_snow_ball_held/Other_15.gml
func _user_5() -> void:
	if sprite_height < 30.0:
		imheld = GM.instance_create(x, y, A.obj_snow_ball)
	else:
		imheld = GM.instance_create(x, y, A.obj_snow_ball_b)
	imheld.alarm[2] = 4.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky"):
		imheld.vspeed = -2.2
	else:
		imheld.vspeed = -5.0
	if GM.other.hspeed == 0.0:
		if ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) < ((bbox_left + bbox_right) / 2.0):
			imheld.hspeed = 0.6
		elif ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) > ((bbox_left + bbox_right) / 2.0):
			imheld.hspeed = -0.6
	elif GM.other.hspeed > 0.0:
		imheld.hspeed = 0.6
	elif GM.other.hspeed < 0.0:
		imheld.hspeed = -0.6
	instance_destroy()


# from objects/obj_snow_ball_held/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(imagen, 2.0, GM.gm_round(x), (y + posy), 1.0, 1.0, angle, GM.c_white, 1.0)
