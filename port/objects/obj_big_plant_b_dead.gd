extends "res://objects/obj_big_plant_dead.gd"


# from objects/obj_big_plant_b_dead/Create_0.gml
func _create() -> void:
	image_speed = 0.75


# from objects/obj_big_plant_b_dead/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
