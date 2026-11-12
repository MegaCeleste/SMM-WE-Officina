extends GMObject


# from objects/obj_splash_agua/Create_0.gml
func _create() -> void:
	match G.apariencia:
		1.0:
			sprite_index = A.spr_SMB3_splash
		3.0:
			sprite_index = A.spr_NSMBU_splash_agua
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.2


# from objects/obj_splash_agua/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
