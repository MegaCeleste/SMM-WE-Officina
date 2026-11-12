# 第 4 批移植，已核对。
extends "res://objects/obj_kuriboshoe.gd"


# from objects/obj_kuriboshoe2/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_kuriboshoe2
	G.yoshi = 2.0
	image_speed = 0.0
	offset = 0.0
	offsetnext = 0.0
	alarm[0] = 2.0
	stateprev = 0.0
	flying = 0.0
	m_sprite = 0.0
	m_subimagen = 0.0
	gran_golpe = 0.0
	golpe_count = 0.0
	count_audio = 0.0
