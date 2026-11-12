extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var edible: float = 0.0
var direct_t: float = 0.0
var rotacion: float = 0.0
var wings_anim: float = 0.0
var jump_plant: float = 0.0
var modo_vuelo: float = 0.0
var y_start_vuelo: float = 0.0
var fire: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var ready2: float = 0.0


# from objects/obj_piranhaplant/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pplant
			image_speed = 0.125
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_pplant
			image_speed = 0.125
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			image_speed = 0.125
			sprite_wings = A.spr_wings2
		3.0:
			sprite_index = A.spr_NSMBU_pplant
			image_speed = 0.3
			sprite_wings = A.spr_wings2
	hardness = 101.0
	stomp = 1.0
	edible = 0.0
	direct = 1.0
	direct_t = 0.0
	rotacion = 0.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	jump_plant = 0.0
	modo_vuelo = 0.0
	y_start_vuelo = y
	dead_h = 0.0
	modo_lava = 0.0
	apilar = 0.0
	fire = 0.0
	ready_v = 0.0
	ready2 = 0.0
	swimming = 0.0
	alarm[0] = 1.0
	alarm[4] = 1.0


# from objects/obj_piranhaplant/Step_0.gml
func _step() -> void:
	return


# from objects/obj_piranhaplant/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_mario):
		if (direct_t == 0.0 and GM.instance_find(A.obj_mario, 0).x > (x - 32.0) and GM.instance_find(A.obj_mario, 0).x < (x + 32.0) and GM.instance_find(A.obj_mario, 0).y >= (y - 64.0) and GM.instance_find(A.obj_mario, 0).y <= (y - 16.0)) or (direct_t == 1.0 and GM.instance_find(A.obj_mario, 0).x < (x + 32.0) and GM.instance_find(A.obj_mario, 0).y >= (y - 32.0) and GM.instance_find(A.obj_mario, 0).y <= (y - 32.0)) or (direct_t == 2.0 and GM.instance_find(A.obj_mario, 0).x > (x - 16.0) and GM.instance_find(A.obj_mario, 0).x < (x + 16.0) and GM.instance_find(A.obj_mario, 0).y >= (y - 64.0) and GM.instance_find(A.obj_mario, 0).y <= (y - 16.0)) or (direct_t == 3.0 and GM.instance_find(A.obj_mario, 0).x > (x - 32.0) and GM.instance_find(A.obj_mario, 0).y >= (y - 32.0) and GM.instance_find(A.obj_mario, 0).y <= (y - 32.0)):
			alarm[0] = 1.0
			return
		match direct_t:
			0.0:
				vspeed = -1.0
			1.0:
				hspeed = 1.0
			2.0:
				vspeed = 1.0
			3.0:
				hspeed = -1.0
		alarm[1] = 32.0
		alarm[5] = 16.0
	else:
		alarm[0] = 1.0
		return


# from objects/obj_piranhaplant/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	hspeed = 0.0
	match direct_t:
		0.0:
			y = (ystart - 32.0)
		1.0:
			x = (xstart + 32.0)
		2.0:
			y = (ystart + 32.0)
		3.0:
			x = (xstart - 32.0)
	alarm[2] = 90.0


# from objects/obj_piranhaplant/Alarm_2.gml
func _alarm_2() -> void:
	match direct_t:
		0.0:
			vspeed = 1.0
		1.0:
			hspeed = -1.0
		2.0:
			vspeed = -1.0
		3.0:
			hspeed = 1.0
	alarm[3] = 32.0
	alarm[5] = 16.0


# from objects/obj_piranhaplant/Alarm_3.gml
func _alarm_3() -> void:
	hspeed = 0.0
	vspeed = 0.0
	x = xstart
	y = ystart
	alarm[0] = 90.0


# from objects/obj_piranhaplant/Alarm_4.gml
func _alarm_4() -> void:
	match direct_t:
		0.0:
			mask_index = A.spr_piranha_mask_up
		1.0:
			mask_index = A.spr_piranha_mask_right
		2.0:
			mask_index = A.spr_piranha_mask_down
		3.0:
			mask_index = A.spr_piranha_mask_left


# from objects/obj_piranhaplant/Alarm_5.gml
func _alarm_5() -> void:
	if hardness == 0.0:
		hardness = 101.0
	else:
		hardness = 0.0


# from objects/obj_piranhaplant/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	super._collision_obj_mario(other)


# from objects/obj_piranhaplant/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			imdead = GM.instance_create((x + 8.0), (y + 4.0), A.obj_enemy_dead)
			imdead.sprite_index = A.spr_SMB_pplant_deads
		1.0:
			imdead = GM.instance_create((x + 8.0), (y + 4.0), A.obj_enemy_dead)
			imdead.sprite_index = A.spr_SMB3_pplant_deads
		2.0:
			imdead = GM.instance_create((x + 8.0), y, A.obj_enemy_dead)
			imdead.sprite_index = A.spr_jumppiranha_deads
		3.0:
			imdead = GM.instance_create((x + 8.0), y, A.obj_enemy_dead)
			imdead.sprite_index = A.spr_NSMBU_pplant_deads
	imdead.girar = 1.0
	imdead.image_xscale = direct
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


# from objects/obj_piranhaplant/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
