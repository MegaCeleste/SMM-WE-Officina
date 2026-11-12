# from objects/obj_buzzybeetle_b（第 6e 批移植，已核对）
extends "res://objects/obj_buzzybeetle.gd"


# from objects/obj_buzzybeetle_b/Create_0.gml
func _create() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_buzzybeetle_night_b
			else:
				sprite_index = A.spr_SMB_buzzybeetle_b
			sprite_wings = A.spr_SMB_wings_b
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_buzzybeetle_night_b
			else:
				sprite_index = A.spr_SMB3_buzzybeetle_b
			sprite_wings = A.spr_SMB3_wings_b
		2.0:
			sprite_wings = A.spr_wings_b
		3.0:
			sprite_index = A.spr_NSMBU_buzzybeetle_b
			sprite_wings = A.spr_NSMBU_wings_enemigos_b
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	inup = 0.0
	draw_invert = 0.0
	big = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	mytopid = A.obj_lighting
	ready_v = 0.0
	big = 0.0
	innave = 0.0
	dead_h = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	cankill = 0.0
	alarm[0] = 5.0
	alarm[10] = 1.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15


# from objects/obj_buzzybeetle_b/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 9.0), A.obj_wings_dead_b)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = self.direct
		if not GM.veq(mytopid, A.obj_lighting) and GM.instance_exists(mytopid):
			for inst in GM.with_list(mytopid):
				inst.instance_destroy()


