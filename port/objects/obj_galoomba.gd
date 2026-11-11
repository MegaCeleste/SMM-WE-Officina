extends "res://objects/obj_deactenemyparent.gd"

var search_mario: float = 0.0
var edible: float = 0.0
var para_rot: float = 0.0
var jumping: float = 0.0
var anim: float = 0.0
var direct2: float = 0.0
var mebelow = null
var startTime: float = 0.0
var cambio_gombaya = null


# from objects/obj_galoomba/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_goomba
		1.0:
			sprite_index = A.spr_SMB3_goomba
		2.0:
			sprite_index = A.spr_galoomba
		3.0:
			sprite_index = A.spr_NSMBU_goomba
	hardness = 0.0
	stomp = 0.0
	search_mario = 0.0
	direct = -1.0
	edible = 1.0
	wings = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	jumping = 0.0
	anim = 0.0
	innave = 0.0
	dead_h = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct2 = -1.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	apilar = 0.0
	mebelow = null
	startTime = GM.current_time
	alarm[10] = 2.0
	alarm[0] = 120.0
	# Create Event of your object
	#
	# path_start(path_rail, 1, path_action_restart, false);
	# /*


# from objects/obj_galoomba/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0)


# from objects/obj_galoomba/Step_0.gml
func _step() -> void:
	super._step()
	if paracaidas == 1.0:
		image_speed = 0.1
		if G.apariencia == 3.0:
			anim += 0.5
		else:
			anim += 0.15
		match G.apariencia:
			0.0:
				if object_index == A.obj_galoomba2:
					sprite_index = A.spr_SMB_goomba2_float
				elif object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_SMB_goomba2_float_b
				elif object_index == A.obj_galoomba_b:
					sprite_index = A.spr_SMB_goomba_float_b
				else:
					sprite_index = A.spr_SMB_goomba_float
			1.0:
				if object_index == A.obj_galoomba2:
					sprite_index = A.spr_SMB3_goomba2_float
				elif object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_SMB3_goomba2_float_b
				elif object_index == A.obj_galoomba_b:
					sprite_index = A.spr_SMB3_goomba_float_b
				else:
					sprite_index = A.spr_SMB3_goomba_float
			2.0:
				if object_index == A.obj_galoomba2:
					sprite_index = A.spr_goomba2_float
				elif object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_goomba2_float_b
				elif object_index == A.obj_galoomba_b:
					sprite_index = A.spr_goomba_float_b
				else:
					sprite_index = A.spr_goomba_float
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
			match G.apariencia:
				0.0:
					if object_index == A.obj_galoomba2:
						sprite_index = A.spr_SMB_goomba2
					elif object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_SMB_goomba2_b
					elif object_index == A.obj_galoomba_b:
						sprite_index = A.spr_SMB_goomba_b
					else:
						sprite_index = A.spr_SMB_goomba
				1.0:
					if object_index == A.obj_galoomba2:
						sprite_index = A.spr_SMB3_goomba2
					elif object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_SMB3_goomba2_b
					elif object_index == A.obj_galoomba_b:
						sprite_index = A.spr_SMB3_goomba_b
					else:
						sprite_index = A.spr_SMB3_goomba
				2.0:
					if object_index == A.obj_galoomba2:
						sprite_index = A.spr_galoomba2
					elif object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_galoomba2_b
					elif object_index == A.obj_galoomba_b:
						sprite_index = A.spr_galoomba_b
					else:
						sprite_index = A.spr_galoomba
			GM.instance_create(x, y, A.obj_paracaidas_go)
			paracaidas = 0.0
			anim = 0.0
			if G.apariencia == 3.0:
				image_speed = 0.5
			else:
				image_speed = 0.15
			hspeed = 0.0
			alarm[10] = 10.0
		var oscillationSpeed = -0.1
		var elapsedTime = (GM.current_time - startTime) / GM.room_speed
		# Calcola l'angolo oscillante tra -30 e 30 gradi
		var oscillation = (sin(oscillationSpeed * elapsedTime) * 12.0)
		image_angle = oscillation
	else:
		image_angle = 0.0
	if wings == 1.0 and paracaidas == 0.0:
		if gravity == 0.0:
			if (object_index == A.obj_galoomba2 or object_index == A.obj_galoomba2_b) and cambio_gombaya == 1.0:
				hspeed = (-hspeed)
				cambio_gombaya = 0.0
			if jumping > 0.0 and jumping < 4.0:
				jumping += 1.0
				if swimming == 0.0:
					vspeed = -2.5
				else:
					vspeed = -1.25
			elif jumping == 4.0:
				jumping = 5.0
				if swimming == 0.0:
					vspeed = -4.0
				else:
					vspeed = -2.0
			elif jumping == 5.0:
				jumping = 0.0
				cambio_gombaya = 1.0
				alarm[0] = 120.0


