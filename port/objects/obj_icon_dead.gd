# from objects/obj_icon_dead（第 5 批移植，已核对）
extends GMObject


# from objects/obj_icon_dead/Create_0.gml
func _create() -> void:
	image_speed = 0.3


# from objects/obj_icon_dead/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 6.0
