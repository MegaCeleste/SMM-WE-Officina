extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var wings_anim: float = 0.0
var prevhspeed: float = 0.0
var charge: float = 0.0
var firehitpoints: float = 0.0
var inwall: float = 0.0
var xx: float = 0.0
var sprite: int = 0


# from objects/obj_bowserjr_shell/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bowserjr_shell
		1.0:
			sprite_index = A.spr_SMB3_bowserjr_shell
		2.0:
			sprite_index = A.spr_bowserjr_shell
		3.0:
			sprite_index = A.spr_NSMBU_bowserjr_shell
	hardness = 99.0
	stomp = 2.0
	edible = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	dead_h = 0.0
	innave = 0.0
	direct = 1.0
	swimming = 0.0
	modo_lava = 0.0
	key = 0.0
	prevhspeed = 0.0
	charge = 0.0
	firehitpoints = 10.0
	hitpoints = 0.0
	inwall = 0.0
	xx = 1.0
	sprite = A.spr_NSMBU_bowserjr_shell
	if G.apariencia == 3.0:
		image_speed = 0.6
	else:
		image_speed = 0.3
	if G.apariencia == 3.0:
		alarm[11] = 2.0
	alarm[10] = 30.0
	alarm[0] = 420.0


# from objects/obj_bowserjr_shell/Step_0.gml
func _step() -> void:
	if absf(hspeed) < 1.0:
		xx = 1.0
	else:
		xx = absf(hspeed)
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if stomp == -1.0:
		vspeed = 0.0
		gravity = 0.0
	else:
		_user_3()
		_user_4()
		_user_6()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		instance_destroy()
	elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
		instance_destroy()
	elif (bbox_top - 16.0) > GM.room_height:
		if key == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0


# from objects/obj_bowserjr_shell/Step_2.gml
func _step_end() -> void:
	if charge == 1.0:
		if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x < x:
			if hspeed < -2.0:
				hspeed = -2.0
			else:
				hspeed -= 0.0545
		elif hspeed > 2.0:
			hspeed = 2.0
		else:
			hspeed += 0.0545
		if hspeed < 0.0 and (collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left + hspeed), (bbox_top + 1.0), (bbox_left + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
			x += xx
		# ORIG-BUG: 向右移动同样检查 obj_onewaygate_right，照搬原文。
		if hspeed > 0.0 and (collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_right + hspeed), (bbox_top + 1.0), (bbox_right + hspeed), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
			x -= xx


# from objects/obj_bowserjr_shell/Alarm_0.gml
func _alarm_0() -> void:
	charge = 0.0
	hspeed = 0.0
	vspeed = -2.0
	alarm[1] = 16.0


# from objects/obj_bowserjr_shell/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).x > (x - 184.0) and GM.instance_find(A.obj_mario, 0).x < (x + 184.0):
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_bowserjr_outside, 0.0, false)
			sprite_index = A.spr_NSMBU_bowserjr_shell_outside
			image_index = 0.0
			image_speed = 0.5
			stomp = -1.0
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_bowserjr)):
				inst.firehitpoints = self.firehitpoints
				inst.hitpoints = self.hitpoints
				inst.wings = self.wings
				inst.key = self.key
			instance_destroy()
	else:
		charge = 1.0
		alarm[0] = 120.0


# from objects/obj_bowserjr_shell/Alarm_10.gml
func _alarm_10() -> void:
	charge = 1.0


# from objects/obj_bowserjr_shell/Alarm_11.gml
func _alarm_11() -> void:
	for inst in GM.with_list(GM.instance_create_depth(x, y, -1.0, A.obj_shell_trail)):
		inst.value = 2.0
		inst.sprite_index = self.sprite_index
	alarm[11] = 2.0


# from objects/obj_bowserjr_shell/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0):
		vspeed = -2.0


