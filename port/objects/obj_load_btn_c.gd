extends "res://objects/obj_button_close.gd"

var canpress: float = 0.0


# from objects/obj_load_btn_c/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	canpress = 0.0
	alarm[2] = 15.0


# from objects/obj_load_btn_c/Alarm_2.gml
func _alarm_2() -> void:
	canpress = 1.0


# from objects/obj_load_btn_c/Mouse_4.gml
func _mouse_4() -> void:
	if canpress == 1.0:
		GM.audio_play_sound(A.snd_item_select, 0.0, false)
		var _with_target2 = A.obj_alert_load
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			inst.instance_destroy()
		GM.other = _other1
