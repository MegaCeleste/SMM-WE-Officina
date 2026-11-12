# from objects/obj_bonus_trail（第 5 批移植，已核对）
extends GMObject

var rotate: float = 0.0


# from objects/obj_bonus_trail/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	image_alpha = 0.6
	rotate = 0.0


# from objects/obj_bonus_trail/Step_0.gml
func _step() -> void:
	if image_alpha <= 0.0:
		instance_destroy()
	else:
		image_alpha -= 0.075


# from objects/obj_bonus_trail/Step_2.gml
func _step_end() -> void:
	rotate -= 6.0


# from objects/obj_bonus_trail/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_bonus, 0.0, x, (y - 88.0), 1.0, 1.0, rotate, GM.c_white, image_alpha)
	GM.draw_sprite_ext(A.spr_bonus, 1.0, x, y, 1.0, 1.0, rotate, GM.c_white, image_alpha)
	GM.draw_sprite_ext(A.spr_bonus, 2.0, x, (y + 88.0), 1.0, 1.0, rotate, GM.c_white, image_alpha)
