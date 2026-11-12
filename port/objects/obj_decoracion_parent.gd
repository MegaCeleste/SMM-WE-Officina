# from objects/obj_decoracion_parent（第 7 批移植，已核对）
extends "res://objects/obj_parent_save.gd"

var expand3: float = 0.0
var s_scalex: float = 0.0
var s_scaley: float = 0.0


# from objects/obj_decoracion_parent/Create_0.gml
func _create() -> void:
	super._create()
	expand3 = 1.0
	s_scalex = 0.0
	s_scaley = 0.0


# from objects/obj_decoracion_parent/Step_1.gml
func _step_begin() -> void:
	if expand3 == 1.0:
		s_scalex -= 0.2
		s_scaley -= 0.2
		if s_scalex < 0.8:
			expand3 = 2.0
	elif expand3 == 2.0:
		s_scalex += 0.2
		s_scaley += 0.2
		if s_scalex > 1.0:
			expand3 = 0.0
			s_scalex = 1.0
			s_scaley = 1.0


# from objects/obj_decoracion_parent/Other_0.gml
func _outside_room() -> void:
	instance_destroy()


# from objects/obj_decoracion_parent/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
