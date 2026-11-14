extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_btn_header_parent/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	effect_hover = 0.0
	anim = 0.0
	alarm[0] = 1.0


# from objects/obj_btn_header_parent/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_btn_header_parent/Mouse_10.gml
func _mouse_10() -> void:
	if visible == true:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_btn_header_parent/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
