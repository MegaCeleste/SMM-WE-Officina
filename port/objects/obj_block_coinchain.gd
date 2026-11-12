# from objects/obj_block_coinchain（第 5 批移植，已核对）
extends "res://objects/obj_blockparent.gd"

var mysolid = null
var w_wings: float = 0.0


# from objects/obj_block_coinchain/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	ready_v = 0.0
	mysolid = GM.instance_create(x, y, A.obj_solid)
	wings = 0.0
	w_wings = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	expand = 0.0
	expand2 = 0.0
	expand3 = 0.0


# from objects/obj_block_coinchain/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	GM.instance_create(x, y, A.obj_coinchain)
	sprite_index = A.spr_qblock_empty


# from objects/obj_block_coinchain/Other_11.gml
func _user_1() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 4.0
	event_user(0)  # 本类及父类链没有 _user_0，走通用 event_user（无此事件则空操作）
