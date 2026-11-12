extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0
var w_wings: float = 0.0
var anim: float = 0.0


# from objects/obj_bulletbill/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bulletbill
		1.0:
			sprite_index = A.spr_SMB3_bulletbill
		2.0:
			sprite_index = A.spr_bulletbill
		3.0:
			sprite_index = A.spr_NSMBU_bulletbill
	if G.apariencia == 3.0:
		image_speed = 0.15
	else:
		image_speed = 0.0
	if G.apariencia != 3.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	wings = 0.0
	w_wings = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	anim = 0.0
	alarm[0] = 15.0
	if G.apariencia != 0.0 and G.apariencia != 3.0:
		alarm[1] = 10.0


# from objects/obj_bulletbill/Step_0.gml
func _step() -> void:
	if G.apariencia == 3.0:
		anim += 0.3


# from objects/obj_bulletbill/Alarm_0.gml
func _alarm_0() -> void:
	depth = -8.0


# from objects/obj_bulletbill/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 20.0), (y - 4.0), A.obj_smoke)):
				inst.image_index = 6.0
		else:
			for inst in GM.with_list(GM.instance_create((x + 4.0), (y - 4.0), A.obj_smoke)):
				inst.image_index = 6.0
		alarm[1] = 10.0
	else:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 20.0), y, A.obj_smoke)):
				inst.sprite_index = A.spr_smoke_bulletbill
		else:
			for inst in GM.with_list(GM.instance_create((x + 4.0), y, A.obj_smoke)):
				inst.sprite_index = A.spr_smoke_bulletbill
		alarm[1] = 30.0


# from objects/obj_bulletbill/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_bulletbill/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_bulletbill_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_bulletbill_deads
		2.0:
			imdead.sprite_index = A.spr_bill_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_bulletbill_deads
	imdead.image_speed = 0.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		imdead.image_index = 1.0
	else:
		imdead.image_index = 0.0
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


# from objects/obj_bulletbill/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = direct
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	if G.apariencia != 3.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			imdead.image_index = 1.0
		else:
			imdead.image_index = 0.0
	else:
		imdead.image_index = image_index
	imdead.hspeed = 0.6
	imdead.vspeed = 0.1
	imdead.alarm[0] = -1.0
	instance_destroy()


# from objects/obj_bulletbill/Other_40.gml
func _outside_view_0() -> void:
	instance_destroy()


# from objects/obj_bulletbill/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0:
		GM.draw_sprite_ext(A.spr_NSMBU_bullet_smoke, anim, x, (y + 8.0), direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
