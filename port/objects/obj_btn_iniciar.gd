extends "res://objects/obj_button_parent.gd"


# from objects/obj_btn_iniciar/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, effect_hover, x, y, 1.0, 1.0, 0.0, GM.c_white, alpha)


# from objects/obj_btn_iniciar/Mouse_4.gml
func _mouse_4() -> void:
	# Online sign-in is an offline stub (port-plan §0).
	pass
