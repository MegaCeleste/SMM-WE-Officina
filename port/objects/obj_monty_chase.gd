extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var charge: float = 0.0
var startTime: float = 0.0
var prevhspeed: float = 0.0


# from objects/obj_monty_chase/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_montymole
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_index = A.spr_SMB3_montymole
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_montymole
			sprite_wings = A.spr_NSMBU_wings_enemigos
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
	charge = 0.0
	apilar = 0.0
	startTime = GM.current_time
	if G.apariencia == 3.0:
		image_speed = 1.0
	else:
		image_speed = 0.2
	alarm[10] = 2.0


# from objects/obj_monty_chase/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", 1.0)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)


# from objects/obj_monty_chase/Step_0.gml
func _step() -> void:
	var dark: float
	prevhspeed = hspeed
	super._step()
	if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		dark = 1.0
	else:
		dark = 0.0
	if hspeed != prevhspeed and paracaidas == 0.0:
		if dark == 1.0:
			hspeed = (GM.gm_sign(hspeed) * 0.6)
		else:
			hspeed = (GM.gm_sign(hspeed) * 1.5)
		if gravity == 0.0:
			vspeed = -1.5
			y -= 1.0
	if charge == 1.0 and paracaidas == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			hspeed -= 0.0324
			if dark == 1.0:
				if hspeed < -1.0:
					hspeed = -1.0
			elif hspeed < -1.5:
				hspeed = -1.5
		else:
			hspeed += 0.0324
			if hspeed > 1.5:
				hspeed = 1.5
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if wings == 1.0 and paracaidas == 0.0 and GM.instance_exists(A.obj_mario):
		if G.apariencia == 3.0:
			wings_anim += 0.5
		else:
			wings_anim += 0.12
		if gravity == 0.0:
			if swimming == 1.0:
				vspeed = -2.0
			else:
				vspeed = -3.0
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
			GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
			paracaidas = 0.0
			hspeed = 0.0
			alarm[10] = 10.0
	if paracaidas == 1.0:
		var oscillationSpeed = -0.1
		var elapsedTime = (GM.current_time - startTime) / GM.room_speed
		# Calcola l'angolo oscillante tra -30 e 30 gradi
		var oscillation = (sin(oscillationSpeed * elapsedTime) * 12.0)
		image_angle = oscillation
	else:
		image_angle = 0.0


# from objects/obj_monty_chase/Alarm_10.gml
func _alarm_10() -> void:
	charge = 1.0
	if paracaidas == 1.0:
		hspeed = -0.5


# from objects/obj_monty_chase/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_monty_deads
	imdead.image_index = G.apariencia
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


# from objects/obj_monty_chase/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		_user_0()
	elif wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", 1.0)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.set("direct", -1.0)
		wings = 0.0


# from objects/obj_monty_chase/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		if direct == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - 12.0), (y - 20.0), direct, 1.0, image_angle, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x + 12.0), (y - 20.0), direct, 1.0, image_angle, GM.c_white, 1.0)