# from objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	if hspeed != 0.0 and GM.instance_exists(self) and o.hardness < 99.0:
		if GM.instance_exists(A.obj_mario):
			match G.apariencia:
				0.0:
					Scr.scr_musicalscale_SMB3(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
				1.0:
					Scr.scr_musicalscale_SMB3(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
				2.0:
					Scr.scr_musicalscale(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
				3.0:
					Scr.scr_musicalscale_kick(self, GM.instance_find(A.obj_mario, 0), other, 1.0)
		var _other_1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _other_1


# from objects/obj_bowserjr_shell/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if hspeed != 0.0 and GM.instance_exists(self):
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _other_2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _other_2


# from objects/obj_bowserjr_shell/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_bowserjr_shell_outside:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_NSMBU_bowserjr)):
			inst.firehitpoints = self.firehitpoints
			inst.hitpoints = self.hitpoints
			inst.wings = self.wings
			inst.key = self.key
		instance_destroy()


# from objects/obj_bowserjr_shell/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.direct = direct
	imdead.dead_boss = 1.0
	if G.apariencia != 3.0:
		imdead.girar = 1.0
		imdead.image_speed = 0.15
	else:
		imdead.image_speed = 0.5
	if key == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
		key = 0.0
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bowserjr_dead
		1.0:
			imdead.sprite_index = A.spr_SMB3_bowserjr_dead
		2.0:
			imdead.sprite_index = A.spr_bowserjr_dead
		3.0:
			imdead.sprite_index = A.spr_NSMBU_bowserjr_dead
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 和自身 bbox_right 混用，照搬原文。
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


# from objects/obj_bowserjr_shell/Other_11.gml
func _user_1() -> void:
	return


# from objects/obj_bowserjr_shell/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	var pow_right
	var pow_left
	if (hspeed < 0.0 and collision_rectangle(((bbox_left + hspeed) - 2.0), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(((bbox_right + hspeed) + 2.0), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left + hspeed) - 2.0), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(((bbox_right + hspeed) + 2.0), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left + hspeed) - 2.0), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(((bbox_right + hspeed) + 2.0), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left + hspeed) - 2.0), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(((bbox_right + hspeed) + 2.0), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle(((bbox_left + hspeed) - 2.0), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle(((bbox_right + hspeed) + 2.0), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		pow_right = collision_rectangle(((bbox_left - 3.0) + hspeed), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		pow_left = collision_rectangle(bbox_right, (bbox_top + 4.0), ((bbox_right + 1.0) + hspeed), (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false)
		if hspeed < 0.0 and pow_right != null and pow_right.held == 0.0:
			var _other_3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pow_right):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _other_3
		if hspeed > 0.0 and pow_left != null and pow_left.held == 0.0:
			var _other_4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pow_left):
				inst.explode = 1.0
				inst.event_user(6)
			GM.other = _other_4
		if hspeed > 0.0 and col_one_left != null:
			var _other_5: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_5
		elif hspeed < 0.0 and col_one_right != null:
			var _other_6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _other_6
		elif not GM.audio_is_playing(Scr.scr_snd_bump(self)):
			GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		GM.instance_create(x, y, A.obj_blockbumper)
		hspeed = 0.0
		if collision_rectangle((bbox_left + 3.0), bbox_bottom, (bbox_right - 3.0), (bbox_bottom + 2.0), A.obj_solidtop, false, false) != null or collision_rectangle((bbox_left + 3.0), bbox_bottom, (bbox_right - 3.0), (bbox_bottom + 2.0), A.obj_physicssolid, false, false) != null:
			vspeed = (-(3.0 - (2.0 * swimming)))


# from objects/obj_bowserjr_shell/Other_16.gml
func _user_6() -> void:
	if gravity == 0.0:
		if hspeed < 0.0:
			if (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom - 1.0), (bbox_left + 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				vspeed = (-(2.5 - (1.0 * swimming)))
		elif hspeed > 0.0:
			if (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_solidtop, false, false) == null) and (collision_rectangle((bbox_right - 3.0), (bbox_bottom - 1.0), (bbox_right - 3.0), (bbox_bottom + 4.0), A.obj_physicssolid, false, false) == null):
				vspeed = (-(2.5 - (1.0 * swimming)))