# from objects/obj_buzzybeetle_b/Step_0.gml
func _step() -> void:
	if inup == 0.0:
		if paracaidas == 1.0:
			direct = -1.0
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
				alarm[10] = 10.0
		if wings == 0.0:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and y >= GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
				swimming = 1.0
			else:
				swimming = 0.0
			_user_2()
			_user_3()
			_user_4()
			if hspeed > 0.0:
				direct = 1.0
			elif hspeed < 0.0:
				direct = -1.0
		else:
			_user_8()
			if G.apariencia == 3.0:
				if ready_v == 1.0:
					wings_anim += 1.5
				else:
					wings_anim += 0.5
			elif ready_v == 1.0:
				wings_anim += 0.2
			else:
				wings_anim += 0.12
			if not GM.veq(mytopid, A.obj_lighting) and GM.instance_exists(mytopid) and GM.instance_exists(A.obj_mario):
				var _mario = GM.instance_find(A.obj_mario, 0)  # §3.3 第 16 条
				mytopid.x = (x - 16.0)
				mytopid.y = (y - 10.0)
				var check = collision_rectangle(_mario.bbox_left, (_mario.bbox_bottom - 1.0), _mario.bbox_right, (_mario.bbox_bottom + 1.0), A.obj_solidtop, false, false)
				if check != null and check != mytopid:
					return
				if collision_rectangle(bbox_left, (bbox_top - 5.0), bbox_right, (bbox_top + 4.0), A.obj_mario, false, false) != null and _mario.y < (bbox_top - 26.0) and _mario.state < 2.0:
					for inst in GM.with_list(A.obj_mario):
						inst.y = ceilf((bbox_top - 32.0))
					if (hspeed > 0.0 and (collision_rectangle((_mario.bbox_right + hspeed), _mario.bbox_top, (_mario.bbox_right + hspeed), (_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((_mario.bbox_left + hspeed), _mario.bbox_top, (_mario.bbox_left + hspeed), (_mario.bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((_mario.bbox_right + hspeed), _mario.bbox_top, (_mario.bbox_right + hspeed), (_mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((_mario.bbox_left + hspeed), _mario.bbox_top, (_mario.bbox_left + hspeed), (_mario.bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((_mario.bbox_right + hspeed), _mario.bbox_top, (_mario.bbox_right + hspeed), (_mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((_mario.bbox_left + hspeed), _mario.bbox_top, (_mario.bbox_left + hspeed), (_mario.bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (hspeed > 0.0 and (collision_rectangle((_mario.bbox_right + hspeed), _mario.bbox_top, (_mario.bbox_right + hspeed), (_mario.bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)) or (hspeed < 0.0 and (collision_rectangle((_mario.bbox_left + hspeed), _mario.bbox_top, (_mario.bbox_left + hspeed), (_mario.bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)):
						for inst in GM.with_list(A.obj_mario):
							inst.x += hspeed
	else:
		if ready_v == 0.0:
			if GM.instance_exists(A.obj_mario):
				var _mario2 = GM.instance_find(A.obj_mario, 0)  # §3.3 第 16 条
				if _mario2.x > (x - 32.0) and _mario2.x < (x + 32.0) and _mario2.y > y:
					hspeed = 0.0
					ready_v = 1.0
			if (hspeed < 0.0 and (not position_meeting(bbox_left, (y - 20.0), A.obj_solid))) or (hspeed > 0.0 and (not position_meeting(bbox_right, (y - 20.0), A.obj_solid))):
				hspeed = (-hspeed)
			if cankill == 1.0 and (not place_meeting(x, (y - 24.0), A.obj_solid)) and (not place_meeting(x, (y - 24.0), A.obj_physicssolid)):
				_user_0()
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzy_ceiling)):
				match self.sprite_index:
					A.spr_SMB_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_b
					A.spr_SMB_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_night_b
					A.spr_SMB3_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_b
					A.spr_SMB3_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_night_b
					A.spr_buzzybeetle_b:
						inst.sprite_index = A.spr_shell_buzzy_b
					A.spr_NSMBU_buzzybeetle_b:
						inst.sprite_index = A.spr_NSMBU_shell_buzzy_b
				inst.hardness = 99.0
			instance_destroy()
		_user_2()
		_user_3()
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (y - 8.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			if self.inup == 1.0:
				match self.sprite_index:
					A.spr_SMB_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_b
					A.spr_SMB_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_night_b
					A.spr_SMB3_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_b
					A.spr_SMB3_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_night_b
					A.spr_buzzybeetle_b:
						inst.sprite_index = A.spr_shell_buzzy_b
					A.spr_NSMBU_buzzybeetle_b:
						inst.sprite_index = A.spr_NSMBU_shell_buzzy_b
			else:
				inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and bbox_bottom > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (y - 8.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			if self.inup == 1.0:
				match self.sprite_index:
					A.spr_SMB_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_b
					A.spr_SMB_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB_shell_buzzy_night_b
					A.spr_SMB3_buzzybeetle_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_b
					A.spr_SMB3_buzzybeetle_night_b:
						inst.sprite_index = A.spr_SMB3_shell_buzzy_night_b
					A.spr_buzzybeetle_b:
						inst.sprite_index = A.spr_shell_buzzy_b
					A.spr_NSMBU_buzzybeetle_b:
						inst.sprite_index = A.spr_NSMBU_shell_buzzy_b
			else:
				inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_buzzybeetle_b/Alarm_10.gml
func _alarm_10() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if hspeed == 0.0:
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			hspeed = (0.3 * direct)
		else:
			hspeed = (0.5 * direct)
	if wings == 1.0 and inup == 0.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_buzzybeetle_b_wings
				image_speed = 0.0
				if dark == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			1.0:
				sprite_index = A.spr_SMB3_buzzybeetle_b_wings
				image_speed = 0.0
				if dark == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			2.0:
				sprite_index = A.spr_buzzybeetle_b_wings
			3.0:
				sprite_index = A.spr_NSMBU_buzzybeetle_b_wings
				image_speed = 0.3
		if GM.veq(mytopid, A.obj_lighting):
			mytopid = GM.instance_create((x - 16.0), (y - 10.0), A.obj_solidtop)
			mytopid.image_xscale = 2.0
		stomp = 6.0


# from objects/obj_buzzybeetle_b/Other_10.gml
func _user_0() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				imdead.sprite_index = A.spr_SMB_shell_buzzy_night_b
			else:
				imdead.sprite_index = A.spr_SMB_shell_buzzy_b
		1.0:
			if dark == 1.0:
				imdead.sprite_index = A.spr_SMB3_shell_buzzy_night_b
			else:
				imdead.sprite_index = A.spr_SMB3_shell_buzzy_b
		2.0:
			imdead.sprite_index = A.spr_shell_buzzy_b
		3.0:
			imdead.sprite_index = A.spr_NSMBU_shell_buzzy_b
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
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


# from objects/obj_buzzybeetle_b/Other_11.gml
func _user_1() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if wings == 1.0:
		return
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			dark = 1.0
		else:
			dark = 0.0
		match G.apariencia:
			0.0:
				if dark == 1.0:
					inst.sprite_index = A.spr_SMB_shell_buzzy_night_b
				else:
					inst.sprite_index = A.spr_SMB_shell_buzzy_b
			1.0:
				if dark == 1.0:
					inst.sprite_index = A.spr_SMB3_shell_buzzy_night_b
				else:
					inst.sprite_index = A.spr_SMB3_shell_buzzy_b
			2.0:
				inst.sprite_index = A.spr_shell_buzzy_b
			3.0:
				inst.sprite_index = A.spr_NSMBU_shell_buzzy_b
		inst.direct = self.direct
		inst.koopainside = -1.0
		inst.hardness = 100.0
		if self.inup == 1.0:
			inst.flip = 1.0
		inst.alarm[3] = 540.0
		inst.alarm[4] = 640.0
	instance_destroy()


# from objects/obj_buzzybeetle_b/Other_15.gml
func _user_5() -> void:
	var altura  # 局部变量提升（GML 的 var 是函数作用域）
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if inup == 1.0:
		altura = -2.0
	else:
		altura = 2.0
	imheld = GM.instance_create(x, (y - altura), A.obj_shell)
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				imheld.sprite_index = A.spr_SMB_shell_buzzy_night_b
			else:
				imheld.sprite_index = A.spr_SMB_shell_buzzy_b
		1.0:
			if dark == 1.0:
				imheld.sprite_index = A.spr_SMB3_shell_buzzy_night_b
			else:
				imheld.sprite_index = A.spr_SMB3_shell_buzzy_b
		2.0:
			imheld.sprite_index = A.spr_shell_buzzy_b
		3.0:
			imheld.sprite_index = A.spr_NSMBU_shell_buzzy_b
	imheld.koopainside = -1.0
	hardness = 100.0  # ORIG-BUG: 原文是 hardness = 100（写 self，不是 imheld.hardness），照搬
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 600.0
	if inup == 0.0 and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	if inup == 0.0:
		if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
			imheld.hspeed = 0.5
		elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imheld.hspeed = -0.5
	instance_destroy()


# from objects/obj_buzzybeetle_b/Other_19.gml
func _user_9() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	imheld = GM.instance_create(x, y, A.obj_shell)
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				imheld.sprite_index = A.spr_SMB_shell_buzzy_night_b
			else:
				imheld.sprite_index = A.spr_SMB_shell_buzzy_b
		1.0:
			if dark == 1.0:
				imheld.sprite_index = A.spr_SMB3_shell_buzzy_night_b
			else:
				imheld.sprite_index = A.spr_SMB3_shell_buzzy_b
		2.0:
			imheld.sprite_index = A.spr_shell_buzzy_b
		3.0:
			imheld.sprite_index = A.spr_NSMBU_shell_buzzy_b
	imheld.koopainside = -1.0
	imheld.hardness = 100.0
	imheld.flip = 1.0
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 600.0
	instance_destroy()


# from objects/obj_buzzybeetle_b/Draw_0.gml
func _gm_draw() -> void:
	if inup == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, -1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), y, direct, 1.0, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, (y - 16.0), 1.0, 1.0, image_angle, GM.c_white, 1.0)
