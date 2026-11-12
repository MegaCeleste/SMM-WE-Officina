# from objects/obj_sparkletrail（第 5 批移植，已核对）
extends GMObject


# from objects/obj_sparkletrail/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_sparkletrail
		image_speed = 0.3
	else:
		image_speed = 0.25


# from objects/obj_sparkletrail/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
