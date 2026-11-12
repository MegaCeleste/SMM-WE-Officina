# from objects/obj_cannonball_red（第 5 批移植，已核对）
extends "res://objects/obj_cannonball.gd"


# from objects/obj_cannonball_red/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 2.0


# from objects/obj_cannonball_red/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = 2.0
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


# from objects/obj_cannonball_red/Other_11.gml
func _user_1() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = 2.0
	imdead.vspeed = 0.1
	imdead.alarm[0] = -1.0
	instance_destroy()
