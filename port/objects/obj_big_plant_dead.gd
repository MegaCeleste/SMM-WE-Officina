extends GMObject


# from objects/obj_big_plant_dead/Create_0.gml
func _create() -> void:
	image_speed = 0.75


# from objects/obj_big_plant_dead/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
