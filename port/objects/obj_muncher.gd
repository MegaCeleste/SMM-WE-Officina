# 第 7 批移植，已核对。
extends "res://objects/obj_physicssolid.gd"

var wings: float = 0.0
var dead_h: float = 0.0
var apilar: float = 0.0
var mebelow = null  # PORT: GML 里 -4（noone）= 没有，按第 15 条用 null；obj_claw 读 o.mebelow == null
var modo_lava: float = 0.0
var a: float = 0.0
var offset: float = 0.0
var offsetnext: float = 0.0
var offsetxscale: float = 0.0
var col_pokey = null
var imdead = null


# from objects/obj_muncher/Create_0.gml
func _create() -> void:
	var dark: float  # 局部变量提升（GML 的 var 是函数作用域）
	# event_inherited(): 父类无此事件
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_muncher_night
			else:
				sprite_index = A.spr_SMB_muncher
			image_speed = 0.1
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_muncher_night
			else:
				sprite_index = A.spr_SMB3_muncher
			image_speed = 0.1
		2.0:
			image_speed = 0.1
		3.0:
			sprite_index = A.spr_NSMBU_muncher
			image_speed = 0.3
	wings = 0.0
	direct = 1.0
	dead_h = 0.0
	bouncy = 0.0
	apilar = 0.0
	mebelow = null
	swimming = 0.0
	modo_lava = 0.0
	if position_meeting(x, (bbox_bottom + 8.0), A.obj_muncher) and (not position_meeting(x, (bbox_bottom + 8.0), A.obj_muncher_b)):
		mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_muncher, false, false)
		alarm[0] = 10.0
	else:
		mebelow = null
	a = -16.0
	alarm[9] = 2.0
	offset = 0.0
	offsetnext = 0.0
	offsetxscale = 1.0


# from objects/obj_muncher/Step_1.gml
func _step_begin() -> void:
	if not GM.instance_exists(mebelow):
		var next = mebelow
		while next != null:  # GML: next != -4
			GM.instance_activate_object(next)
			if GM.instance_exists(next):
				next = next.mebelow
			else:
				next = null


# from objects/obj_muncher/Step_0.gml
func _step() -> void:
	var valor: float  # 局部变量提升（GML 的 var 是函数作用域）
	if mebelow == null:  # GML: mebelow == noone
		col_pokey = collision_point(x, (bbox_bottom + 8.0), A.obj_muncher, false, false)
		if position_meeting(x, (bbox_bottom + 8.0), A.obj_muncher):
			mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_muncher, false, false)
			vspeed = 0.0
			gravity = 0.0
			alarm[0] = 10.0
		else:
			if gravity == 0.0:
				valor = 0.1
			else:
				valor = 0.015
			hspeed = (maxf(0.0, (absf(hspeed) - valor)) * GM.gm_sign(hspeed))
			if absf(hspeed) < valor:
				hspeed = 0.0
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
				swimming = 1.0
			else:
				swimming = 0.0
			_user_3()
			_user_4()
			offset = 0.0
			offsetnext = 0.0
			alarm[0] = -1.0
	else:
		GM.instance_activate_object(mebelow)
		if GM.instance_exists(mebelow):
			x = mebelow.x
			y = (mebelow.y - sprite_height)
		else:
			mebelow = null  # GML: noone


# from objects/obj_muncher/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(mebelow) and GM.instance_exists(A.obj_mario):
		offsetxscale = (-mebelow.offsetxscale)
	match offsetnext:
		0.0:
			offset = offsetxscale
		1.0:
			offset = 0.0
		2.0:
			offset = (-offsetxscale)
		3.0:
			offset = 0.0
	offsetnext += 1.0
	if offsetnext == 4.0:
		offsetnext = 0.0
	alarm[0] = 12.0


# from objects/obj_muncher/Alarm_9.gml
func _alarm_9() -> void:
	if mebelow == null:  # GML: mebelow == -4
		for _rep in range(99):
			if position_meeting(x, (bbox_top + a), A.obj_muncher):
				a -= 16.0
			else:
				a += 16.0
				if a < -16.0:
					a = -16.0
	alarm[9] = 2.0


