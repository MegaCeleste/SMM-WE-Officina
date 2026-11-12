# from objects/obj_ground_slope（第 5 批移植，已核对）
extends "res://objects/obj_ground.gd"


# from objects/obj_ground_slope/Other_15.gml
func _user_5() -> void:
	# UNSURE: 原版 image_index = scr_auto_tile_slope()，而该脚本是空函数（返回 undefined）。
	# 移植版脚本返回 void，无法赋值；这里只调用不赋值（image_index 保持不变）。
	# 原版 GMS 把 undefined 赋给 image_index 后的实际值未知（可能变 0 或出错）。
	Scr.scr_auto_tile_slope(self)


# from objects/obj_ground_slope/Draw_0.gml
func _gm_draw() -> void:
	if image_index == 44.0:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, 0.75)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, s_scalex, s_scaley, rotacion, GM.c_white, m_alpha)
