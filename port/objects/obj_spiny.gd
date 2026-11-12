# from objects/obj_spiny（第 6e 批移植，已核对）
extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var edible: float = 0.0
var inup: float = 0.0
var draw_invert: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，与 Godot Node 的 ready 冲突，改名 ready_v
var wings_anim: float = 0.0
var spiny: float = 0.0
var imheld = null


# from objects/obj_spiny/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spiny
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_index = A.spr_SMB3_spiny
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_index = A.spr_spiny
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_spiny
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	innave = 0.0
	inup = 0.0
	draw_invert = 0.0
	ready_v = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	spiny = 0.0
	dead_h = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[10] = 1.0


# from objects/obj_spiny/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct


# from objects/obj_spiny/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_spiny_ball)):
			inst.hspeed = self.hspeed
			inst.vspeed = self.vspeed
			inst.direct = self.direct
		instance_destroy()
	if inup == 0.0:
		if wings == 1.0:
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
			if y > (ystart + 10.0):
				if vspeed < -0.4:
					vspeed = -0.4
				else:
					vspeed -= 0.085
			elif y < (ystart - 10.0):
				if vspeed > 0.4:
					vspeed = 0.4
				else:
					vspeed += 0.085
		else:
			super._step()
	else:
		if ready_v == 0.0:
			if GM.instance_exists(A.obj_mario):
				if GM.instance_find(A.obj_mario, 0).x > (x - 32.0) and GM.instance_find(A.obj_mario, 0).x < (x + 32.0) and GM.instance_find(A.obj_mario, 0).y > y:
					hspeed = 0.0
					ready_v = 1.0
			if (hspeed < 0.0 and (not position_meeting(bbox_left, (y - 4.0), A.obj_solid))) or (hspeed > 0.0 and (not position_meeting(bbox_right, (y - 4.0), A.obj_solid))):
				hspeed = (-hspeed)
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_buzzy_ceiling)):
				match self.sprite_index:
					A.spr_SMB_spiny:
						inst.sprite_index = A.spr_SMB_spiny_dead
					A.spr_SMB3_spiny:
						inst.sprite_index = A.spr_SMB3_spiny_dead
					A.spr_spiny:
						inst.sprite_index = A.spr_spiny_dead
					A.spr_NSMBU_spiny:
						inst.sprite_index = A.spr_NSMBU_spiny_dead
			instance_destroy()
		_user_2()
		_user_3()
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle":
		if G.apariencia != 0.0:
			for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
				if G.apariencia == 1.0:
					inst.sprite_index = A.spr_SMB3_splash_lava
				elif G.apariencia == 2.0:
					inst.sprite_index = A.spr_splash_lava
				inst.depth = -10.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			if self.inup == 1.0:
				match self.sprite_index:
					A.spr_SMB_spiny:
						inst.sprite_index = A.spr_SMB_spiny_dead
					A.spr_SMB3_spiny:
						inst.sprite_index = A.spr_SMB3_spiny_dead
					A.spr_spiny:
						inst.sprite_index = A.spr_spiny_dead
					A.spr_NSMBU_spiny:
						inst.sprite_index = A.spr_NSMBU_spiny_dead
			else:
				inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 1.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_smoke)):
			if G.apariencia == 1.0:
				inst.sprite_index = A.spr_SMB3_splash_lava_purple
			elif G.apariencia == 2.0:
				inst.sprite_index = A.spr_splash_lava_purple
			inst.depth = -10.0
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			if self.inup == 1.0:
				match self.sprite_index:
					A.spr_SMB_spiny:
						inst.sprite_index = A.spr_SMB_spiny_dead
					A.spr_SMB3_spiny:
						inst.sprite_index = A.spr_SMB3_spiny_dead
					A.spr_spiny:
						inst.sprite_index = A.spr_spiny_dead
					A.spr_NSMBU_spiny:
						inst.sprite_index = A.spr_NSMBU_spiny_dead
			else:
				inst.sprite_index = self.sprite_index
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_spiny/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_spiny_ball
		1.0:
			sprite_index = A.spr_SMB3_spiny_ball
		2.0:
			sprite_index = A.spr_spiny_ball
		3.0:
			sprite_index = A.spr_NSMBU_spiny_ball
	image_speed = 0.08
	if spiny == 0.0:
		alarm[1] = 60.0
		spiny = 1.0
	else:
		alarm[2] = 60.0
		spiny = 0.0


