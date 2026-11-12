extends "res://objects/obj_deactenemyparent.gd"

var s_bonybeetle: float = 0.0
var s_bonybeetle_shell: float = 0.0
var sprite_wings: float = 0.0
var para_y: float = 0.0
var edible: float = 0.0
var s_dry: float = 0.0
var wings_anim: float = 0.0
var spiny: float = 0.0
var imdead2 = null
var imdead3 = null


# from objects/obj_bonybeetle/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bonybeetle
			s_bonybeetle = A.spr_SMB_bonybeetle
			s_bonybeetle_shell = A.spr_SMB_bonybeetle_shell
			sprite_wings = A.spr_SMB_wings
			para_y = 2.0
		1.0:
			sprite_index = A.spr_SMB3_bonybeetle
			s_bonybeetle = A.spr_SMB3_bonybeetle
			s_bonybeetle_shell = A.spr_SMB3_bonybeetle_shell
			sprite_wings = A.spr_SMB3_wings
			para_y = 0.0
		2.0:
			s_bonybeetle = A.spr_bonybeetle
			s_bonybeetle_shell = A.spr_bonybeetle_shell
			sprite_wings = A.spr_wings
			para_y = 0.0
		3.0:
			sprite_index = A.spr_NSMBU_bonybeetle
			s_bonybeetle = A.spr_NSMBU_bonybeetle
			s_bonybeetle_shell = A.spr_SMB_bonybeetle_shell
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
	spiny = 0.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.125
	alarm[0] = 180.0


# from objects/obj_bonybeetle/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0


# from objects/obj_bonybeetle/Step_0.gml
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
		if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidphy, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null)):
			if vspeed > 0.0:
				vspeed = -0.4
		elif vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_physicssolid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null):
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


# from objects/obj_bonybeetle/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0:
		match sprite_index:
			A.spr_NSMBU_bonybeetle_start:
				if image_index >= 29.5:
					sprite_index = A.spr_NSMBU_bonybeetle_spiny
					image_index = 0.0
					stomp = 1.0
				else:
					image_speed = 0.5
			A.spr_NSMBU_bonybeetle_spiny:
				if image_index >= 18.75:
					if spiny == 2.0:
						sprite_index = A.spr_NSMBU_bonybeetle_end
						image_index = 0.0
					else:
						spiny += 1.0
				else:
					image_speed = 0.25
			A.spr_NSMBU_bonybeetle_end:
				if image_index >= 11.5:
					sprite_index = A.spr_NSMBU_bonybeetle
					image_index = 0.0
					spiny = 0.0
					stomp = 3.0
					alarm[10] = 2.0
					alarm[0] = 180.0
				else:
					image_speed = 0.5
	elif spiny == 1.0:
		if image_index >= 2.85:
			image_speed = 0.0
			image_index = 2.85
	elif spiny == 2.0:
		if image_index <= 0.15:
			sprite_index = s_bonybeetle
			image_speed = 0.15
			image_index = 0.0
			spiny = 0.0
			stomp = 3.0
			alarm[10] = 2.0
			alarm[0] = 180.0


# from objects/obj_bonybeetle/Alarm_0.gml
func _alarm_0() -> void:
	hspeed = 0.0
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_bonybeetle_start
		image_speed = 0.5
		image_index = 0.0
	else:
		alarm[1] = 10.0


# from objects/obj_bonybeetle/Alarm_1.gml
func _alarm_1() -> void:
	sprite_index = s_bonybeetle_shell
	image_speed = 0.15
	image_index = 0.0
	spiny = 1.0
	stomp = 1.0
	alarm[2] = 180.0


# from objects/obj_bonybeetle/Alarm_2.gml
func _alarm_2() -> void:
	sprite_index = s_bonybeetle_shell
	image_speed = -0.15
	image_index = 2.0
	spiny = 2.0


# from objects/obj_bonybeetle/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		hspeed = ((0.5 - (0.2 * swimming)) * direct)


# from objects/obj_bonybeetle/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_break(self))
	GM.audio_play_sound(Scr.scr_snd_break(self), 0.0, false)
	match G.apariencia:
		0.0:
			s_dry = A.spr_SMB_bonybeetle_deads
		1.0:
			s_dry = A.spr_SMB3_bonybeetle_deads
		2.0:
			s_dry = A.spr_bonybeetle_deads
		3.0:
			s_dry = A.spr_NSMBU_bonybeetle_deads
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


# from objects/obj_bonybeetle/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		for inst in GM.with_list(GM.instance_create(GM.gm_round(x), y, A.obj_crumblebony)):
			inst.direct = self.direct
		instance_destroy()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.image_xscale = self.direct
		wings = 0.0
		alarm[10] = 2.0


# from objects/obj_bonybeetle/Other_15.gml
func _user_5() -> void:
	_user_0()


# from objects/obj_bonybeetle/Draw_0.gml
func _gm_draw() -> void:
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), (y + para_y), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, 0.0, GM.c_white, 1.0)
