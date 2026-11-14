extends GMObject

var can_anim: float = 0.0
var can_anim2: float = 0.0
var anim: float = 0.0


# from objects/obj_ventana_mario/Create_0.gml
func _create() -> void:
	if G.apariencia != 2.0:
		sprite_index = A.spr_windows_mario
	GM.audio_play_sound(A.snd_open_windows, 0.0, false)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			inst.active = 0.0
	G.select_resource = A.obj_resource_empty
	for inst in GM.with_list(A.obj_editormanager):
		inst.expand_open = 2.0
	can_anim = 1.0
	can_anim2 = 0.0
	anim = 0.8


# from objects/obj_ventana_mario/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_window_mario_button):
		for inst in GM.with_list(A.obj_window_mario_button):
			inst.instance_destroy()
	for inst in GM.with_list(A.obj_editormanager):
		inst.alarm[0] = 10.0


# from objects/obj_ventana_mario/Step_1.gml
func _step_begin() -> void:
	if can_anim == 1.0:
		if anim < 1.0:
			anim += 0.08
		else:
			event_user(int(G.apariencia))
			anim = 1.0
			can_anim = 0.0
		image_xscale = anim
		image_yscale = anim
	if can_anim2 == 1.0:
		if GM.instance_exists(A.obj_window_mario_button):
			for inst in GM.with_list(A.obj_window_mario_button):
				inst.instance_destroy()
		if anim > 0.8:
			anim -= 0.1
		else:
			instance_destroy()
		image_xscale = anim
		image_yscale = anim


# from objects/obj_ventana_mario/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 1.0
		inst.type_powerup = 1.0
		inst.s_index = 96.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 2.0
		inst.type_powerup = 2.0
		inst.s_index = 61.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -21.0
		inst.s_index = 130.0
		if G.star_flash == 1.0:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -77.0
		inst.type_powerup = 3.0
		inst.s_index = 113.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -78.0
		inst.type_powerup = 4.0
		inst.s_index = 31.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -50.0
		inst.type_powerup = 6.0
		inst.s_index = 62.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -85.0
		inst.type_powerup = 7.0
		inst.s_index = 184.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0


# from objects/obj_ventana_mario/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 1.0
		inst.type_powerup = 1.0
		inst.s_index = 96.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 2.0
		inst.type_powerup = 2.0
		inst.s_index = 61.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -21.0
		inst.s_index = 130.0
		if G.star_flash == 1.0:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -39.0
		inst.type_powerup = 3.0
		inst.s_index = 113.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -29.0
		inst.type_powerup = 4.0
		inst.s_index = 184.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -46.0
		inst.type_powerup = 5.0
		inst.s_index = 31.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0


# from objects/obj_ventana_mario/Other_12.gml
func _user_2() -> void:
	for inst in GM.with_list(GM.instance_create((x - 142.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = 1.0
		inst.type_powerup = 1.0
		inst.s_index = 96.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = 2.0
		inst.type_powerup = 2.0
		inst.s_index = 61.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -21.0
		inst.s_index = 130.0
		if G.star_flash == 1.0:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = 3.0
		inst.type_powerup = 3.0
		inst.s_index = 113.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -82.0
		inst.type_powerup = 5.0
		inst.s_index = 184.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0


# from objects/obj_ventana_mario/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 1.0
		inst.type_powerup = 1.0
		inst.s_index = 96.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = 2.0
		inst.type_powerup = 2.0
		inst.s_index = 61.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -21.0
		inst.s_index = 130.0
		if G.star_flash == 1.0:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 63.0), A.obj_window_mario_button)):
		inst.powerup = -30.0
		inst.type_powerup = 3.0
		inst.s_index = 113.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -43.0
		inst.type_powerup = 4.0
		inst.s_index = 184.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_mario_button)):
		inst.powerup = -38.0
		inst.type_powerup = 5.0
		inst.s_index = 31.0
		if G.powerup == inst.powerup:
			inst.s_contorno = 1.0
