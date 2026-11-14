extends "res://objects/obj_button_close.gd"


# from objects/obj_button_notification_cancelar/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_button_notification_cancelar/Mouse_4.gml
func _mouse_4() -> void:
	if (not GM.instance_exists(A.obj_toast)) and (not GM.instance_exists(A.obj_load_image)):
		if GM.instance_exists(A.obj_window_alert):
			GM.audio_play_sound(A.snd_item_select, 0.0, false)
			var _with_target2 = A.obj_window_alert
			var _other1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target2):
				inst.instance_destroy()
			GM.other = _other1
			var _with_target4 = A.obj_persistent
			var _other3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target4):
				inst.alarm[8] = 2.0
			GM.other = _other3
