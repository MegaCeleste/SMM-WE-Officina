extends GMObject


# from objects/obj_button_close/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_button_close/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		GM.audio_play_sound(A.snd_close_palette2, 0.0, false)
		var _with_target2 = A.obj_cursor
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			if inst.cont_panel_right == 3.0:
				inst.cont_panel_right = 2.0
			if inst.cont_panel_left == 3.0:
				inst.cont_panel_left = 2.0
			if inst.cont_panel_top == 3.0:
				inst.cont_panel_top = 2.0
			inst.cont_panel_creator = 2.0
		GM.other = _other1
		for _obj_write3 in GM.with_list(A.obj_expand):
			_obj_write3.visible = true
		var _with_target6 = A.obj_panel_expand
		var _other5: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target6):
			inst.instance_destroy()
		GM.other = _other5
		var _with_target8 = A.obj_editormanager
		var _other7: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target8):
			inst.alarm[0] = 15.0
		GM.other = _other7
