extends "res://objects/obj_deactivation.gd"


# from objects/obj_modelbgo/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if object_index != A.obj_modelbgo_dec and place_meeting(x, y, other) and image_index != 39.0 and image_index != 42.0:
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.hspeed = 0.0
			inst.vspeed = 0.0
			inst.isduck = 1.0
