extends GMObject


# from objects/obj_change_view/Step_2.gml
func _step_end() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 554.0)
	y = GM.camera_get_view_y(GM.view_get_camera(0))


# from objects/obj_change_view/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_change_view, G.idioma, (GM.camera_get_view_x(GM.view_get_camera(0)) + 554.0), GM.camera_get_view_y(GM.view_get_camera(0)))


# from objects/obj_change_view/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_exists(A.obj_editormanager):
		for inst in GM.with_list(A.obj_editormanager):
			inst.zoom = 3.0
		for inst in GM.with_list(A.obj_cursor):
			if inst.cont_panel_right == 3.0:
				inst.cont_panel_right = 2.0
			if inst.cont_panel_left == 3.0:
				inst.cont_panel_left = 2.0
			if inst.cont_panel_top == 3.0:
				inst.cont_panel_top = 2.0
			inst.cont_panel_creator = 2.0
		instance_destroy()
