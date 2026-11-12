extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var wings_anim: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ready2: float = 0.0


# from objects/obj_rocky/Create_0.gml
func _create() -> void:
	image_index = G.apariencia
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	innave = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	direct = -1.0
	swimming = 0.0
	apilar = 0.0
	ready_v = 0.0
	ready2 = 0.0
	image_speed = 0.0


# from objects/obj_rocky/Step_0.gml
func _step() -> void:
	var semisolid: GMObject
	var physolid: GMObject
	match ready_v:
		0.0:
			_user_4()
		1.0:
			if not swimming:
				gravity = 0.2
				if vspeed > 4.0:
					vspeed = 4.0
			else:
				gravity = 0.02
				if vspeed > 1.0:
					vspeed = 1.0
			_user_7()
			semisolid = collision_rectangle(bbox_left, (bbox_bottom - 14.0), bbox_right, ((bbox_bottom - 13.0) + vspeed), A.obj_solid, false, false)
			physolid = collision_rectangle(bbox_left, (bbox_bottom - 14.0), bbox_right, ((bbox_bottom - 13.0) + vspeed), A.obj_physicssolid, false, false)
			if semisolid != null and vspeed > 0.0:
				y = semisolid.y
				depth = (semisolid.depth + 1.0)
				_user_6()
			if physolid != null and vspeed > 0.0 and physolid.object_index != A.obj_muncher and physolid.object_index != A.obj_muncher_b and physolid.object_index != A.obj_cannon and physolid.object_index != A.obj_cannon_red:
				y = physolid.y
				depth = (physolid.depth + 1.0)
				_user_6()
	match ready2:
		1.0:
			y -= 0.5
			if y < (ystart - 2.0):
				y = (ystart - 2.0)
				ready2 = 2.0
				alarm[1] = 90.0
		3.0:
			y -= 0.5
			if y < (ystart - 9.0):
				y = (ystart - 9.0)
				ready2 = 4.0
				alarm[2] = 2.0
		5.0:
			y += 0.5
			if y >= ystart:
				y = ystart
				ready2 = 0.0
				alarm[0] = 60.0
	if sprite_index == A.spr_NSMBU_rocky_throw and image_index >= 16.5 and image_index < 17.0:
		_user_2()
	if ready_v == 2.0 and (not place_meeting(x, (y + 12.0), A.obj_solid)) and (not place_meeting(x, (y + 12.0), A.obj_physicssolid)):
		_user_0()
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_top - 2.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_index = self.image_index
			inst.set("direct", self.direct)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_top - 2.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.image_index = self.image_index
			inst.set("direct", self.direct)
		instance_destroy()


# from objects/obj_rocky/Alarm_0.gml
func _alarm_0() -> void:
	if (not place_meeting(x, (y - 16.0), A.obj_solid)) and (not place_meeting(x, (y - 16.0), A.obj_physicssolid)) and (not place_meeting(x, (y - 16.0), A.obj_bullebill_base)):
		ready2 = 1.0
	else:
		alarm[0] = 10.0


# from objects/obj_rocky/Alarm_1.gml
func _alarm_1() -> void:
	ready2 = 3.0


# from objects/obj_rocky/Alarm_2.gml
func _alarm_2() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_rocky_throw
		image_index = 0.0
		image_speed = 0.5
	else:
		sprite_index = A.spr_rocky_throw
		image_index = G.apariencia
		alarm[3] = 30.0


# from objects/obj_rocky/Alarm_3.gml
func _alarm_3() -> void:
	sprite_index = A.spr_rocky_idle
	image_index = G.apariencia
	_user_2()
	alarm[4] = 30.0


# from objects/obj_rocky/Alarm_4.gml
func _alarm_4() -> void:
	ready2 = 5.0
	sprite_index = A.spr_rocky_idle2
	image_index = G.apariencia


# from objects/obj_rocky/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_rocky_throw:
		sprite_index = A.spr_rocky_idle2
		image_index = G.apariencia
		image_speed = 0.0
		alarm[4] = 30.0


# from objects/obj_rocky/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.direct = direct
	if G.apariencia == 3.0:
		imdead.sprite_index = A.spr_NSMBU_rocky_deads
		imdead.image_speed = 0.5
	else:
		imdead.sprite_index = A.spr_rocky_deads
		imdead.image_index = G.apariencia
	# ORIG-BUG(疑似): 速度/烟雾分支只在 apariencia == 3 时执行，其余画风 imdead.hspeed 不设；照搬
	if G.apariencia == 3.0:
		if dead_h == 0.0:
			if GM.other.hspeed == 0.0:
				if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
					imdead.hspeed = 1.0
				elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
					imdead.hspeed = -1.0
			elif GM.other.hspeed > 0.0:
				imdead.hspeed = 1.0
			else:
				imdead.hspeed = -1.0
		else:
			imdead.hspeed = 0.0
			for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_rocky/Other_11.gml
func _user_1() -> void:
	_user_0()


# from objects/obj_rocky/Other_12.gml
func _user_2() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_wrench)):
		inst.hspeed = ((1.0 - (0.5 * self.swimming)) * self.direct)
		inst.set("height", GM.choose(0.0, 1.0, 2.0, 3.0, 4.0))


# from objects/obj_rocky/Other_14.gml
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
		vspeed = (-(1.5 - (0.7 * swimming)))
		ready_v = 1.0
		if vspeed > 0.0:
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	elif paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif not swimming:
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
			col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_rocky/Other_16.gml
func _user_6() -> void:
	sprite_index = A.spr_rocky_idle2
	image_index = G.apariencia
	vspeed = 0.0
	gravity = 0.0
	ystart = y
	GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)
	ready_v = 2.0
	alarm[0] = 60.0


# from objects/obj_rocky/Other_17.gml
func _user_7() -> void:
	var col_one_bottom: GMObject
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
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0


# from objects/obj_rocky/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
