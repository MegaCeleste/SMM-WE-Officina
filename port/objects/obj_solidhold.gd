# 第 7 批移植，已核对。
extends "res://objects/obj_enabledsolid.gd"


# from objects/obj_solidhold/Step_0.gml
func _step() -> void:
	var col_mario_left
	var col_mario_right
	col_mario_left = collision_rectangle(bbox_left, bbox_top, (bbox_left + 3.0), bbox_bottom, A.obj_mario, false, false)
	col_mario_right = collision_rectangle((bbox_right - 3.0), bbox_top, bbox_right, bbox_bottom, A.obj_mario, false, false)
	if GM.instance_exists(A.obj_mario) and col_mario_left != null and GM.instance_find(A.obj_mario, 0).hspeed > 0.0:
		x -= 1.0
	elif GM.instance_exists(A.obj_mario) and col_mario_right != null and GM.instance_find(A.obj_mario, 0).hspeed < 0.0:
		x += 1.0
