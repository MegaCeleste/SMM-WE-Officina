extends "res://objects/obj_deactenemyparent.gd"

var night_sprite: float = 0.0
var sprite_wings: float = 0.0
var destroy_door: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var time_blow: float = 0.0
var s_bobomb: float = 0.0
var startTime: float = 0.0
var imheld = null


# from objects/obj_bobomb/Create_0.gml
func _create() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		night_sprite = 1.0
	else:
		night_sprite = 0.0
	match G.apariencia:
		0.0:
			if night_sprite == 1.0:
				sprite_index = A.spr_SMB_bobomb_night
			else:
				sprite_index = A.spr_SMB_bobomb
			sprite_wings = A.spr_SMB_wings
		1.0:
			if night_sprite == 1.0:
				sprite_index = A.spr_SMB3_bobomb_night
			else:
				sprite_index = A.spr_SMB3_bobomb
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_index = A.spr_bobomb
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_bobomb
			sprite_wings = A.spr_NSMBU_wings_enemigos
	destroy_door = 0.0
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	modo_lava = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	swimming = 0.0
	time_blow = 0.0
	s_bobomb = A.spr_bobomb
	can_wings_deads = 1.0
	apilar = 0.0
	startTime = GM.current_time
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.6
	else:
		image_speed = 0.15


# from objects/obj_bobomb/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0 and can_wings_deads == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = 1.0
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = -1.0


# from objects/obj_bobomb/Step_0.gml
func _step() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		if GM.instance_exists(A.obj_mario):
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
			GM.instance_create(x, y, A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
			y += 1.0
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
	if GM.instance_exists(A.obj_lava_water) and (y + 16.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "castle":
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()
	elif GM.instance_exists(A.obj_lava_water) and (y + 16.0) >= GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "mountain" and G.modo_noche == 1.0:
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()


# from objects/obj_bobomb/Alarm_10.gml
func _alarm_10() -> void:
	super._alarm_10()
	if wings == 1.0 or paracaidas == 1.0:
		match G.apariencia:
			0.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB_bobomb_wings_night
				else:
					sprite_index = A.spr_SMB_bobomb_wings
			1.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB3_bobomb_wings_night
				else:
					sprite_index = A.spr_SMB3_bobomb_wings
			2.0:
				sprite_index = A.spr_bobomb_wings
			3.0:
				sprite_index = A.spr_NSMBU_bobomb_wings


# from objects/obj_bobomb/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bobomb_deads
			imdead.image_speed = 0.0
			if night_sprite == 1.0:
				imdead.image_index = 1.0
			else:
				imdead.image_index = 0.0
		1.0:
			imdead.sprite_index = A.spr_SMB3_bobomb_deads
			imdead.image_speed = 0.0
			if night_sprite == 1.0:
				imdead.image_index = 1.0
			else:
				imdead.image_index = 0.0
		2.0:
			imdead.sprite_index = A.spr_bobomb_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_bobomb_deads
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


# from objects/obj_bobomb/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x - 9.0), (y - (9.0 * direct)), A.obj_wings_dead)):
			inst.direct = self.direct
		hspeed = 0.0
		wings = 0.0
		match G.apariencia:
			0.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB_bobomb_night
				else:
					sprite_index = A.spr_SMB_bobomb
			1.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB3_bobomb_night
				else:
					sprite_index = A.spr_SMB3_bobomb_wings
			2.0:
				sprite_index = A.spr_bobomb
			3.0:
				sprite_index = A.spr_NSMBU_bobomb
		alarm[10] = 1.0
	else:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_bobomb_hold)):
			inst.direct = self.direct
		instance_destroy()


# from objects/obj_bobomb/Other_15.gml
func _user_5() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_bobomb_hold)
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	imheld.direct = direct
	instance_destroy()


# from objects/obj_bobomb/Other_17.gml
func _user_7() -> void:
	if object_index == A.obj_bobomb_ready:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_bobomb_ready
			1.0:
				sprite_index = A.spr_SMB3_bobomb_ready
			2.0:
				sprite_index = A.spr_bobomb_ready
			3.0:
				sprite_index = A.spr_NSMBU_bobomb_ready
		if G.apariencia == 3.0:
			image_speed = 1.0
		else:
			image_speed = 0.2
	else:
		match G.apariencia:
			0.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB_bobomb_night
				else:
					sprite_index = A.spr_SMB_bobomb
			1.0:
				if night_sprite == 1.0:
					sprite_index = A.spr_SMB3_bobomb_night
				else:
					sprite_index = A.spr_SMB3_bobomb
			2.0:
				sprite_index = A.spr_bobomb
			3.0:
				sprite_index = A.spr_NSMBU_bobomb
		if G.apariencia == 3.0:
			image_speed = 0.6
		else:
			image_speed = 0.15


# from objects/obj_bobomb/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		if direct == 1.0:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x - 12.0), (y - 20.0), direct, 1.0, image_angle, GM.c_white, 1.0)
		else:
			GM.draw_sprite_ext(sprite_wings, wings_anim, (x + 12.0), (y - 20.0), direct, 1.0, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
