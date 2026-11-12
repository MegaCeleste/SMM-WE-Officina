# from objects/obj_spike_ball（第 6e 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var sud_imagen: float = 0.0
var imagen: float = 0.0
var s_part: float = 0.0
var spike_alone: float = 0.0
var spike_alone_a: float = 0.0
var fisica: float = 0.0
var direct_spike: float = 0.0
var angle: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var enemy_dead: float = 0.0
var modo_lava: float = 0.0
var spikeball = null
var i: float = 0.0
var imdead = null


# from objects/obj_spike_ball/Create_0.gml
func _create() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		sud_imagen = 1.0
	else:
		sud_imagen = 0.0
	match G.apariencia:
		0.0:
			imagen = A.spr_SMB_spike_ball
		1.0:
			imagen = A.spr_SMB3_spike_ball
		2.0:
			imagen = A.spr_spike_ball
		3.0:
			imagen = A.spr_NSMBU_spike_ball
	image_speed = 0.0
	s_part = A.spr_spike_ball_part
	spike_alone = 0.0
	spike_alone_a = 0.0
	fisica = 0.0
	direct_spike = -1.0
	angle = 0.0
	ready_v = 0.0
	enemy_dead = 0.0
	swimming = 0.0
	modo_lava = 0.0
	paracaidas = 0.0
	alarm[10] = 2.0


# from objects/obj_spike_ball/Step_0.gml
func _step() -> void:
	var _o: GMObject = GM.other
	if ready_v > 0.0:
		spikeball = collision_rectangle(bbox_left, bbox_bottom, bbox_right, ((bbox_bottom + 1.0) + vspeed), A.obj_pswitch, true, false)
		if spikeball != null and spikeball.held == 0.0 and spikeball.inup == 0.0 and spikeball.inmune == 0.0 and bbox_bottom < spikeball.bbox_top and vspeed >= 0.0:
			GM.other = self
			for inst in GM.with_list(spikeball):
				inst.event_user(7)
			GM.other = _o
		if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
			swimming = 1.0
		else:
			swimming = 0.0
		if G.modo_noche == 1.0:
			if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
				hspeed -= 0.0224
				if swimming == 1.0:
					if hspeed < -1.0:
						hspeed = -1.0
				elif hspeed < -1.2:
					hspeed = -1.2
			else:
				hspeed += 0.0324
				if swimming == 1.0:
					if hspeed > 1.0:
						hspeed = 1.0
				elif hspeed > 1.2:
					hspeed = 1.2
		if (ready_v == 1.0 and G.apariencia > 1.0) or (ready_v == 1.0 and fisica == 1.0):
			super._step()
		elif ready_v == 1.0 and G.apariencia < 2.0:
			_user_3()
		if paracaidas == 0.0:
			if spike_alone == 0.0:
				if ready_v == 1.0:
					angle -= (5.0 * GM.gm_sign(hspeed))
			elif GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
				angle -= 5.0
			else:
				angle += 5.0
			if spike_alone_a == 1.0:
				if hspeed > 1.2:
					hspeed = 1.2
					spike_alone_a = 0.0
				else:
					hspeed += 0.125
			elif spike_alone_a == 2.0:
				if hspeed < -1.2:
					hspeed = -1.2
					spike_alone_a = 0.0
				else:
					hspeed -= 0.125
		if swimming == 1.0:
			if hspeed > 1.0:
				hspeed -= 0.08
				if hspeed <= 1.0:
					hspeed = 1.0
			elif hspeed < -1.0:
				hspeed += 0.08
				if hspeed >= -1.0:
					hspeed = -1.0
		elif hspeed > 2.0:
			hspeed -= 0.08
			if hspeed <= 1.2:
				hspeed = 1.2
		elif hspeed < -1.2:
			hspeed += 0.08
			if hspeed >= -1.2:
				hspeed = -1.2
		if modo_lava == 0.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 0.0:
			modo_lava = 2.0
			if G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
		elif (modo_lava == 0.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle") or (modo_lava == 0.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0):
			modo_lava = 1.0
			if G.apariencia != 0.0:
				if G.bg_level == "castle":
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
				else:
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		elif (bbox_top - 16.0) > GM.room_height:
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) <= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (GM.instance_find(A.obj_lava_water, 0).y - 20.0)
		if paracaidas == 1.0:
			if x > (xstart + 16.0):
				if hspeed < -0.5:
					hspeed = -0.5
				else:
					hspeed -= 0.015
			elif x < (xstart - 16.0):
				if hspeed > 0.5:
					hspeed = 0.5
				else:
					hspeed += 0.015
			if gravity == 0.0:
				GM.instance_create(x, y, A.obj_paracaidas_go)
				paracaidas = 0.0
				ready_v = 1.0
				fisica = 1.0
				alarm[0] = 10.0


