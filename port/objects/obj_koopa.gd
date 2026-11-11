extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var para_y: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var para_rot: float = 0.0
var turning: float = 0.0
var mebelow = null
var wake: float = 0.0
var startTime: float = 0.0
var imheld = null


# from objects/obj_koopa/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_koopa
			sprite_wings = A.spr_SMB_wings
			para_y = 2.0
			image_speed = 0.1
		1.0:
			sprite_index = A.spr_SMB3_koopa
			sprite_wings = A.spr_SMB3_wings
			para_y = 0.0
			image_speed = 0.1
		2.0:
			sprite_wings = A.spr_wings
			para_y = 0.0
			image_speed = 0.1
		3.0:
			sprite_index = A.spr_NSMBU_koopa
			sprite_wings = A.spr_NSMBU_wings_enemigos
			para_y = 0.0
			image_speed = 0.5
	hardness = 0.0
	stomp = 0.0
	edible = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	modo_lava = 0.0
	dead_h = 0.0
	direct = -1.0
	innave = 0.0
	swimming = 0.0
	turning = 0.0
	apilar = 0.0
	mebelow = null
	wake = 0.0
	startTime = GM.current_time
	alarm[10] = 1.0


# from objects/obj_koopa/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", 1.0)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)


# from objects/obj_koopa/Step_0.gml
func _step() -> void:
	if wake == 1.0:
		if image_index >= 37.5:
			if object_index == A.obj_koopa_b:
				sprite_index = A.spr_NSMBU_koopa_b
			else:
				sprite_index = A.spr_NSMBU_koopa
			image_index = 0.0
			image_speed = 0.5
			wake = 0.0
			alarm[10] = 1.0
		else:
			image_speed = 0.5
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
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
	if wings == 1.0 and GM.instance_exists(A.obj_mario):
		if G.apariencia == 3.0:
			wings_anim += 0.5
		else:
			wings_anim += 0.12
		if paracaidas == 0.0:
			if gravity == 0.0:
				if swimming == 1.0:
					vspeed = -2.062
				else:
					vspeed = -4.125
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
			_user_7()
			GM.instance_create((x + (3.0 * direct)), (y + para_y), A.obj_paracaidas_go)
			paracaidas = 0.0
			hspeed = 0.0
			alarm[10] = 10.0
	if paracaidas == 1.0:
		var oscillationSpeed = -0.1
		var elapsedTime = (GM.current_time - startTime) / GM.room_speed
		# Calcola l'angolo oscillante tra -12 e 12 gradi
		var oscillation = (sin(oscillationSpeed * elapsedTime) * 12.0)
		image_angle = oscillation
	else:
		image_angle = 0.0
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.set("direct", self.direct)
		instance_destroy()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_posion)
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_enemyparent_lava)):
			inst.sprite_index = self.sprite_index
			inst.set("direct", self.direct)
		instance_destroy()


# from objects/obj_koopa/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if wake == 1.0:
			image_speed = 0.5
		else:
			if paracaidas == 1.0 or vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, false, false) != null:
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					hspeed = (0.3 * direct)
				else:
					hspeed = (0.5 * direct)
			else:
				alarm[10] = 2.0
			if G.apariencia == 3.0 and paracaidas == 1.0:
				sprite_index = A.spr_NSMBU_koopa_fly


# from objects/obj_koopa/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_shell_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_koopa_deads
		2.0:
			imdead.sprite_index = A.spr_shell_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_shell_deads
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
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


# from objects/obj_koopa/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(1)
		GM.other = _o
		match G.apariencia:
			0.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_SMB_shell
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
			1.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_SMB3_shell
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
			2.0:
				GM.instance_create(x, y, A.obj_shell)
				var mario = GM.instance_find(A.obj_mario, 0)
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa)):
					inst.sprite_index = A.spr_beachkoopa
					if (mario.bbox_left + (inst.bbox_right / 2.0)) <= (inst.bbox_left + (inst.bbox_right / 2.0)):
						inst.hspeed = 3.0
					elif (mario.bbox_left + (inst.bbox_right / 2.0)) >= (inst.bbox_left + (inst.bbox_right / 2.0)):
						inst.hspeed = -3.0
					else:
						inst.hspeed = (3.0 * mario.direct)
					inst.alarm[11] = 30.0
					inst.set("ready_v", 0.0)
					inst.set("key", self.key)
			3.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_NSMBU_shell
					inst.set("direct", self.direct)
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
		instance_destroy()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.set("direct", self.direct)
		wings = 0.0
		vspeed = 0.5
		alarm[10] = 2.0


# from objects/obj_koopa/Other_15.gml
func _user_5() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell)
	match G.apariencia:
		0.0:
			imheld.sprite_index = A.spr_SMB_shell
		1.0:
			imheld.sprite_index = A.spr_SMB3_shell
		2.0:
			imheld.sprite_index = A.spr_shell_inside
			imheld.koopainside = 1.0
			imheld.alarm[5] = 120.0
		3.0:
			imheld.sprite_index = A.spr_NSMBU_shell
	imheld.flip = 1.0
	imheld.key = key
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 600.0
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	instance_destroy()


# from objects/obj_koopa/Other_17.gml
func _user_7() -> void:
	if G.apariencia == 3.0:
		if object_index == A.obj_koopa_b:
			sprite_index = A.spr_NSMBU_koopa_b
		else:
			sprite_index = A.spr_NSMBU_koopa


# from objects/obj_koopa/Draw_0.gml
func _gm_draw() -> void:
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), (y + para_y), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, image_angle, GM.c_white, 1.0)
