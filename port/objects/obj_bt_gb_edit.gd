extends "res://objects/obj_bt_gb_play.gd"


# from objects/obj_bt_gb_edit/Create_0.gml
func _create() -> void:
	super._create()
	icon = 1.0
	text = Scr.scr_language(self, 50.0)


# from objects/obj_bt_gb_edit/Step_2.gml
func _step_end() -> void:
	if GM.instance_exists(A.obj_gb_level) and (not GM.veq(GM.instance_find(A.obj_gb_level, 0).get("user"), G.my1)):
		image_index = 2.0
		c_button = 8421504.0


# from objects/obj_bt_gb_edit/Alarm_1.gml
func _alarm_1() -> void:
	G.last_level = G.levelguardabot
	GM.room_goto(A.rm_editor)


# from objects/obj_bt_gb_edit/Mouse_4.gml
func _mouse_4() -> void:
	if press == 1.0 and image_index == 0.0 and GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		image_index = 1.0
		c_button = GM.make_colour_rgb(253.0, 203.0, 0.0)
		GM.audio_stop_sound(A.snd_guardabot)
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		alarm[1] = 6.0


# from objects/obj_bt_gb_edit/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0 and image_index == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0
