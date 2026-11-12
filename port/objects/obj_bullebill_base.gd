# from objects/obj_bullebill_base（第 6c 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var sprite_anim: int = 0  ## sprite 编号
var anim_shoot: float = 0.0
var sprites: int = 0  ## sprite 编号
var wings: float = 0.0
var w_wings: float = 0.0
var dead_h: float = 0.0
var apilar: float = 0.0
var modo_lava: float = 0.0
var sprout: float = 0.0
var shoot_right = null  # Create 里赋 0，之后可能是实例
var shoot_left = null  # 同上
var index: float = 0.0
var size_y: float = 0.0
var solidtop = null
var imdead = null
var i: float = 0.0
var v: float = 0.0
var sprite = null  # obj_bullebill_base_res / _red_res 在实例创建后写入（sprite = other.sprite_index）；base 的 Draw 不读它，red 的 Draw 读它


# from objects/obj_bullebill_base/Create_0.gml
func _create() -> void:
	var dark: float
	sprite_anim = A.spr_NSMBU_bullet_anim
	anim_shoot = 0.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	sprite_index = A.spr_SMB_bulletbill_base
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprites = A.spr_SMB_bulletbill_base_night
			else:
				sprites = A.spr_SMB_bulletbill_base
		1.0:
			if dark == 1.0:
				sprites = A.spr_SMB3_bullebill_base_night
			else:
				sprites = A.spr_SMB3_bullebill_base
		2.0:
			sprites = A.spr_bullebill_base
		3.0:
			sprites = A.spr_NSMBU_bullebill_base
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
	image_speed = 0.0
	alarm[0] = 90.0
	solidtop = 0.0
	alarm[1] = 1.0


# from objects/obj_bullebill_base/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(solidtop, A.obj_lighting) and GM.instance_exists(solidtop):
		for inst in GM.with_list(solidtop):
			inst.instance_destroy()


# from objects/obj_bullebill_base/Step_0.gml
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
	# ORIG-BUG: 红色开关分支里 y 与 camera_get_view_x + 216 比较（应为 view_y），照搬
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


