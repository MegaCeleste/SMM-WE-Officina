# from objects/obj_cannonball（第 5 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var edible: float = 0.0


# from objects/obj_cannonball/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_cannonball
		1.0:
			sprite_index = A.spr_SMB3_cannonball
		2.0:
			sprite_index = A.spr_cannonball
		3.0:
			sprite_index = A.spr_NSMBU_cannonball
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		image_index = 1.0
	else:
		image_index = 0.0
	image_speed = 0.0
	hardness = 1.0
	stomp = 0.0
	edible = 0.0
	direct = 1.0
	apilar = 0.0
	alarm[0] = 15.0


# from objects/obj_cannonball/Step_0.gml
func _step() -> void:
	pass


# from objects/obj_cannonball/Alarm_0.gml
func _alarm_0() -> void:
	depth = -5.0


# from objects/obj_cannonball/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	return


# from objects/obj_cannonball/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		imdead.image_index = 1.0
	else:
		imdead.image_index = 0.0
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_cannonball/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		imdead.image_index = 1.0
	else:
		imdead.image_index = 0.0
	imdead.vspeed = 0.1
	imdead.alarm[0] = -1.0
	instance_destroy()


# from objects/obj_cannonball/Other_40.gml
func _outside_view_0() -> void:
	instance_destroy()
