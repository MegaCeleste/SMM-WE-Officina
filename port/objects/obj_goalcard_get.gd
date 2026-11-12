# from objects/obj_goalcard_get（第 7 批移植，已核对）
extends GMObject


# from objects/obj_goalcard_get/Create_0.gml
func _create() -> void:
	image_speed = 0.3


# from objects/obj_goalcard_get/Other_40.gml
func _outside_view_0() -> void:
	instance_destroy()
