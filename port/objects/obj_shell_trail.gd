# from objects/obj_shell_trail（第 5 批移植，已核对）
extends GMObject

var value: float = 0.0


# from objects/obj_shell_trail/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	image_alpha = 0.7
	value = 0.0


# from objects/obj_shell_trail/Step_0.gml
func _step() -> void:
	if image_alpha <= 0.0:
		instance_destroy()
	else:
		image_alpha -= 0.075


# from objects/obj_shell_trail/Draw_0.gml
func _gm_draw() -> void:
	if (value == 1.0) and GM.instance_exists(A.obj_shell_held):
		if sprite_height < 20.0:
			if GM.instance_find(A.obj_shell_held, 0).flip == 0.0:
				GM.draw_sprite_ext(sprite_index, GM.instance_find(A.obj_shell_held, 0).image_index, GM.gm_round(x), y, GM.instance_find(A.obj_shell_held, 0).direct, 1.0, 0.0, GM.c_white, image_alpha)
			else:
				GM.draw_sprite_ext(sprite_index, GM.instance_find(A.obj_shell_held, 0).image_index, GM.gm_round(x), (y + 17.0), GM.instance_find(A.obj_shell_held, 0).direct, -1.0, 0.0, GM.c_white, image_alpha)
		elif GM.instance_find(A.obj_shell_held, 0).flip == 0.0:
			GM.draw_sprite_ext(sprite_index, GM.instance_find(A.obj_shell_held, 0).image_index, GM.gm_round(x), y, GM.instance_find(A.obj_shell_held, 0).direct, 1.0, 0.0, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, GM.instance_find(A.obj_shell_held, 0).image_index, GM.gm_round(x), y, GM.instance_find(A.obj_shell_held, 0).direct, -1.0, 0.0, GM.c_white, image_alpha)
	elif (value == 2.0) and GM.instance_exists(A.obj_bowserjr_shell):
		GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
