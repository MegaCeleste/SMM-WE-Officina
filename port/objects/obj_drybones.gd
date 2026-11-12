extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var para_y: float = 0.0
var edible: float = 0.0
var s_dry: float = 0.0
var wings_anim: float = 0.0
var imdead2 = null
var imdead3 = null


# from objects/obj_drybones/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_drybones
			sprite_wings = A.spr_SMB_wings
			para_y = 2.0
		1.0:
			sprite_index = A.spr_SMB3_drybones
			sprite_wings = A.spr_SMB3_wings
			para_y = 0.0
		2.0:
			sprite_wings = A.spr_wings
			para_y = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_drybones
			sprite_wings = A.spr_NSMBU_wings_enemigos
			para_y = 0.0
	hardness = 6.0
	stomp = 3.0
	edible = 1.0
	dead_h = 0.0
	s_dry = A.spr_drybones_deads
	innave = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[0] = 180.0


# from objects/obj_drybones/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0


# from objects/obj_drybones/Step_0.gml
func _step() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) > GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if wings == 0.0 or paracaidas == 1.0:
		super._step()
		_user_6()
	elif wings == 1.0 and paracaidas == 0.0:
		wings_anim += 0.12
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
		if y > (ystart + 32.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.015
		elif y < (ystart - 32.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.015
		if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_pow_hold, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_block_pow_hold, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null)):
			if vspeed > 0.0:
				vspeed = -0.4
		elif vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null):
			vspeed = 0.4
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
			GM.instance_create((x + (3.0 * direct)), (y + para_y), A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
			hspeed = 0.0
			alarm[10] = 10.0


# from objects/obj_drybones/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia == 2.0:
		hspeed = 0.0
		sprite_index = A.spr_drybones_shoot
		image_index = 0.0
		image_speed = 0.0
		alarm[2] = 30.0
		alarm[0] = 240.0


# from objects/obj_drybones/Alarm_1.gml
func _alarm_1() -> void:
	image_speed = 0.125
	sprite_index = A.spr_drybones
	if wings == 0.0:
		if swimming == 1.0:
			hspeed = (0.3 * direct)
		else:
			hspeed = (0.5 * direct)


# from objects/obj_drybones/Alarm_2.gml
func _alarm_2() -> void:
	image_speed = 0.125


# from objects/obj_drybones/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 0.0:
		if hspeed == 0.0:
			if swimming == 1.0:
				hspeed = (0.3 * direct)
			else:
				hspeed = (0.5 * direct)
	else:
		vspeed = 0.5
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0


# from objects/obj_drybones/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_drybones_shoot:
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_bone)):
			if self.direct == -1.0:
				if self.swimming == 1.0:
					inst.hspeed = -0.5
				else:
					inst.hspeed = -1.0
				inst.direct = -1.0
			else:
				if self.swimming == 1.0:
					inst.hspeed = 0.5
				else:
					inst.hspeed = 1.0
				inst.direct = 1.0
		image_speed = 0.0
		image_index = 1.0
		alarm[1] = 25.0


# from objects/obj_drybones/Other_10.gml
func _user_0() -> void:
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_drybones_deads
		1.0:
			s_dry = A.spr_SMB3_drybones_deads
		2.0:
			s_dry = A.spr_drybones_deads
		3.0:
			s_dry = A.spr_NSMBU_drybones_deads
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = s_dry
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	imdead.gravity = 0.16
	imdead2 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead2.girar = 1.0
	imdead2.sprite_index = s_dry
	imdead2.image_speed = 0.0
	imdead2.image_index = 1.0
	imdead2.direct = direct
	imdead2.gravity = 0.16
	imdead3 = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead3.girar = 1.0
	imdead3.sprite_index = s_dry
	imdead3.image_speed = 0.0
	imdead3.image_index = 2.0
	imdead3.direct = direct
	imdead3.gravity = 0.16
	if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = -1.0
		imdead2.hspeed = 1.0
		imdead3.hspeed = 0.3
	elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imdead.hspeed = 1.0
		imdead2.hspeed = -1.0
		imdead3.hspeed = -0.3
	instance_destroy()


# from objects/obj_drybones/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		for inst in GM.with_list(GM.instance_create(GM.gm_round(x), y, A.obj_crumblebones)):
			inst.direct = self.direct
		instance_destroy()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.image_xscale = self.direct
		wings = 0.0
		alarm[10] = 2.0


# from objects/obj_drybones/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		if wings == 0.0:
			hspeed = (-hspeed)
		else:
			hspeed = 0.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_drybones/Other_15.gml
func _user_5() -> void:
	_user_0()


# from objects/obj_drybones/Draw_0.gml
func _gm_draw() -> void:
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), (y + para_y), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, 0.0, GM.c_white, 1.0)
