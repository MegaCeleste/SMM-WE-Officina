extends "res://objects/obj_button_parent.gd"

var canpress: float = 0.0


# from objects/obj_button_settings_close2/Create_0.gml
func _create() -> void:
	super._create()
	canpress = 0.0
	text = Scr.scr_language(self, 28.0)
	alarm[2] = 15.0


# from objects/obj_button_settings_close2/Alarm_2.gml
func _alarm_2() -> void:
	canpress = 1.0


# from objects/obj_button_settings_close2/Mouse_4.gml
func _mouse_4() -> void:
	if visible == true:
		GM.audio_stop_sound(A.snd_aceptar)
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		if GM.instance_exists(A.obj_settings_panel):
			G.keymod = 0.0
			GM.instance_destroy(A.obj_settings_controls)
			var previous_other: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_settings_panel):
				inst.event_user(0)
			GM.other = previous_other
		if GM.instance_exists(A.obj_gb_button):
			for inst in GM.with_list(A.obj_gb_button):
				inst.alarm[0] = 15.0
		if GM.instance_exists(A.obj_menu_editor_ext):
			for inst in GM.with_list(A.obj_menu_editor_ext):
				inst.alarm[0] = 15.0
		if GM.instance_exists(A.obj_guardabot):
			for inst in GM.with_list(A.obj_guardabot):
				inst.can_anim = 1.0
		var previous_other: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(7)
		GM.other = previous_other
