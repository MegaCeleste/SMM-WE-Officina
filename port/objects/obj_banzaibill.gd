extends "res://objects/obj_deactenemyparent.gd"

var direct_t: float = 0.0
var anim: float = 0.0
var edible: float = 0.0
var rotacion: float = 0.0
var w_wings: float = 0.0


# from objects/obj_banzaibill/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_banzaibill
			image_speed = 0.0
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		1.0:
			sprite_index = A.spr_SMB3_banzaibill
			image_speed = 0.0
			if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		2.0:
			sprite_index = A.spr_banzaibill
		3.0:
			sprite_index = A.spr_NSMBU_banzaibill
			image_speed = 0.0
			match G.bg_level:
				"airship":
					image_index = 6.0
				"sky":
					image_index = 6.0
				"desert":
					image_index = 5.0
				"forest":
					image_index = 4.0
				"ghost":
					image_index = 3.0
				"castle":
					image_index = 2.0
				"underground":
					image_index = 1.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 6.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0
		4.0:
			sprite_index = A.spr_SMB_banzaibill
	direct_t = 1.0
	anim = 0.0
	hardness = 99.0
	stomp = 0.0
	edible = 2.0
	direct = 1.0
	rotacion = 0.0
	dead_h = 0.0
	wings = 0.0
	w_wings = 0.0
	apilar = 0.0
	swimming = 0.0
	alarm[10] = 1.0
	if G.apariencia != 0.0 and G.apariencia != 3.0:
		alarm[0] = 15.0


# from objects/obj_banzaibill/Step_0.gml
func _step() -> void:
	if G.apariencia == 3.0 and (not GM.instance_exists(A.obj_deadmario)):
		anim += 0.3


# from objects/obj_banzaibill/Alarm_0.gml
func _alarm_0() -> void:
	match direct_t:
		1.0:
			for inst in GM.with_list(GM.instance_create((x + 32.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_smokespin
				inst.depth = 0.0
		2.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 32.0), A.obj_smoke)):
				inst.sprite_index = A.spr_smokespin
				inst.depth = 0.0
		3.0:
			for inst in GM.with_list(GM.instance_create((x - 32.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_smokespin
				inst.depth = 0.0
		4.0:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 32.0), A.obj_smoke)):
				inst.sprite_index = A.spr_smokespin
				inst.depth = 0.0
	alarm[0] = 20.0


# from objects/obj_banzaibill/Alarm_10.gml
func _alarm_10() -> void:
	var vel: float
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky"):
		vel = 0.6
	else:
		vel = 1.0
	match direct_t:
		1.0:
			hspeed = (-vel)
		2.0:
			vspeed = vel
		3.0:
			hspeed = vel
		4.0:
			vspeed = (-vel)


# from objects/obj_banzaibill/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_banzaibill/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = image_index
	imdead.direct_y = direct
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


# from objects/obj_banzaibill/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = image_index
	imdead.image_angle = rotacion
	imdead.direct_y = direct
	imdead.hspeed = 0.6
	imdead.vspeed = 0.0
	imdead.alarm[0] = -1.0
	instance_destroy()


# from objects/obj_banzaibill/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0:
		GM.draw_sprite_ext(A.spr_NSMBU_smoke_bz, anim, x, y, 1.0, direct, rotacion, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, direct, rotacion, GM.c_white, 1.0)
