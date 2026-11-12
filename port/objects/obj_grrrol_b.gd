extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var direct_t: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名），同 obj_noteblock 的改名
var angle: float = 0.0
var w_wings: float = 0.0


# from objects/obj_grrrol_b/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	hardness = 99.0
	stomp = 2.0
	edible = 1.0
	modo_lava = 0.0
	direct = 1.0
	direct_t = 2.0
	ready_v = 0.0
	dead_h = 0.0
	swimming = 0.0
	angle = 0.0
	innave = 0.0
	wings = 0.0
	w_wings = 0.0
	apilar = 0.0
	bouncy = 1.0
	alarm[10] = 2.0


# from objects/obj_grrrol_b/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	_user_3()
	_user_4()
	_user_2()
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
	angle -= (3.5 * GM.gm_sign(hspeed))
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
	if (modo_lava == 0.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle") or (modo_lava == 0.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0):
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


# from objects/obj_grrrol_b/Alarm_10.gml
func _alarm_10() -> void:
	if direct_t == 2.0:
		hspeed = (-(1.2 - (0.2 * swimming)))
	else:
		hspeed = (1.2 - (0.2 * swimming))


# from objects/obj_grrrol_b/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	if other.held == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.explode = 1.0
			inst.event_user(6)
		GM.other = _o
		_user_0()


# from objects/obj_grrrol_b/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.object_index != A.obj_grinder and other.object_index != A.obj_podoboo and other.object_index != A.obj_boo and other.object_index != A.obj_banzaibill and other.object_index != A.obj_bulletbill:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_grrrol_b/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_grrrol_b/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_grrrol_b/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_index = image_index
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
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


# from objects/obj_grrrol_b/Other_12.gml
func _user_2() -> void:
	var overlap
	overlap = collision_rectangle(bbox_left, bbox_top, bbox_right, (bbox_bottom - 4.0), A.obj_grrrol, false, true)
	if overlap != null and overlap != self:  # UNSURE: GML 的 id > overlap.id（实例 id 比较），用创建序号 _uid 代替，同 obj_enemyparent
		if ((bbox_left + bbox_right) * 0.5) > ((overlap.bbox_left + overlap.bbox_right) * 0.5) or (((bbox_left + bbox_right) * 0.5) == ((overlap.bbox_left + overlap.bbox_right) * 0.5) and _uid > overlap._uid):
			hspeed = absf(hspeed)
		else:
			hspeed = (-absf(hspeed))
			if gravity == 0.0:
				vspeed = -1.0


# from objects/obj_grrrol_b/Other_13.gml
func _user_3() -> void:
	var _o: GMObject = GM.other
	var block_right
	var block_left
	var rock_right
	var rock_left
	var col_one_left
	var col_one_right
	block_right = collision_rectangle(((bbox_left - 5.0) + hspeed), (bbox_top + 6.0), bbox_left, (bbox_bottom - 6.0), A.obj_blockparent, true, false)
	block_left = collision_rectangle(bbox_right, (bbox_top + 6.0), ((bbox_right + 5.0) + hspeed), (bbox_bottom - 6.0), A.obj_blockparent, true, false)
	rock_right = collision_rectangle(((bbox_left - 5.0) + hspeed), (bbox_top + 6.0), bbox_left, (bbox_bottom - 6.0), A.obj_rockparent, true, false)
	rock_left = collision_rectangle(bbox_right, (bbox_top + 6.0), ((bbox_right + 5.0) + hspeed), (bbox_bottom - 6.0), A.obj_rockparent, true, false)
	if hspeed < 0.0 and rock_right != null:
		for inst in GM.with_list(rock_right):
			inst.alarm[0] = 1.0
	if hspeed > 0.0 and rock_left != null:
		for inst in GM.with_list(rock_left):
			inst.alarm[0] = 1.0
	if hspeed < 0.0 and block_right != null:
		GM.other = self
		for inst in GM.with_list(block_right):
			if inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s or inst.object_index == A.obj_onoffblock:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -1.5
				inst.event_user(0)
				if inst.object_index == A.obj_onoffblock:
					inst.alarm[0] = 4.0
				for inst2 in GM.with_list(self):
					inst2.hspeed = (-inst2.hspeed)
					if inst2.gravity == 0.0:
						inst2.vspeed = -1.0
			else:
				inst.alarm[2] = 1.0
		GM.other = _o
	if hspeed > 0.0 and block_left != null:
		GM.other = self
		for inst in GM.with_list(block_left):
			if inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s or inst.object_index == A.obj_onoffblock:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -1.5
				inst.event_user(0)
				if inst.object_index == A.obj_onoffblock:
					inst.alarm[0] = 4.0
				for inst2 in GM.with_list(self):
					inst2.hspeed = (-inst2.hspeed)
					if inst2.gravity == 0.0:
						inst2.vspeed = -1.0
			else:
				inst.alarm[2] = 1.0
		GM.other = _o
	if (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
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
		GM.audio_stop_sound(Scr.scr_snd_bump(self))
		GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (22.0 * GM.gm_sign(hspeed))), y, A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_stargrrrol
		hspeed = (-hspeed)
		if vspeed == 0.0:
			vspeed = -1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_grrrol_b/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, angle, GM.c_white, 1.0)
