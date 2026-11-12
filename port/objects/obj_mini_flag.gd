# from objects/obj_mini_flag（第 7 批移植，已核对）
extends GMObject


# from objects/obj_mini_flag/Create_0.gml
func _create() -> void:
	vspeed = -1.0


# from objects/obj_mini_flag/Step_0.gml
func _step() -> void:
	if y <= (ystart - 22.0):
		vspeed = 0.0
		y = (ystart - 22.0)
