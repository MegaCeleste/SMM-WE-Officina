# 第 7 批移植，已核对。
extends "res://objects/obj_muncher.gd"


# from objects/obj_muncher_b/Create_0.gml
func _create() -> void:
	var dark: float  # 局部变量提升（GML 的 var 是函数作用域）
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_muncher_night_b
			else:
				sprite_index = A.spr_SMB_muncher_b
			image_speed = 0.1
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_muncher_night_b
			else:
				sprite_index = A.spr_SMB3_muncher_b
			image_speed = 0.1
		2.0:
			image_speed = 0.1
		3.0:
			sprite_index = A.spr_NSMBU_muncher_b
			image_speed = 0.3
	wings = 0.0
	direct = 1.0
	dead_h = 0.0
	apilar = 0.0
	mebelow = null
	modo_lava = 0.0
	swimming = 0.0
	if position_meeting(x, (bbox_bottom + 8.0), A.obj_muncher_b):
		mebelow = collision_point(x, (bbox_bottom + 8.0), A.obj_muncher_b, false, false)
		alarm[0] = 10.0
	else:
		mebelow = null
	a = -16.0
	alarm[9] = 2.0
	offset = 0.0
	offsetnext = 0.0
	offsetxscale = 1.0


# from objects/obj_muncher_b/Other_10.gml
func _user_0() -> void:
	var dark: float  # 局部变量提升（GML 的 var 是函数作用域）
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.sprite_index = A.spr_muncher_b_deads
	imdead.girar = 1.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				imdead.image_index = 1.0
			else:
				imdead.image_index = 0.0
		1.0:
			if dark == 1.0:
				imdead.image_index = 3.0
			else:
				imdead.image_index = 2.0
		2.0:
			imdead.image_index = 4.0
		3.0:
			imdead.image_index = 5.0
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
