extends GMObject


# from objects/obj_effect_touch/Create_0.gml
func _create() -> void:
	image_speed = 0.45


# from objects/obj_effect_touch/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
