# 第 7 批移植，已核对。
extends "res://objects/obj_climb.gd"

var sprite: int = 0  ## sprite 编号
var index: float = 0.0
var size_y: float = 0.0
var v: float = 0.0


# from objects/obj_vine_green/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite = A.spr_SMB_vine_green
			sprite_index = A.spr_SMB_vine_green
		1.0:
			sprite = A.spr_SMB3_vine_green
			sprite_index = A.spr_SMB3_vine_green
		2.0:
			sprite = A.spr_vine_green
			sprite_index = A.spr_vine_green
		3.0:
			sprite = A.spr_NSMBU_vine_green
			sprite_index = A.spr_NSMBU_vine_green
	mask_index = A.spr_square
	index = 0.0
	size_y = 3.0
	image_speed = 0.0


# from objects/obj_vine_green/Draw_0.gml
func _gm_draw() -> void:
	v = 0.0
	while v < size_y:
		if v == 0.0:
			if place_meeting(x, (y - 16.0), A.obj_modelsolid) and (not place_meeting(x, y, A.obj_modelsolid)):
				index = 1.0
			else:
				index = 0.0
		elif v == (size_y - 1.0):
			if place_meeting(x, (y + 16.0), A.obj_modelsolid) and (not place_meeting(x, y, A.obj_modelsolid)):
				index = 1.0
			else:
				index = 2.0
		else:
			index = 1.0
		GM.draw_sprite(sprite, index, x, (y + (v * 16.0)))
		v += 1.0
