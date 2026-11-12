extends GMObject


# from objects/obj_spinthump/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_spinthump
		image_speed = 0.5
	else:
		image_speed = 0.35


# from objects/obj_spinthump/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
