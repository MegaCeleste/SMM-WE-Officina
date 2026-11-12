# from objects/obj_skewer（第 6b 批移植，已核对）
extends "res://objects/obj_solid.gd"

var index: float = 0.0
var posx: float = 0.0  # scr_edit_to_play 写入
var posy: float = 0.0  # scr_edit_to_play 写入
var direct_t: float = 0.0  # scr_edit_to_play 写入
var rotacion: float = 0.0  # scr_edit_to_play 写入


# from objects/obj_skewer/Create_0.gml
func _create() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	image_speed = 0.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				index = 1.0
			else:
				index = 0.0
		1.0:
			if dark == 1.0:
				index = 3.0
			else:
				index = 2.0
		2.0:
			index = 4.0
		3.0:
			index = 5.0
	posx = 0.0
	posy = 0.0
	direct_t = 1.0
	rotacion = 0.0


# from objects/obj_skewer/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0.0, GM.c_white, 0.0)
	GM.draw_sprite_ext(A.spr_skewer_base, index, (x + posx), (y + posy), 1.0, 1.0, rotacion, GM.c_white, 1.0)
