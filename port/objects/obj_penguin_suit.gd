# from objects/obj_penguin_suit（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"


# from objects/obj_penguin_suit/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.5


# from objects/obj_penguin_suit/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
		image_speed = 0.0
	elif paracaidas == 1.0:
		hspeed = -0.6
		image_speed = 0.0
	else:
		hspeed = 0.2
		image_speed = 0.5
