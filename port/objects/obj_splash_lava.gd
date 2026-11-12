extends GMObject


# from objects/obj_splash_lava/Create_0.gml
func _create() -> void:
	match G.apariencia:
		1.0:
			sprite_index = A.spr_SMB3_splash_lava
		3.0:
			sprite_index = A.spr_NSMBU_splash_lava
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.2


# from objects/obj_splash_lava/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
