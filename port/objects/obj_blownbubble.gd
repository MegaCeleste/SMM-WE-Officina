extends GMObject


# from objects/obj_blownbubble/Create_0.gml
func _create() -> void:
	image_alpha = 0.8
	friction = 0.2


# from objects/obj_blownbubble/Step_0.gml
func _step() -> void:
	if speed < 0.1:
		instance_destroy()