# from objects/obj_spike_ball/Alarm_0.gml
func _alarm_0() -> void:
	enemy_dead = 1.0


# from objects/obj_spike_ball/Alarm_10.gml
func _alarm_10() -> void:
	if spike_alone == 0.0:
		if G.apariencia == 2.0:
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
				vspeed = -1.0
			else:
				vspeed = -2.5
	elif paracaidas == 1.0:
		hspeed = -0.5
		ready_v = 1.0
		fisica = 1.0
	else:
		ready_v = 1.0
		fisica = 1.0
		alarm[0] = 10.0


# from objects/obj_spike_ball/Alarm_11.gml
func _alarm_11() -> void:
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		hspeed = -1.2
	else:
		hspeed = 1.2
	alarm[11] = 20.0


# from objects/obj_spike_ball/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if enemy_dead == 1.0 and other.hardness < 99.0 and other.object_index != A.obj_grinder and other.object_index != A.obj_podoboo and other.object_index != A.obj_podoboo_b and other.object_index != A.obj_boo and other.object_index != A.obj_banzaibill and other.object_index != A.obj_billbanzai_red and other.object_index != A.obj_bulletbill and other.object_index != A.obj_bulletbull_red:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_spike_ball/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if enemy_dead == 1.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_spike_ball/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	_user_0()


# from objects/obj_spike_ball/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and (G.yoshi > 0.0 or other.stompstyle == 1.0):
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o
		GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
		GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
	elif GM.instance_exists(A.obj_invincibility):
		_user_0()
	else:
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_spike_ball/Collision_obj_physicsparent.gml
func _collision_obj_physicsparent(other: GMObject) -> void:
	if other.object_index == A.obj_spike_ball and ready_v == 1.0:
		_user_0()


# from objects/obj_spike_ball/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	match G.apariencia:
		0.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		1.0:
			if sud_imagen == 1.0:
				s_part = A.spr_SMB3_spike_ball_part_night
			else:
				s_part = A.spr_SMB3_spike_ball_part
		2.0:
			s_part = A.spr_spike_ball_part
		3.0:
			s_part = A.spr_NSMBU_spike_ball_part
	i = 0.0
	while i < 6.0:
		imdead = GM.instance_create(x, y, A.obj_enemy_dead)
		imdead.girar = 1.0
		imdead.sprite_index = s_part
		imdead.image_index = GM.choose(0.0, 1.0, 2.0, 3.0)
		match i:
			0.0:
				imdead.vspeed = -2.0
			1.0:
				imdead.vspeed = -0.6
			2.0:
				imdead.hspeed = 0.6
			3.0:
				imdead.hspeed = 0.6
			4.0:
				imdead.hspeed = -0.6
			5.0:
				imdead.hspeed = -0.6
		i += 1.0
	instance_destroy()


