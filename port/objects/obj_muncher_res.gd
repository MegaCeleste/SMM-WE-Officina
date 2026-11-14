extends "res://objects/obj_parent_resource.gd"


# from objects/obj_muncher_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = -4.0


# from objects/obj_muncher_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
			sprite_index = A.spr_muncher_night_res
		else:
			sprite_index = A.spr_muncher_res
		image_index = G.apariencia


# from objects/obj_muncher_res/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		if (place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_resource) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, self)) and unlocked == 0.0) or place_meeting(x, y, A.obj_arrow_lock):
			drop_lock = 1.0
		else:
			drop_lock = 0.0
		depth = -19.0
		x_draw = (GM.mouse_x + xx)
		y_draw = (GM.mouse_y + yy)
		x = (GM.mouse_x + xx)
		y = (GM.mouse_y + yy)
		move_snap(16.0, 16.0)
		if play_sound == 0.0 and (x != x_start or y != y_start):
			GM.audio_play_sound(A.snd_drag, 0.0, false)
			play_sound = 1.0
		if x != prev_x or y != prev_y:
			GM.audio_stop_sound(A.snd_move_object)
			GM.audio_play_sound(A.snd_move_object, 0.0, false)
			prev_x = x
			prev_y = y
			if GM.instance_exists(A.obj_ventana):
				for inst in GM.with_list(A.obj_ventana):
					inst.can_anim2 = 1.0
		if ventana > 0.0 and x == x_start and y == y_start:
			ventana += 0.5
			if ventana >= 14.0:
				_user_0()
				ventana = 0.0
		else:
			ventana = 0.0
		G.editor_lock = 1.0
		alarm[0] = 1.0
	else:
		if drop_lock == 1.0:
			GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
			x = x_start
			y = y_start
		elif x != x_start or y != y_start:
			GM.audio_play_sound(A.snd_mario_add, 0.0, false)
		move_snap(16.0, 16.0)
		drop_lock = 0.0
		ventana = 0.0
		depth = laller
		play_sound = 0.0
		x_draw = x
		y_draw = y
		expand3 = 1.0
		x_start = x
		y_start = y
		G.editor_lock = 0.0
		G.resource_block = 0.0


# from objects/obj_muncher_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 0.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_muncher_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	GM.instance_create((x + 16.0), y, A.obj_muncher_b_res)
	instance_destroy()
