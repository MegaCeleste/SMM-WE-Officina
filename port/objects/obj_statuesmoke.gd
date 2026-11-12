extends GMObject


# from objects/obj_statuesmoke/Create_0.gml
func _create() -> void:
	image_speed = 0.2


# from objects/obj_statuesmoke/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
