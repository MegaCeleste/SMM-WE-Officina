extends GMObject


# from objects/obj_detroy_enemy/Create_0.gml
func _create() -> void:
	image_speed = 0.3


# from objects/obj_detroy_enemy/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
