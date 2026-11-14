extends GMObject


# from objects/obj_panelparent/Step_1.gml
func _step_begin() -> void:
	if image_speed < 0.0 and image_index <= 0.0:
		if (not GM.instance_exists(A.obj_panel_save_load)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_autoavance)) and (not GM.instance_exists(A.obj_time)) and (not GM.instance_exists(A.obj_condiciones)):
			for _obj_write1 in GM.with_list(A.obj_editormanager):
				_obj_write1.expand_open = 0.0
		instance_destroy()