# from objects/obj_spike_ball/Other_13.gml
func _user_3() -> void:
	var _o: GMObject = GM.other
	if ((hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null)) and ready_v == 1.0:
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		var pow_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		var pow_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		if hspeed < 0.0 and pow_right != null and pow_right.held == 0.0:
			GM.other = self
			for inst in GM.with_list(pow_right):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o
		if hspeed > 0.0 and pow_left != null and pow_left.held == 0.0:
			GM.other = self
			for inst in GM.with_list(pow_left):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _o
		var block_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		var block_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_blockparent, true, false)
		var rock_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_rockparent, true, false)
		var rock_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_rockparent, true, false)
		if hspeed < 0.0 and rock_right != null:
			for inst in GM.with_list(rock_right):
				inst.alarm[0] = 1.0
		if hspeed > 0.0 and rock_left != null:
			for inst in GM.with_list(rock_left):
				inst.alarm[0] = 1.0
		if hspeed < 0.0 and block_right != null and block_right.ready_v == 0.0:
			if block_right.object_index == A.obj_flipblock and G.apariencia == 1.0:
				for inst in GM.with_list(block_right):
					inst.alarm[2] = 1.0
			elif block_right.object_index == A.obj_onoffblock:
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.event_user(1)
				GM.other = _o
			else:
				GM.other = self
				for inst in GM.with_list(block_right):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o
		elif hspeed > 0.0 and block_left != null and block_left.ready_v == 0.0:
			if block_left.object_index == A.obj_flipblock and G.apariencia == 1.0:
				for inst in GM.with_list(block_left):
					inst.alarm[2] = 1.0
			elif block_left.object_index == A.obj_onoffblock:
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.event_user(1)
				GM.other = _o
			else:
				GM.other = self
				for inst in GM.with_list(block_left):
					inst.ready_v = 1.0
					inst.vspeed = -2.0
					if inst.object_index == A.obj_noteblock:
						inst.alarm[0] = 7.0
					else:
						inst.alarm[0] = 4.0
					inst.event_user(0)
				GM.other = _o
		var shield_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_shield_left, true, false)
		var shield_right = collision_rectangle(((bbox_left - 1.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_shield_right, true, false)
		if hspeed > 0.0 and shield_left != null:
			GM.other = self
			for inst in GM.with_list(shield_left):
				inst.event_user(0)
			GM.other = _o
			fisica = 1.0
			vspeed = -1.0
			hspeed = (-hspeed)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 1.0
		elif hspeed < 0.0 and shield_right != null:
			GM.other = self
			for inst in GM.with_list(shield_right):
				inst.event_user(0)
			GM.other = _o
			fisica = 1.0
			vspeed = -1.0
			hspeed = (-hspeed)
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -1.0
		else:
			_user_0()


# from objects/obj_spike_ball/Other_14.gml
func _user_4() -> void:
	var _o: GMObject = GM.other
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
		if hspeed == 0.0 and spike_alone == 0.0:
			hspeed = (1.0 * GM.gm_sign(direct_spike))
		if spike_alone == 1.0 and ready_v == 1.0:
			if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
				spike_alone_a = 1.0
			else:
				spike_alone_a = 2.0
			spike_alone = 0.0
		if vspeed > 0.25:
			vspeed = ((-vspeed) / 2.0)
		elif vspeed > 0.0 and vspeed <= 0.5:
			vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			if spike_alone == 1.0 and ready_v == 1.0:
				if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > x:
					spike_alone_a = 1.0
				else:
					spike_alone_a = 2.0
				spike_alone = 0.0
	elif modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.1:
			vspeed = 0.1
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.03
		if vspeed > 0.5:
			vspeed = 0.5
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and block.ready_v == 0.0:
				GM.other = self
				for inst in GM.with_list(block):
					inst.event_user(2)
				GM.other = _o
			vspeed = 0.0
	_user_14()


# from objects/obj_spike_ball/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(imagen, sud_imagen, GM.gm_round(x), (y + 8.0), 1.0, 1.0, angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
