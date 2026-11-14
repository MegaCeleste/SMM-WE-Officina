extends GMObject

var v_speed: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_button_speed_water/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	v_speed = 0.2
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_button_speed_water/Step_2.gml
func _step_end() -> void:
	if G.water_speed == v_speed:
		sprite_index = A.spr_button_speed_water_selected


# from objects/obj_button_speed_water/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_button_speed_water/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_play_sound(A.snd_miniwindow_seleccionar, 0.0, false)
	G.water_speed = v_speed
	for inst in GM.with_list(A.obj_ventana_water):
		inst.can_anim2 = 1.0


# from objects/obj_button_speed_water/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_miniwindow_desplazarse)
		GM.audio_play_sound(A.snd_miniwindow_desplazarse, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_speed_water/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
