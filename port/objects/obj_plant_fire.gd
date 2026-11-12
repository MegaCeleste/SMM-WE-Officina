extends "res://objects/obj_enemyparent.gd"

var s_down: float = 0.0
var s_up: float = 0.0
var sprite_wings: float = 0.0
var edible: float = 0.0
var shoot = null
var anim_shoot: float = 0.0
var posx_fire: float = 0.0
var posy_fire: float = 0.0
var wings_anim: float = 0.0


# from objects/obj_plant_fire/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pplant_fire_down
			s_down = A.spr_SMB_pplant_fire_down
			s_up = A.spr_SMB_pplant_fire_up
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_pplant_fire_down
			s_down = A.spr_SMB3_pplant_fire_down
			s_up = A.spr_SMB3_pplant_fire_up
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_pplant_fire_down
			s_down = A.spr_pplant_fire_down
			s_up = A.spr_pplant_fire_up
			sprite_wings = A.spr_wings2
		3.0:
			sprite_index = A.spr_NSMBU_pplant_fire_down
			s_down = A.spr_NSMBU_pplant_fire_down
			s_up = A.spr_NSMBU_pplant_fire_up
			sprite_wings = A.spr_NSMBU_wings_items
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	shoot = 0.0
	anim_shoot = 0.0
	posx_fire = (x - 5.0)
	posy_fire = (y + 5.0)
	innave = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	dead_h = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	alarm[10] = 2.0
	alarm[2] = 120.0
	if G.apariencia == 3.0:
		image_speed = 0.25
	else:
		image_speed = 0.1


# from objects/obj_plant_fire/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0


# from objects/obj_plant_fire/Step_2.gml
func _step_end() -> void:
	if G.apariencia == 3.0 and shoot == 1.0 and anim_shoot == 0.0:
		if image_index >= 5.0:
			alarm[3] = 1.0
			anim_shoot = 1.0
	if gravity == 0.0:
		hspeed = (maxf(0.0, (absf(hspeed) - 0.15)) * GM.gm_sign(hspeed))
		if absf(hspeed) < 0.15:
			hspeed = 0.0
	if GM.instance_exists(A.obj_mario) and shoot == 0.0:
		if GM.instance_find(A.obj_mario, 0).y < (y - 21.0):
			sprite_index = s_up
		elif GM.instance_find(A.obj_mario, 0).y > (y - 21.0):
			sprite_index = s_down
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0
	if wings == 1.0:
		if G.apariencia == 3.0:
			wings_anim += 0.5
		else:
			wings_anim += 0.12
	super._step_end()


# from objects/obj_plant_fire/Alarm_2.gml
func _alarm_2() -> void:
	shoot = 1.0
	if G.apariencia == 3.0:
		if sprite_index == s_up:
			sprite_index = A.spr_NSMBU_pplant_up_shoot
		else:
			sprite_index = A.spr_NSMBU_pplant_down_shoot
		image_index = 0.0
		image_speed = 0.25
	else:
		image_speed = 0.0
		image_index = 1.0
		alarm[3] = 30.0


# from objects/obj_plant_fire/Alarm_3.gml
func _alarm_3() -> void:
	var shoot
	GM.audio_stop_sound(A.snd_podoboo)
	GM.audio_play_sound(A.snd_podoboo, 0.0, false)
	if G.apariencia != 3.0:
		image_index = 0.0
	if sprite_index == s_up or sprite_index == A.spr_NSMBU_pplant_up_shoot:
		posy_fire = (y - 11.0)
	elif sprite_index == s_down or sprite_index == A.spr_NSMBU_pplant_down_shoot:
		posy_fire = (y - 6.0)
	shoot = GM.instance_create((x + (10.0 * direct)), posy_fire, A.obj_plantfire)
	shoot.hspeed = ((1.0 - (0.5 * swimming)) * GM.gm_sign(direct))
	if sprite_index == s_up or sprite_index == A.spr_NSMBU_pplant_up_shoot:
		shoot.vspeed = (-(0.5 - (0.25 * swimming)))
	elif sprite_index == s_down or sprite_index == A.spr_NSMBU_pplant_down_shoot:
		shoot.vspeed = (0.5 - (0.25 * swimming))
	if G.apariencia != 3.0:
		alarm[4] = 40.0


# from objects/obj_plant_fire/Alarm_4.gml
func _alarm_4() -> void:
	shoot = 0.0
	if G.apariencia != 3.0:
		image_speed = 0.1
	else:
		image_speed = 0.25
	alarm[2] = 100.0


# from objects/obj_plant_fire/Alarm_10.gml
func _alarm_10() -> void:
	if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
		direct = -1.0
	else:
		direct = 1.0


# from objects/obj_plant_fire/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_NSMBU_pplant_up_shoot:
		sprite_index = A.spr_NSMBU_pplant_fire_up
		image_speed = 0.25
		image_index = 0.0
		shoot = 0.0
		anim_shoot = 0.0
		alarm[2] = 100.0
	elif sprite_index == A.spr_NSMBU_pplant_down_shoot:
		sprite_index = A.spr_NSMBU_pplant_fire_down
		image_speed = 0.25
		image_index = 0.0
		shoot = 0.0
		anim_shoot = 0.0
		alarm[2] = 100.0


# from objects/obj_plant_fire/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_plant_fire_deads
	imdead.image_index = G.apariencia
	imdead.direct = direct
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


# from objects/obj_plant_fire/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
