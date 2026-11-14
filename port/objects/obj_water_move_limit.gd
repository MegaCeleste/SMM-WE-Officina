extends GMObject

var prev_y: float = 0.0
var drag: float = 0.0
var can_cont: float = 0.0
var cont: float = 0.0


# from objects/obj_water_move_limit/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	prev_y = y
	drag = 0.0
	can_cont = 0.0
	cont = 0.0


# from objects/obj_water_move_limit/Step_2.gml
func _step_end() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 222.0)


# from objects/obj_water_move_limit/Alarm_0.gml
func _alarm_0() -> void:
	if drag == 1.0:
		image_index = 1.0
		if y > GM.instance_find(A.obj_water_move, 0).y:
			drag = 0.0
			G.resource_block = 0.0
			G.cursor = 0.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_cursor):
				inst.event_user(0)
			GM.other = _o
			y = GM.instance_find(A.obj_water_move, 0).y
		elif y < 32.0:
			drag = 0.0
			G.resource_block = 0.0
			G.cursor = 0.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_cursor):
				inst.event_user(0)
			GM.other = _o
			y = 32.0
		else:
			y = (floorf((GM.mouse_y / 16.0)) * 16.0)
		if can_cont == 1.0:
			cont += 0.5
			if GM.instance_exists(A.obj_ventana_water):
				for inst in GM.with_list(A.obj_ventana_water):
					inst.can_anim2 = 1.0
				can_cont = 0.0
				cont = 0.0
			elif cont >= 15.0:
				GM.instance_create(x, y, A.obj_ventana_water)
				can_cont = 0.0
				cont = 0.0
		if y != prev_y:
			GM.audio_stop_sound(A.snd_rieles)
			GM.audio_play_sound(A.snd_rieles, 0.0, false)
			prev_y = y
			can_cont = 0.0
			cont = 0.0
			if GM.instance_exists(A.obj_ventana_water):
				for inst in GM.with_list(A.obj_ventana_water):
					inst.can_anim2 = 1.0
		alarm[0] = 1.0
	else:
		GM.audio_play_sound(A.snd_colocar_objectos, 0.0, false)
		image_index = 0.0
		for inst in GM.with_list(A.obj_cursor):
			inst.move = 0.0
		if GM.instance_exists(A.obj_card_bout):
			for inst in GM.with_list(A.obj_card_bout):
				inst.pos_y_limit = self.y
		if y >= GM.room_height:
			y = (GM.room_height - 16.0)
		elif y < 0.0:
			y = 0.0
		G.editor_lock = 0.0
		G.resource_block = 0.0


# from objects/obj_water_move_limit/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_water_move):
		if y != GM.instance_find(A.obj_water_move, 0).y:
			GM.draw_sprite(A.spr_water_limit_draw, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 222.0), y)
	GM.draw_sprite(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 222.0), y)


# from objects/obj_water_move_limit/Mouse_4.gml
func _mouse_4() -> void:
	if G.play == 0.0 and G.resource_create == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 0.0:
				GM.audio_play_sound(A.snd_drag, 0.0, false)
				drag = 1.0
				for inst in GM.with_list(A.obj_cursor):
					inst.move = 1.0
				can_cont = 1.0
				G.cursor = 1.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_cursor):
					inst.event_user(0)
				GM.other = _o
				alarm[0] = 1.0
