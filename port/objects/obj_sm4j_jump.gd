# 第 4 批移植，已核对。
extends GMObject


# from objects/obj_sm4j_jump/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_sm4j_jump/Draw_0.gml
func _gm_draw() -> void:
	return


# from objects/obj_sm4j_jump/Mouse_0.gml
func _mouse_0() -> void:
	GM.keyboard_key_press(int(G.saltar))


# from objects/obj_sm4j_jump/Mouse_7.gml
func _mouse_7() -> void:
	GM.keyboard_key_release(int(G.saltar))
