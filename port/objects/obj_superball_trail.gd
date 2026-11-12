# from objects/obj_superball_trail（第 5 批移植，已核对）
extends GMObject


# from objects/obj_superball_trail/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	image_alpha = 0.9


# from objects/obj_superball_trail/Step_0.gml
func _step() -> void:
	if image_alpha <= 0.0:
		instance_destroy()
	else:
		image_alpha -= 0.04
