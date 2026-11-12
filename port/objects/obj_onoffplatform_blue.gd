# from objects/obj_onoffplatform_blue（第 5 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

# PORT: GML 用 obj_lighting（object 编号）当“没有 solid”的哨兵值，实例用 GMObject，所以不带类型；比较走 GM.veq
var mysolid = null


# from objects/obj_onoffplatform_blue/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_onoffplatform_blue
		1.0:
			sprite_index = A.spr_SMB3_onoffplatform_blue
		2.0:
			sprite_index = A.spr_onoffplatform_blue
		3.0:
			sprite_index = A.spr_NSMBU_onoffplatform_blue
	image_speed = 0.0
	image_index = 0.0
	mysolid = A.obj_lighting


# from objects/obj_onoffplatform_blue/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(mysolid, A.obj_lighting):
		for inst in GM.with_list(mysolid):
			GM.instance_destroy(inst)


# from objects/obj_onoffplatform_blue/Step_0.gml
func _step() -> void:
	if G.onoffblock == 1.0:
		if GM.veq(mysolid, A.obj_lighting):
			mysolid = GM.instance_create(x, y, A.obj_enabledsolid)
		image_index = 1.0
	else:
		if not GM.veq(mysolid, A.obj_lighting) and GM.instance_exists(mysolid):
			for inst in GM.with_list(mysolid):
				GM.instance_destroy(inst)
			mysolid = A.obj_lighting
		image_index = 0.0
