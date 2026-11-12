# from objects/obj_arrow（第 7 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var rotacion: float = 0.0


# from objects/obj_arrow/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	rotacion = 0.0


# from objects/obj_arrow/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