# from objects/obj_bullebill_base/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_mario):
		alarm[0] = 1.0
		return
	if (GM.instance_find(A.obj_mario, 0).x - 2.0) <= x and GM.instance_find(A.obj_mario, 0).x > (x - 256.0) and y >= (GM.instance_find(A.obj_mario, 0).y - 160.0) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), y, (bbox_left - 1.0), (y + 15.0), A.obj_mario, false, false) == null):
		if not GM.veq(shoot_left, A.obj_lighting) and GM.instance_exists(shoot_left):
			alarm[0] = 15.0
		else:
			match G.apariencia:
				2.0:
					GM.audio_play_sound(A.snd_explode, 0.0, false)
				3.0:
					GM.audio_play_sound(A.snd_NSMBU_bullet, 0.0, false)
				_:
					GM.audio_play_sound(A.snd_SMB3_explode, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.depth = -10.0
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_bullet_explotion
					inst.image_speed = 0.5
					inst.depth = 11.0
			if G.apariencia == 3.0:
				anim_shoot = 1.0
			_user_1()
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


# from objects/obj_bullebill_base/Alarm_1.gml
func _alarm_1() -> void:
	solidtop = GM.instance_create(x, y, A.obj_solidtop)


# from objects/obj_bullebill_base/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0):
		vspeed = (-(3.0 - (1.5 * swimming)))


# from objects/obj_bullebill_base/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	if other.visible == true:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			GM.audio_stop_sound(Scr.scr_snd_kick(self))
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_bullebill_base/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.hardness != 6.0 and other.visible == true and other.object_index != A.obj_grinder and other.object_index != A.obj_banzaibill and other.object_index != A.obj_podoboo and other.object_index != A.obj_angrysun and other.object_index != A.obj_cheepcheep and other.object_index != A.obj_thwomp and other.object_index != A.obj_boo and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			if other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(other):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				GM.audio_stop_sound(Scr.scr_snd_kick(self))
				GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(0)
				GM.other = _o


# from objects/obj_bullebill_base/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
		other.y += vspeed
	if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bullebill_base/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and other.state > 1.0:
		other.y += vspeed
	if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (other.state < 2.0 or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
		GM.instance_create(other.x, other.y, A.obj_deadmario)
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_bullebill_base/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	if other.object_index != A.obj_cap and other.object_index != A.obj_propellershroom:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			GM.instance_create(other.x, other.y, A.obj_smoke)
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_bullebill_base/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create((x + 8.0), y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.image_speed = 0.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bulletbill_base_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_bulletbill_base_deads
		2.0:
			imdead.sprite_index = A.spr_bulletbill_base_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_bulletbill_base_deads
	if G.apariencia < 2.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			imdead.image_index = 1.0
		else:
			imdead.image_index = 0.0
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


# from objects/obj_bullebill_base/Other_11.gml
func _user_1() -> void:
	var sprite
	var x_pos
	var y_pos
	var spd_h
	var spd_v
	if sprout == 0.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_bulletbill)):
			inst.hspeed = (-(1.0 - (0.5 * self.swimming)))
			inst.direct = -1.0
		alarm[0] = 192.0
	else:
		sprite = Scr.scr_constant_get_sprite(self, sprout)
		x_pos = (x - 16.0)
		y_pos = y
		if sprout == -1.0:
			i = 0.0
			while i < 10.0:
				for inst in GM.with_list(GM.instance_create(x_pos, y_pos, A.obj_coin_pow)):
					spd_h = GM.random_range(1.6, 4.0)
					spd_v = GM.random_range(1.0, 1.5)
					inst.hspeed = (-(spd_h - (1.5 * self.swimming)))
					inst.vspeed = (-(spd_v - (1.0 * self.swimming)))
				i += 1.0
		elif sprout == -69.0 or sprout == -70.0:
			shoot_left = GM.instance_create(x_pos, y_pos, A.obj_shell_held)
			shoot_left.mytopid = 1.0
			shoot_left.sprite_index = sprite
			shoot_left.hspeed = (-(2.9 - (1.0 * GM.other.swimming)))  # 非 with 里的 other：按 U14 此时 GM.other 就是自身
		else:
			shoot_left = Scr.scr_sprite_make_object(self, x_pos, y_pos, sprite)
			for inst in GM.with_list(shoot_left):
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2 or inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star or inst.object_index == A.obj_hen_mushroom or inst.object_index == A.obj_megamushroom:
					inst.alarm[10] = -1.0
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2:
					inst.direct = -1.0
				if inst.object_index == A.obj_1up:
					inst.alarm[11] = 4.0
				inst.hspeed = (-(3.5 - (2.0 * self.swimming)))
		alarm[0] = 192.0


# from objects/obj_bullebill_base/Other_12.gml
func _user_2() -> void:
	var sprite
	var x_pos
	var y_pos
	var spd_h
	var spd_v
	if sprout == 0.0:
		for inst in GM.with_list(GM.instance_create((x + 16.0), y, A.obj_bulletbill)):
			inst.hspeed = (1.0 - (0.5 * self.swimming))
			inst.direct = 1.0
		alarm[0] = 192.0
	else:
		sprite = Scr.scr_constant_get_sprite(self, sprout)
		x_pos = (x + 16.0)
		y_pos = y
		if sprout == -1.0:
			i = 0.0
			while i < 10.0:
				for inst in GM.with_list(GM.instance_create(x_pos, y_pos, A.obj_coin_pow)):
					spd_h = GM.random_range(1.6, 4.0)
					spd_v = GM.random_range(1.0, 1.5)
					inst.hspeed = (spd_h - (1.5 * self.swimming))
					inst.vspeed = (-(spd_v - (1.0 * self.swimming)))
				i += 1.0
		# ORIG-BUG: 向右发射时存的仍是 shoot_left（不是 shoot_right），所以 Alarm_0 里对 shoot_right 的检查永远是 0。照搬
		elif sprout == -69.0 or sprout == -70.0:
			shoot_left = GM.instance_create(x_pos, y_pos, A.obj_shell_held)
			shoot_left.mytopid = 1.0
			shoot_left.sprite_index = sprite
			shoot_left.hspeed = (2.9 - (1.0 * GM.other.swimming))  # 同上（U14）
		# ORIG-BUG: 同上，向右也存到 shoot_left
		else:
			shoot_left = Scr.scr_sprite_make_object(self, x_pos, y_pos, sprite)
			for inst in GM.with_list(shoot_left):
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2 or inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star or inst.object_index == A.obj_hen_mushroom or inst.object_index == A.obj_megamushroom:
					inst.alarm[10] = -1.0
				if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2:
					inst.direct = -1.0
				if inst.object_index == A.obj_1up:
					inst.alarm[11] = 4.0
				inst.hspeed = (3.5 - (2.0 * self.swimming))
		alarm[0] = 192.0


# from objects/obj_bullebill_base/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		hspeed = 0.0
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


# from objects/obj_bullebill_base/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (((GM.sprite_get_bbox_bottom(sprite_index) + 1.0) * size_y) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (((GM.sprite_get_bbox_bottom(sprite_index) + 1.0) * size_y) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.03:
			vspeed = 0.03
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()
	_user_14()


# from objects/obj_bullebill_base/Other_24.gml
func _user_14() -> void:
	var lava_lift
	var check
	var phy_check
	var spd
	var bull_1
	var bull_2
	var bull_3
	var bull_4
	lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
	if lava_lift != null and vspeed >= 0.0:
		check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 3.0) + vspeed), A.obj_solidtop, false, false)
		phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 3.0) + vspeed), A.obj_physicssolid, false, false)
		if (check != null and check != lava_lift) or phy_check != null:
			return
		y = (lava_lift.bbox_top - (((GM.sprite_get_bbox_bottom(sprite_index) + 1.0) * size_y) - GM.sprite_get_yoffset(sprite_index)))
		spd = lava_lift.hspeed
		bull_1 = collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
		bull_2 = collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
		if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed > 0.0 and ((bull_1 == null) or (bull_1 != null and bull_1 == self))) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed < 0.0 and ((bull_2 == null) or (bull_2 != null and bull_2 == self))) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
			x += lava_lift.hspeed
		bull_3 = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
		bull_4 = collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or (bull_3 != null and bull_3 != self):
			x -= absf(lava_lift.hspeed)
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or (bull_4 != null and bull_4 != self):
			x += absf(lava_lift.hspeed)


# from objects/obj_bullebill_base/Draw_0.gml
func _gm_draw() -> void:
	v = 0.0
	while v < size_y:
		if v == 0.0:
			index = 0.0
		elif v == 1.0:
			index = 1.0
		else:
			index = 2.0
		GM.draw_sprite(sprites, index, x, (y + (v * 16.0)))
		v += 1.0
	if G.apariencia == 3.0 and anim_shoot > 0.0:
		GM.draw_sprite(sprite_anim, anim_shoot, x, y)
