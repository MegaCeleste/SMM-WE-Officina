extends "res://objects/obj_parent_resource.gd"


# from objects/obj_grinder_res/Create_0.gml
func _create() -> void:
	super._create()
	image_index = G.apariencia
	grid_selected = A.spr_grid_selected_48x48


# from objects/obj_grinder_res/Step_2.gml
func _step_end() -> void:
	image_index = G.apariencia


# from objects/obj_grinder_res/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		if (place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_grinder_res) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, self)) and unlocked == 0.0) or place_meeting(x, y, A.obj_arrow_lock):
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
				event_user(0)
				ventana = 0.0
		else:
			ventana = 0.0
		G.editor_lock = 1.0
		alarm[0] = 1.0
	else:
		image_speed = 0.0
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
		if object_index != A.obj_tuberia_res:
			expand3 = 1.0
		x_start = x
		y_start = y
		G.editor_lock = 0.0
		G.resource_block = 0.0
		if x >= GM.room_width or x < 0.0 or y >= GM.room_height or y < 0.0:
			instance_destroy()
		if object_index == A.obj_tuberia_res and warp > 0.0:
			event_user(5)
