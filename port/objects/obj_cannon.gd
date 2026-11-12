# from objects/obj_cannon（第 6c 批移植，已核对）
extends "res://objects/obj_physicssolid.gd"

var u: float = 0.0
var d: float = 0.0
var l: float = 0.0
var r: float = 0.0
var calcular: float = 0.0
var sprite_anim: int = 0  ## sprite 编号
var anim_shoot: float = 0.0
var imdead = null


# from objects/obj_cannon/Create_0.gml
func _create() -> void:
	var dark: float
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_cannon_night
			else:
				sprite_index = A.spr_SMB_cannon
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_cannon_night
			else:
				sprite_index = A.spr_SMB3_cannon
		3.0:
			sprite_index = A.spr_NSMBU_cannon
	direct = 0.0
	u = 0.0
	d = 0.0
	l = 0.0
	r = 0.0
	alarm[0] = 90.0
	calcular = 0.0
	alarm[1] = 10.0
	image_speed = 0.0
	image_index = (direct / 45.0)
	sprite_anim = A.spr_NSMBU_cannon_anim
	anim_shoot = 0.0


# from objects/obj_cannon/Step_0.gml
func _step() -> void:
	if G.apariencia == 3.0 and anim_shoot > 0.0:
		if anim_shoot >= 12.5:
			anim_shoot = 0.0
		else:
			anim_shoot += 0.5
	if d == 1.0:
		super._step()
	if GM.instance_exists(A.obj_mario) and place_meeting(x, y, A.obj_mario):
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
	if calcular == 1.0:
		if Scr.outside_view(self) <= 0.5:
			_user_1()


# from objects/obj_cannon/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.instance_exists(A.obj_mario):
		alarm[0] = 1.0
		return
	GM.audio_stop_sound(Scr.scr_snd_explode(self))
	GM.audio_play_sound(Scr.scr_snd_explode(self), 0.0, false)
	if G.apariencia == 3.0:
		anim_shoot = 1.0
	if G.apariencia == 3.0:
		# ORIG-BUG: 生成位置的 y 偏移用的是内置 direction（speed 为 0 时恒为 0）而不是 direct，x 偏移用的是 direct。照搬
		for inst in GM.with_list(GM.instance_create(((x + 8.0) + GM.lengthdir_x(8.0, direct)), ((y + 8.0) + GM.lengthdir_y(8.0, direction)), A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_cannon_smoke
			inst.image_speed = 0.5
			inst.image_angle = self.direct
			inst.depth = -7.0
	# ORIG-BUG: 同上，y 偏移用 direction
	for inst in GM.with_list(GM.instance_create(((x + 8.0) + GM.lengthdir_x(8.0, direct)), ((y + 8.0) + GM.lengthdir_y(8.0, direction)), A.obj_cannonball)):
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and inst.y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			inst.motion_set(self.direct, 0.5)
		else:
			inst.motion_set(self.direct, 1.0)
	alarm[0] = 192.0


# from objects/obj_cannon/Alarm_1.gml
func _alarm_1() -> void:
	calcular = 1.0


# from objects/obj_cannon/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create((x + 8.0), (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.image_speed = 0.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_cannon_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_cannon_deads
		2.0:
			imdead.sprite_index = A.spr_cannon_deads
		3.0:
			imdead.sprite_index = A.spr_cannon_deads
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		imdead.image_index = 1.0
	else:
		imdead.image_index = 0.0
	if direct == 0.0 or direct == 45.0 or direct == 90.0 or direct == 315.0:
		imdead.direct = 1.0
	else:
		imdead.direct = -1.0
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


# from objects/obj_cannon/Other_11.gml
func _user_1() -> void:
	if u == 1.0 and (not place_meeting(x, (y - 16.0), A.obj_solidtop)) and (not place_meeting(x, (y - 16.0), A.obj_pinchos)):
		d = 1.0
		u = 0.0
		if direct == 0.0:
			direct = 180.0
		elif direct == 180.0:
			direct = 0.0
		elif direct == 225.0:
			direct = 45.0
		elif direct == 315.0:
			direct = 135.0
		elif direct == 270.0:
			direct = 90.0
	elif r == 1.0 and (not place_meeting((x + 16.0), y, A.obj_solidtop)) and (not place_meeting((x + 16.0), y, A.obj_pinchos)):
		d = 1.0
		r = 0.0
		if direct == 180.0:
			direct = 90.0
		elif direct == 225.0:
			direct = 135.0
		elif direct == 135.0:
			direct = 45.0
		elif direct == 90.0:
			direct = 0.0
		elif direct == 270.0:
			direct = 180.0
	elif l == 1.0 and (not place_meeting((x - 16.0), y, A.obj_solidtop)) and (not place_meeting((x - 16.0), y, A.obj_pinchos)):
		d = 1.0
		l = 0.0
		if direct == 0.0:
			direct = 90.0
		elif direct == 45.0:
			direct = 135.0
		elif direct == 90.0:
			direct = 180.0
		elif direct == 270.0:
			direct = 0.0
		elif direct == 315.0:
			direct = 45.0


# from objects/obj_cannon/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var phy2
	var col_one_top
	var phy
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and physolid != self and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	phy2 = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false)
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (phy2 != null and phy2 != self):
		gravity = 0.0
		if vspeed > 0.0:
			if GM.variable_instance_exists(self, "bouncy") and bouncy == 1.0:
				if vspeed > 0.5:
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
				vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not (swimming > 0.5):
		gravity = 0.2
		if vspeed > 4.0:
			vspeed = 4.0
	else:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		phy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_physicssolid, true, false)
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or (phy != null and phy != self) or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
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


# from objects/obj_cannon/Other_24.gml
func _user_14() -> void:
	var lava_lift
	var check
	var phy_check
	var spd
	var phy1
	var phy2
	var phy3
	var phy4
	lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 3.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
	if lava_lift != null and vspeed >= 0.0:
		check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_solidtop, false, false)
		phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_physicssolid, false, false)
		if (check != null and check != lava_lift) or (phy_check != null and phy_check != self):
			return
		y = (lava_lift.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		spd = lava_lift.hspeed
		phy1 = collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		phy2 = collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and ((phy1 == null) or (phy1 != null and phy1 == self))) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and ((phy2 == null) or (phy2 != null and phy2 == self))) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
			x += lava_lift.hspeed
		phy3 = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		phy4 = collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false)
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or (phy3 != null and phy3 != self) or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= absf(lava_lift.hspeed)
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or (phy4 != null and phy4 != self) or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += absf(lava_lift.hspeed)


# from objects/obj_cannon/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0 and anim_shoot > 0.0:
		GM.draw_sprite_ext(sprite_anim, anim_shoot, (x + 7.0), (y + 7.0), 1.0, 1.0, direct, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, (direct / 45.0), x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if d == 1.0:
		GM.draw_sprite(sprite_index, 8.0, x, y)
	elif u == 1.0:
		GM.draw_sprite(sprite_index, 9.0, x, y)
	elif r == 1.0:
		GM.draw_sprite(sprite_index, 10.0, x, y)
	elif l == 1.0:
		GM.draw_sprite(sprite_index, 11.0, x, y)
	else:
		GM.draw_sprite(sprite_index, 8.0, x, y)
