extends GMObject

# from objects/obj_login_control/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0

# from objects/obj_login_control/Draw_0.gml
func _gm_draw() -> void:
	var vx: float = GM.camera_get_view_x(GM.view_get_camera(0))
	var vy: float = GM.camera_get_view_y(GM.view_get_camera(0))
	GM.draw_sprite(A.spr_letters_super, 1.0, vx + 96.0, vy + 36.0)
	GM.draw_sprite(A.spr_letters_white, 0.0, vx + 96.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 1.0, vx + 119.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 2.0, vx + 138.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 3.0, vx + 157.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 4.0, vx + 165.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 4.0, vx + 165.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 0.0, vx + 195.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 1.0, vx + 218.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 5.0, vx + 237.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 6.0, vx + 256.0, vy + 57.0)
	GM.draw_sprite(A.spr_letters_white, 2.0, vx + 273.0, vy + 57.0)
	# ORIG-BUG: the x coordinate also uses view y.
	GM.draw_sprite(A.spr_we, 1.0, vy + 214.0, vy + 90.0)
