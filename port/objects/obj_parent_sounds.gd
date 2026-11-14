extends "res://objects/obj_parent_resource.gd"


# from objects/obj_parent_sounds/Create_0.gml
func _create() -> void:
	super._create()
	unlocked = 1.0


# from objects/obj_parent_sounds/Step_2.gml
func _step_end() -> void:
	visible = GM.instance_find(A.obj_levelmanager, 0).editor_sonidos > 0.5


# from objects/obj_parent_sounds/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		if (place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, A.obj_parent_sounds) and (not place_meeting(GM.instance_find(A.obj_creation_preview, 0).x, GM.instance_find(A.obj_creation_preview, 0).y, self))) or place_meeting(x, y, A.obj_arrow_lock):
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


# from objects/obj_parent_sounds/Collision_obj_parent_resource.gml
func _collision_obj_parent_resource(other: GMObject) -> void:
	return


# from objects/obj_parent_sounds/Mouse_0.gml
func _mouse_0() -> void:
	if G.resource_create == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 2.0:
				_user_2()


# from objects/obj_parent_sounds/Mouse_1.gml
func _mouse_1() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.os_type != GM.os_android and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
			if G.cursor == 2.0 and G.editor_activity == 1.0:
				_user_2()


# from objects/obj_parent_sounds/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.resource_create == 0.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and object_index != A.obj_resource_empty and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0 and GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).dont_move == 0.0 and (not GM.instance_exists(A.obj_edit_menu)):
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				if GM.instance_find(A.obj_parent_resource, 0).alarm[0] == -1.0 and alarm[0] == -1.0:
					GM.audio_play_sound(A.snd_ground_bomb, 0.0, false)
					xx = (x - GM.mouse_x)
					yy = (y - GM.mouse_y)
					for inst in GM.with_list(A.obj_creation_preview):
						inst.xx = self.xx
						inst.yy = self.yy
					x_start = x
					y_start = y
					G.resource_block = 1.0
					drag = 1.0
					for inst in GM.with_list(A.obj_cursor):
						inst.move = 1.0
					ventana = 1.0
					G.cursor = 1.0
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_cursor):
						inst.event_user(0)
					GM.other = _o
					if not GM.instance_exists(A.obj_effect_touch):
						GM.instance_create(GM.mouse_x, GM.mouse_y, A.obj_effect_touch)
					G.resource_move = object_index
					alarm[0] = 1.0


# from objects/obj_parent_sounds/Mouse_10.gml
func _mouse_10() -> void:
	if drag == 0.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0:
		mouse_up = 1.0
