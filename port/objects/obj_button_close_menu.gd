extends "res://objects/obj_button_close.gd"


# from objects/obj_button_close_menu/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_button_close_menu/Mouse_4.gml
func _mouse_4() -> void:
	if (not GM.instance_exists(A.obj_settings_panel)) and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).active_menu == 0.0:
		GM.audio_play_sound(A.snd_cerrar_menu, 0.0, false)
		var _with_target2 = A.obj_edit_menu
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			inst.instance_destroy()
		GM.other = _other1
		if GM.instance_exists(A.obj_editormanager):
			for _obj_write3 in GM.with_list(A.obj_editormanager):
				_obj_write3.expand_open = 0.0
		if GM.instance_exists(A.obj_menu_editor_ext):
			var _with_target5 = A.obj_menu_editor_ext
			var _other4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target5):
				inst.alarm[0] = 15.0
			GM.other = _other4
		if GM.instance_exists(A.obj_guardabot):
			GM.audio_resume_sound(A.snd_guardabot)
			var _with_target7 = A.obj_guardabot
			var _other6: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target7):
				inst.can_anim = 1.0
			GM.other = _other6
