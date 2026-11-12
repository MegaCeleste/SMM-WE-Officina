extends "res://objects/obj_icicle.gd"
# ORIG-BUG: obj_icicle2 / obj_mini_icicle2 没有 Alarm_1，继承 obj_icicle 的 Alarm_1，掉出屏幕后重生出来的是 obj_icicle（不是 icicle2 / mini_icicle2），原版如此，照搬


# from objects/obj_icicle2/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	crecer = 0.0
	rotacion = 0.0
	rot = 0.0
	up = 0.0
	caer = 0.0
	delito = 0.0
	alarm[2] = 120.0


# from objects/obj_icicle2/Step_0.gml
func _step() -> void:
	return
