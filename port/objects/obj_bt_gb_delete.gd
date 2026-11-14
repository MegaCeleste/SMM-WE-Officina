extends GMObject

var press: float = 0.0
var anim: float = 0.0
var effect_hover: float = 0.0


# from objects/obj_bt_gb_delete/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	press = 0.0
	anim = 0.0
	alarm[0] = 15.0
	effect_hover = 0.0


# from objects/obj_bt_gb_delete/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_bt_gb_delete/Alarm_1.gml
func _alarm_1() -> void:
	GM.file_delete((G.directorio + G.levelguardabot))
	G.levelguardabot = ""
	GM.room_restart()


# from objects/obj_bt_gb_delete/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_bt_gb_delete/Mouse_4.gml
func _mouse_4() -> void:
	if G.levelguardabot != "" and press == 1.0 and image_index == 0.0 and GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		GM.audio_play_sound(A.snd_delete_level, 0.0, false)
		image_index = 1.0
		alarm[1] = 6.0


# from objects/obj_bt_gb_delete/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_bt_gb_delete/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
