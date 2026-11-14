extends "res://objects/obj_enemyparent.gd"


func _gm_draw() -> void:
	# Deliberately screen-anchored; must not inherit the rigid-draw whitelist.
	GM.draw_rectangle(GM.camera_get_view_x(0), GM.camera_get_view_y(0), 10.0, 10.0, false)
