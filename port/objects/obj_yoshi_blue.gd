# 第 4 批移植，已核对。
extends "res://objects/obj_yoshi2.gd"


# from objects/obj_yoshi_blue/Create_0.gml
func _create() -> void:
	super._create()
	color = 2.0
	s_yoshi_jump = A.spr_yoshi_jump_blue
	s_yoshi_swallow = A.spr_yoshi_swallow_blue
	s_yoshi_lick = A.spr_yoshi_lick_blue
	s_yoshi_fm_wait = A.spr_yoshi_fm_wait_blue
	s_yoshi_wait = A.spr_yoshi_wait_blue
	s_yoshi_fm = A.spr_yoshi_fm_blue
	s_yoshi = A.spr_yoshi_blue
	s_yoshi_fm_jump = A.spr_yoshi_fm_jump_blue
	sprite_wings = A.spr_wings
