extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: int = -1
var edible: float = 0.0
var act_modo_vuelo: float = 0.0
var modo_vuelo: float = 0.0
var modo_water: float = 0.0
var wings_anim: float = 0.0
var jump: float = 0.0
var lava: float = 0.0
var anim: float = 0.0


# from objects/obj_cheepcheep/Create_0.gml
func _create() -> void:
	var vuelo
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_cheepcheep
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_index = A.spr_SMB3_cheepcheep
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_cheepcheep
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 0.0
	vuelo = 0.0
	act_modo_vuelo = 0.0
	modo_vuelo = 0.0
	modo_water = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	modo_lava = 0.0
	dead_h = 0.0
	direct = -1.0
	jump = 0.0
	apilar = 0.0
	lava = 0.0
	anim = 0.0
	swimming = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[10] = 4.0


# from objects/obj_cheepcheep/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct


# from objects/obj_cheepcheep/Step_0.gml
func _step() -> void:
	if G.bg_level != "underwater" and modo_water == 0.0:
		if act_modo_vuelo == 1.0 and place_free(x, (y + 1.0)) and vspeed > 0.0:
			modo_vuelo = 1.0
			alarm[0] = 120.0
			act_modo_vuelo = 0.0
		if paracaidas == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
		elif modo_vuelo == 0.0:
			gravity = 0.12
			if direct == 1.0 and hspeed > 0.5:
				hspeed -= 0.08
				if hspeed <= 0.5:
					hspeed = 0.5
			elif direct == -1.0 and hspeed < -0.5:
				hspeed += 0.08
				if hspeed >= -0.5:
					hspeed = -0.5
			if vspeed > 4.0:
				vspeed = 4.0
		elif modo_vuelo == 1.0:
			gravity = 0.0
			vspeed -= 0.03
			hspeed = (0.2 * direct)
			if vspeed < 0.3:
				vspeed = -0.3
		if (GM.instance_exists(A.obj_lava_water) and y >= GM.instance_find(A.obj_lava_water, 0).y) or (G.bg_level != "forest" and G.bg_level != "castle" and y >= (GM.room_height - 16.0)):
			if paracaidas == 1.0:
				GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
				paracaidas = 0.0
				hspeed = 0.0
				alarm[10] = 10.0
			if direct == 1.0:
				if wings == 1.0:
					hspeed = 1.0
				else:
					hspeed = 0.8
			elif wings == 1.0:
				hspeed = -1.0
			else:
				hspeed = -0.8
			if G.bg_level == "castle":
				if lava == 0.0:
					lava = 1.0
					alarm[1] = 8.0
			elif G.bg_level == "forest" and G.modo_noche == 1.0:
				lava = 1.0
			match jump:
				0.0:
					jump = 1.0
					vspeed = -3.0
				1.0:
					jump = 2.0
					vspeed = -3.0
				2.0:
					vspeed = -5.0
					if wings == 1.0:
						act_modo_vuelo = 1.0
					jump = 0.0
			if G.bg_level != "castle":
				for inst in GM.with_list(GM.instance_create((x - 13.0), (y - 6.0), A.obj_spinthump)):
					inst.sprite_index = A.spr_cheepcheep_bubble
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
	if lava == 1.0:
		if G.apariencia == 3.0:
			anim += 0.5
		else:
			anim += 0.15
	if paracaidas == 0.0:
		if hspeed > 0.0:
			direct = 1.0
		elif hspeed < 0.0:
			direct = -1.0
	if wings == 1.0:
		if modo_vuelo == 1.0:
			wings_anim += 0.25
		else:
			wings_anim += 0.12
		if G.bg_level == "underwater" or modo_water == 1.0:
			if y > (ystart + 16.0):
				if vspeed < -0.5:
					vspeed = -0.5
				else:
					vspeed -= 0.015
			elif y < (ystart - 16.0):
				if vspeed > 0.5:
					vspeed = 0.5
				else:
					vspeed += 0.015
		if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0 and modo_water == 1.0:
			y = (GM.instance_find(A.obj_lava_water, 0).y + 16.0)
	if paracaidas == 1.0 and (G.bg_level == "underwater" or (G.bg_level != "forest" and G.bg_level != "castle" and y >= (GM.room_height - 16.0))):
		GM.instance_create((x + (3.0 * direct)), y, A.obj_paracaidas_go)
		paracaidas = 0.0
		alarm[10] = 10.0


# from objects/obj_cheepcheep/Alarm_0.gml
func _alarm_0() -> void:
	modo_vuelo = 0.0


# from objects/obj_cheepcheep/Alarm_1.gml
func _alarm_1() -> void:
	for inst in GM.with_list(GM.instance_create(((x - 4.0) + GM.random(GM.gm_round(16.0))), ((y - 4.0) + GM.random(GM.gm_round(16.0))), A.obj_smoke)):
		match G.apariencia:
			2.0:
				inst.sprite_index = A.spr_fire_rest
			3.0:
				inst.sprite_index = A.spr_NSMBU_fire_rest
			_:
				inst.sprite_index = A.spr_SMB3_fire_rest
		inst.image_speed = 0.15
		inst.depth = (self.depth - 1.0)
	alarm[1] = 4.0


# from objects/obj_cheepcheep/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if G.bg_level == "underwater" or modo_water == 1.0:
			if direct == 1.0:
				if wings == 1.0:
					vspeed = 0.5
				hspeed = 0.5
			else:
				if wings == 1.0:
					vspeed = 0.5
				hspeed = -0.5
		elif paracaidas == 1.0:
			hspeed = 0.5


# from objects/obj_cheepcheep/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and G.bg_level == "forest" and G.modo_noche == 0.0 and y >= GM.instance_find(A.obj_lava_water, 0).y):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	elif lava == 1.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	else:
		super._collision_obj_mario(other)


# from objects/obj_cheepcheep/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_cheepcheep_deads
	imdead.image_index = G.apariencia
	imdead.direct = direct
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


# from objects/obj_cheepcheep/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		_user_0()
	else:
		vspeed = 0.0
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		act_modo_vuelo = 0.0
		alarm[0] = 1.0
		alarm[10] = 2.0


# from objects/obj_cheepcheep/Other_24.gml
func _user_14() -> void:
	return


# from objects/obj_cheepcheep/Draw_0.gml
func _gm_draw() -> void:
	if lava == 1.0:
		match G.apariencia:
			0.0:
				if G.bg_level == "forest":
					GM.draw_sprite(A.spr_SMB_purple_cheepcheep, anim, x, y)
				else:
					GM.draw_sprite(A.spr_SMB3_fire_cheepcheep, anim, x, y)
			1.0:
				if G.bg_level == "forest":
					GM.draw_sprite(A.spr_SMB3_purple_cheepcheep, anim, x, y)
				else:
					GM.draw_sprite(A.spr_SMB3_fire_cheepcheep, anim, x, y)
			2.0:
				if G.bg_level == "forest":
					GM.draw_sprite(A.spr_purple_cheepcheep, anim, x, y)
				else:
					GM.draw_sprite(A.spr_fire_cheepcheep, anim, x, y)
			3.0:
				if G.bg_level == "forest":
					GM.draw_sprite(A.spr_NSMBU_pocion_cheepcheep, anim, x, y)
				else:
					GM.draw_sprite(A.spr_NSMBU_fire_cheepcheep, anim, x, y)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 20.0), direct, 1.0, 0.0, GM.c_white, 1.0)
