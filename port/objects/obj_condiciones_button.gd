extends GMObject


# from objects/obj_condiciones_button/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_condiciones_button/Mouse_4.gml
func _mouse_4() -> void:
	if sprite_index == A.spr_condiciones_button_up and image_index == 0.0:
		GM.audio_play_sound(A.snd_add_wings, 0.0, false)
		G.condiciones_count += 1.0
		if G.condiciones_count == 3.0:
			image_index = 1.0
		else:
			for inst in GM.with_list(A.obj_condiciones_button):
				inst.image_index = 0.0
	elif sprite_index == A.spr_condiciones_button_down and image_index == 0.0:
		GM.audio_play_sound(A.snd_add_wings, 0.0, false)
		G.condiciones_count -= 1.0
		if G.condiciones_count == 0.0:
			image_index = 1.0
		else:
			for inst in GM.with_list(A.obj_condiciones_button):
				inst.image_index = 0.0