# from objects/obj_spiny/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, (y - 9.0), A.obj_espina)):
		inst.vspeed = -0.7
	for inst in GM.with_list(GM.instance_create((x + 18.0), (y + 8.0), A.obj_espina)):
		inst.hspeed = 0.7
		inst.rotacion = 270.0
	for inst in GM.with_list(GM.instance_create(x, (y + 18.0), A.obj_espina)):
		inst.vspeed = 0.7
		inst.rotacion = 180.0
	for inst in GM.with_list(GM.instance_create((x - 18.0), (y + 8.0), A.obj_espina)):
		inst.hspeed = -0.7
		inst.rotacion = 90.0
	alarm[3] = 30.0


# from objects/obj_spiny/Alarm_2.gml
func _alarm_2() -> void:
	for inst in GM.with_list(GM.instance_create((x + 14.0), (y - 7.0), A.obj_espina)):
		inst.vspeed = -0.7
		inst.hspeed = 0.7
		inst.rotacion = 315.0
	for inst in GM.with_list(GM.instance_create((x + 14.0), (y + 23.0), A.obj_espina)):
		inst.vspeed = 0.7
		inst.hspeed = 0.7
		inst.rotacion = 225.0
	for inst in GM.with_list(GM.instance_create((x - 14.0), (y + 23.0), A.obj_espina)):
		inst.vspeed = 0.7
		inst.hspeed = -0.7
		inst.rotacion = 135.0
	for inst in GM.with_list(GM.instance_create((x - 14.0), (y - 7.0), A.obj_espina)):
		inst.vspeed = -0.7
		inst.hspeed = -0.7
		inst.rotacion = 45.0
	alarm[3] = 30.0


# from objects/obj_spiny/Alarm_3.gml
func _alarm_3() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_spiny_wings
		image_speed = 0.3
	else:
		sprite_index = A.spr_spiny_wings
		image_index = G.apariencia
		image_speed = 0.0
	alarm[0] = 126.0


# from objects/obj_spiny/Alarm_10.gml
func _alarm_10() -> void:
	super._alarm_10()
	if wings == 1.0 and inup == 0.0:
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_spiny_wings
			image_index = 0.9
		else:
			sprite_index = A.spr_spiny_wings
			image_index = G.apariencia
			image_speed = 0.0
		alarm[0] = 126.0


# from objects/obj_spiny/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_shell_spiny_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_shell_spiny_deads
		2.0:
			imdead.sprite_index = A.spr_shell_spiny_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_shell_spiny_deads
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: 括号位置错（other.bbox_left + bbox_right / 2，other/self 混用），照搬
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


# from objects/obj_spiny/Other_15.gml
func _user_5() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell)
	match G.apariencia:
		0.0:
			imheld.sprite_index = A.spr_SMB_spiny_dead
		1.0:
			imheld.sprite_index = A.spr_SMB3_spiny_dead
		2.0:
			imheld.sprite_index = A.spr_spiny_dead
		3.0:
			imheld.sprite_index = A.spr_NSMBU_spiny_dead
	imheld.koopainside = -1.0
	imheld.flip = 1.0
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 640.0
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	# ORIG-BUG: 右侧 bbox_left + bbox_right / 2 的括号位置错，照搬
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	instance_destroy()


# from objects/obj_spiny/Other_19.gml
func _user_9() -> void:
	imheld = GM.instance_create(x, y, A.obj_shell)
	match G.apariencia:
		0.0:
			imheld.sprite_index = A.spr_SMB_spiny_dead
		1.0:
			imheld.sprite_index = A.spr_SMB3_spiny_dead
		2.0:
			imheld.sprite_index = A.spr_spiny_dead
		3.0:
			imheld.sprite_index = A.spr_NSMBU_spiny_dead
	imheld.koopainside = -1.0
	imheld.flip = 1.0
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 640.0
	instance_destroy()


# from objects/obj_spiny/Draw_0.gml
func _gm_draw() -> void:
	if inup == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, x, (y + 16.0), direct, -1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 18.0), direct, 1.0, 0.0, GM.c_white, 1.0)
