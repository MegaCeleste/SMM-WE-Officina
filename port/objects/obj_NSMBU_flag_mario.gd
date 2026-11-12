# from objects/obj_NSMBU_flag_mario（第 7 批移植，已核对）
extends GMObject

var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var limite: float = 0.0
var limite_final: float = 0.0


# from objects/obj_NSMBU_flag_mario/Create_0.gml
func _create() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_flag
		inst.image_speed = 0.5
	ready_v = 0.0
	limite = y
	limite_final = (y - 25.0)
	vspeed = -1.5
	alarm[1] = 1.0


# from objects/obj_NSMBU_flag_mario/Step_0.gml
func _step() -> void:
	if y <= limite_final:
		vspeed = 0.0
		y = limite_final
		ready_v = 1.0


# from objects/obj_NSMBU_flag_mario/Alarm_0.gml
func _alarm_0() -> void:
	vspeed = 1.5


# from objects/obj_NSMBU_flag_mario/Alarm_1.gml
func _alarm_1() -> void:
	var limite_cal: float
	limite_cal = (limite - 25.0)
	if GM.instance_exists(A.obj_flagpole):
		if limite_cal <= (GM.instance_find(A.obj_flagpole, 0).y + 17.0):
			limite_final = (GM.instance_find(A.obj_flagpole, 0).y + 17.0)
		else:
			limite_final = limite_cal


# from objects/obj_NSMBU_flag_mario/Collision_obj_flagpole.gml
func _collision_obj_flagpole(other: GMObject) -> void:
	if y <= limite_final:
		vspeed = 0.0
		y = limite_final
		ready_v = 1.0
