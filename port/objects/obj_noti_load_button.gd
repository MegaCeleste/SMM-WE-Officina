extends "res://objects/obj_button_parent.gd"

var canpress: float = 0.0


# from objects/obj_noti_load_button/Create_0.gml
func _create() -> void:
	super._create()
	canpress = 0.0
	alarm[0] = 15.0


# from objects/obj_noti_load_button/Alarm_0.gml
func _alarm_0() -> void:
	canpress = 1.0


# from objects/obj_noti_load_button/Mouse_4.gml
func _mouse_4() -> void:
	if canpress == 1.0:
		if GM.instance_exists(A.obj_creator_jugar_editar):
			GM.audio_stop_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
		G.press_load = 1.0
		GM.room_goto(A.rm_guardabot)
