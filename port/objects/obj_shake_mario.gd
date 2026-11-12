# from objects/obj_shake_mario（第 6e 批移植，已核对）
extends GMObject


# from objects/obj_shake_mario/Create_0.gml
func _create() -> void:
	image_speed = 0.25


# from objects/obj_shake_mario/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		x = GM.instance_find(A.obj_mario, 0).x
		y = (GM.instance_find(A.obj_mario, 0).y + 5.0)