# from objects/obj_galoomba/Step_2.gml
func _step_end() -> void:
	super._step_end()
	if wings == 1.0 and paracaidas == 0.0 and GM.instance_exists(A.obj_mario):
		if jumping > 0.0:
			if jumping > 3.0:
				if G.apariencia == 3.0:
					anim += 1.0
				else:
					anim += 0.25
			elif G.apariencia == 3.0:
				anim += 0.5
			else:
				anim += 0.15
		else:
			anim = 0.0


# from objects/obj_galoomba/Alarm_0.gml
func _alarm_0() -> void:
	if wings == 1.0:
		if gravity == 0.0:
			jumping = 1.0
			if swimming == 0.0:
				vspeed = -2.5
			else:
				vspeed = -1.25
		else:
			alarm[0] = 10.0


# from objects/obj_galoomba/Alarm_1.gml
func _alarm_1() -> void:
	if search_mario == 0.0:
		search_mario = 1.0
	else:
		search_mario = 0.0


# from objects/obj_galoomba/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if paracaidas == 1.0 or vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, false, false) != null:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.3 * direct)
			else:
				hspeed = (0.5 * direct)
		else:
			alarm[10] = 2.0


# from objects/obj_galoomba/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_galoomba_deads
	imdead.image_index = G.apariencia
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


# from objects/obj_galoomba/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0)
		hspeed = 0.0
		alarm[10] = 2.0
		wings = 0.0
	else:
		match G.apariencia:
			0.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_SMB_goomba_stomped
			1.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_SMB3_goomba_stomped
			2.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba_hold)):
					inst.set("key", self.key)
					inst.set("direct", self.direct)
				key = 0.0
			3.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_stomped)):
					inst.sprite_index = A.spr_NSMBU_goomba_stomped
					inst.set("direct", self.direct)
		if key == 1.0 and G.apariencia != 2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
				inst.vspeed = -4.0
			key = 0.0
		instance_destroy()


# from objects/obj_galoomba/Other_15.gml
func _user_5() -> void:
	var imheld
	if G.apariencia == 2.0:
		imheld = GM.instance_create(x, (y - 2.0), A.obj_galoomba_hold)
		if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if swimming == 1.0:
				imheld.vspeed = -1.8
			else:
				imheld.vspeed = -3.0
		imheld.set("direct", direct)
		instance_destroy()
	else:
		_user_0()


# from objects/obj_galoomba/Other_17.gml
func _user_7() -> void:
	match G.apariencia:
		0.0:
			if object_index == A.obj_galoomba2:
				sprite_index = A.spr_SMB_goomba2
			else:
				sprite_index = A.spr_SMB_goomba
		1.0:
			if object_index == A.obj_galoomba2:
				sprite_index = A.spr_SMB3_goomba2
			else:
				sprite_index = A.spr_SMB3_goomba
		2.0:
			if object_index == A.obj_galoomba2:
				sprite_index = A.spr_galoomba2
			else:
				sprite_index = A.spr_galoomba


# from objects/obj_galoomba/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		match G.apariencia:
			0.0:
				GM.draw_sprite_ext(A.spr_SMB_wings_16x16, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			1.0:
				GM.draw_sprite_ext(A.spr_SMB3_wings2, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			2.0:
				GM.draw_sprite_ext(A.spr_wings2, anim, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
			3.0:
				GM.draw_sprite_ext(A.spr_NSMBU_wings_enemigos, anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
