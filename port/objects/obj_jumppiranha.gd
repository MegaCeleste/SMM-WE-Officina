extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var fire: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ready2: float = 0.0
var jump_plant: float = 0.0
var b_start: float = 0.0
var timer: float = 0.0
var inup: float = 0.0
var cankill: float = 0.0


# from objects/obj_jumppiranha/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pplant
			image_speed = 0.125
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_pplant
			image_speed = 0.125
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			image_speed = 0.55
			sprite_wings = A.spr_wings2
		3.0:
			sprite_index = A.spr_NSMBU_pplant
			image_speed = 0.3
			sprite_wings = A.spr_NSMBU_wings_items
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	apilar = 0.0
	imdead = 0.0
	fire = 0.0
	ready_v = 0.0
	ready2 = 0.0
	swimming = 0.0
	jump_plant = 0.0
	b_start = y
	timer = 0.0
	inup = 0.0
	cankill = 0.0
	alarm[2] = 5.0
	alarm[0] = 180.0
	alarm[1] = 60.0
	alarm[10] = 2.0


# from objects/obj_jumppiranha/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0


# from objects/obj_jumppiranha/Step_0.gml
func _step() -> void:
	match inup:
		1.0:
			if cankill == 1.0 and (not place_meeting(x, (y - 12.0), A.obj_solid)) and (not place_meeting(x, (y - 12.0), A.obj_physicssolid)):
				_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 可能为 null
		2.0:
			if cankill == 1.0 and (not place_meeting((x - 16.0), y, A.obj_solid)) and (not place_meeting((x - 16.0), y, A.obj_physicssolid)):
				_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 可能为 null
		3.0:
			if cankill == 1.0 and (not place_meeting((x + 16.0), y, A.obj_solid)) and (not place_meeting((x + 16.0), y, A.obj_physicssolid)):
				_user_0()  # UNSURE: Step 事件里 other 的值（_user_0 读 other.hspeed 等），此时 GM.other 可能为 null
	if paracaidas == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.15)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.15:
			hspeed = 0.0
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if inup == 0.0 and (jump_plant < 2.0 or jump_plant == 10.0):
		_user_4()
	if wings == 1.0:
		if G.apariencia == 3.0:
			wings_anim += 1.0
		else:
			wings_anim += 0.12
		if jump_plant == 1.0 and vspeed > 0.0:
			jump_plant = 2.0
			b_start = y
			gravity = 0.0
		if jump_plant > 1.0 and jump_plant < 8.0:
			if y > (b_start + 24.0):
				if vspeed < -1.0:
					vspeed = -1.0
				else:
					vspeed -= 0.03
			elif y < (b_start - 24.0):
				if vspeed > 1.0:
					vspeed = 1.0
				else:
					vspeed += 0.03
			jump_plant += 0.04
			if jump_plant > 7.0:
				jump_plant = 10.0
				gravity = 0.0
		if jump_plant == 10.0 and gravity == 0.0 and vspeed == 0.0:
			alarm[1] = 60.0
			jump_plant = 0.0
			timer = 0.0
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
			hspeed = 0.0


# from objects/obj_jumppiranha/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia == 2.0 and inup == 0.0:
		if GM.instance_exists(A.obj_mario) and gravity == 0.0:
			vspeed = (-(2.5 - (0.5 * swimming)))
			sprite_index = A.spr_jumppiranha
			image_speed = 0.15
		else:
			alarm[0] = 1.0
			return


# from objects/obj_jumppiranha/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia != 2.0 and wings == 1.0:
		if GM.instance_exists(A.obj_mario) and gravity == 0.0:
			jump_plant = 1.0
			vspeed = (-(4.21 - (2.0 * swimming)))
		else:
			alarm[1] = 2.0
			return


# from objects/obj_jumppiranha/Alarm_2.gml
func _alarm_2() -> void:
	cankill = 1.0


# from objects/obj_jumppiranha/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0 and paracaidas == 1.0:
		hspeed = ((0.5 - (0.2 * swimming)) * direct)


# from objects/obj_jumppiranha/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			imdead = GM.instance_create((x + 8.0), (y + 4.0), A.obj_enemy_dead)
			imdead.sprite_index = A.spr_SMB_pplant_deads
		1.0:
			imdead = GM.instance_create((x + 8.0), (y + 4.0), A.obj_enemy_dead)
			imdead.sprite_index = A.spr_SMB3_pplant_deads
		2.0:
			imdead = GM.instance_create((x + 8.0), y, A.obj_enemy_dead)
			imdead.sprite_index = A.spr_jumppiranha_deads
		3.0:
			imdead = GM.instance_create((x + 8.0), y, A.obj_enemy_dead)
			imdead.sprite_index = A.spr_NSMBU_pplant_deads
	imdead.girar = 1.0
	imdead.image_xscale = direct
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


# from objects/obj_jumppiranha/Other_14.gml
func _user_4() -> void:
	var _o: GMObject = GM.other
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
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
		if vspeed > 0.0:
			vspeed = 0.0
			if G.apariencia == 2.0:
				sprite_index = A.spr_jumppiranha_falll
				image_speed = 0.55
				ystart = y
				alarm[0] = 180.0
				ready_v = 0.0
				ready2 = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif GM.variable_instance_exists(self, "paracaidas") and paracaidas == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	elif swimming <= 0.5:  # GML 的 !x 以 <= 0.5 为真
		if G.apariencia == 2.0:
			gravity = 0.03
			if vspeed > 0.5:
				vspeed = 0.5
		else:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
	elif G.apariencia == 2.0:
		gravity = 0.02
		if vspeed > 0.3:
			vspeed = 0.3
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
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			vspeed = 0.0
			jump_plant = 10.0
	if (bbox_top - 16.0) > GM.room_height or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_jumppiranha/Draw_0.gml
func _gm_draw() -> void:
	var xpos  # 局部变量提升（GML 的 var 是函数作用域）
	match inup:
		1.0:
			GM.draw_sprite_ext(sprite_index, image_index, x, (y + 16.0), 1.0, -1.0, 0.0, GM.c_white, 1.0)
		2.0:
			GM.draw_sprite_ext(sprite_index, image_index, (x + 8.0), (y + 8.0), 1.0, 1.0, 270.0, GM.c_white, 1.0)
		3.0:
			GM.draw_sprite_ext(sprite_index, image_index, (x - 8.0), (y + 8.0), 1.0, 1.0, 90.0, GM.c_white, 1.0)
		_:
			GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		if G.apariencia == 3.0:
			xpos = 8.0
		else:
			xpos = 0.0
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - xpos), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