# from objects/obj_muncher/Collision_obj_shield_left.gml
func _collision_obj_shield_left(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario) and G.powerup == -85.0:
		if GM.instance_find(A.obj_mario, 0).hspeed < -1.0:
			GM.audio_stop_sound(A.snd_SMB_link_guardbullet)
			GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)
			var phy = collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 8.0), A.obj_physicssolid, true, false)
			if GM.instance_find(A.obj_mario, 0).hspeed < -2.0 and phy != null and phy != self:
				hspeed = 0.0
			elif GM.instance_find(A.obj_mario, 0).hspeed < -2.0 and mebelow == null and (collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_solidphy, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + a), bbox_left, (bbox_bottom - 8.0), A.obj_onewaygate_right, true, false) == null):
				hspeed = -2.0
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 1.0


# from objects/obj_muncher/Collision_obj_shield_right.gml
func _collision_obj_shield_right(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario) and G.powerup == -85.0:
		if GM.instance_find(A.obj_mario, 0).hspeed > 1.0:
			GM.audio_stop_sound(A.snd_SMB_link_guardbullet)
			GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)
			var phy = collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_physicssolid, true, false)
			if GM.instance_find(A.obj_mario, 0).hspeed > 2.0 and phy != null and phy != self:
				hspeed = 0.0
			elif GM.instance_find(A.obj_mario, 0).hspeed > 2.0 and mebelow == null and (collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_solid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 8.0), A.obj_onewaygate_left, true, false) == null):
				hspeed = 2.0
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = -1.0


# from objects/obj_muncher/Other_10.gml
func _user_0() -> void:
	var dark: float  # 局部变量提升（GML 的 var 是函数作用域）
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.sprite_index = A.spr_muncher_deads
	imdead.girar = 1.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				imdead.image_index = 1.0
			else:
				imdead.image_index = 0.0
		1.0:
			if dark == 1.0:
				imdead.image_index = 3.0
			else:
				imdead.image_index = 2.0
		2.0:
			imdead.image_index = 4.0
		3.0:
			imdead.image_index = 5.0
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


# from objects/obj_muncher/Other_13.gml
func _user_3() -> void:
	var mayor = collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false)
	var menor = collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false)
	if (hspeed > 0.0 and collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and mayor != null and mayor != self) or (hspeed < 0.0 and menor != null and menor != self) or (hspeed > 0.0 and collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_thwomp, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_thwomp, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + 1.0), (bbox_top + a), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + a), (bbox_left - 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other  # PORT: with 块里调用了 event_user，第 17 条
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o: GMObject = GM.other  # PORT: with 块里调用了 event_user，第 17 条
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if object_index == A.obj_galoomba_hold or object_index == A.obj_bobomb_hold:
			direct = (-direct)
		hspeed = 0.0
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
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


# from objects/obj_muncher/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and physolid != self and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	var phy2 = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false)
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (phy2 != null and phy2 != self):
		gravity = 0.0
		if vspeed > 0.0:
			if GM.variable_instance_exists(self, "bouncy") and bouncy == 1.0:
				if vspeed > 0.6:
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
				if object_index == A.obj_muncher_b:
					GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
					GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
					Scr.init_shake(self, 2.0)
				vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other  # PORT: with 块里调用了 event_user，第 17 条
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif swimming <= 0.5:  # GML: !swimming
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		var phy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false)
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or (phy != null and phy != self) or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other  # PORT: with 块里调用了 event_user，第 17 条
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()
	_user_14()


# from objects/obj_muncher/Other_24.gml
func _user_14() -> void:
	var lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 3.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
	if lava_lift != null and vspeed >= 0.0:
		var check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_solidtop, false, false)
		var phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_physicssolid, false, false)
		if (check != null and check != lava_lift) or (phy_check != null and phy_check != self):
			return
		y = (lava_lift.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		var spd = lava_lift.hspeed
		var phy1 = collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		var phy2 = collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and ((phy1 == null) or (phy1 != null and phy1 == self))) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and ((phy2 == null) or (phy2 != null and phy2 == self))) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
			x += lava_lift.hspeed
		var phy3 = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		var phy4 = collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or (phy3 != null and phy3 != self) or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= 1.0
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or (phy4 != null and phy4 != self) or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += 1.0


# from objects/obj_muncher/Draw_0.gml
func _gm_draw() -> void:
	var anim = GM.instance_find(A.obj_levelmanager, 0).banim2
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
