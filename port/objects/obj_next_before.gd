extends GMObject


# from objects/obj_next_before/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0


# from objects/obj_next_before/Step_0.gml
func _step() -> void:
	if GM.keyboard_check_pressed(G.izquierda) and image_index == 0.0:
		_user_0()
	if GM.keyboard_check_pressed(G.derecha) and image_index == 1.0:
		_user_0()


# from objects/obj_next_before/Other_10.gml
func _user_0() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if image_index == 0.0:
			if GM.instance_find(A.obj_panel_expand, 0).value == 10.0 or GM.instance_find(A.obj_panel_expand, 0).value == 4.0 or GM.instance_find(A.obj_panel_expand, 0).value == 3.0:
				GM.audio_stop_sound(A.snd_palette_page2)
				GM.audio_play_sound(A.snd_palette_page2, 0.0, false)
			elif GM.instance_find(A.obj_panel_expand, 0).value != 1.0:
				GM.audio_stop_sound(A.snd_page_enemies2)
				GM.audio_play_sound(A.snd_page_enemies2, 0.0, false)
			if GM.instance_find(A.obj_panel_expand, 0).value > 1.0:
				for _obj_write1 in GM.with_list(A.obj_panel_expand):
					_obj_write1.value -= 1.0
				for _obj_write2 in GM.with_list(A.obj_header):
					_obj_write2.page -= 1.0
				var _with_target4 = A.obj_header
				var _other3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target4):
					inst.alarm[0] = 1.0
				GM.other = _other3
				var _with_target6 = A.obj_btn_header_parent
				var _other5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target6):
					inst.alarm[0] = 1.0
				GM.other = _other5
				var _with_target8 = A.obj_panel_circle
				var _other7: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target8):
					inst.instance_destroy()
				GM.other = _other7
				var _with_target10 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 125.0), A.obj_panel_circle)
				var _other9: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target10):
					inst.event_user(int((GM.instance_find(A.obj_panel_expand, 0).value - 1.0)))
					inst.ready_v = 1.0
				GM.other = _other9
		elif image_index == 1.0:
			if GM.instance_find(A.obj_panel_expand, 0).value == 2.0 or GM.instance_find(A.obj_panel_expand, 0).value == 3.0 or GM.instance_find(A.obj_panel_expand, 0).value == 9.0:
				GM.audio_stop_sound(A.snd_palette_page2)
				GM.audio_play_sound(A.snd_palette_page2, 0.0, false)
			elif GM.instance_find(A.obj_panel_expand, 0).value != 14.0:
				GM.audio_stop_sound(A.snd_page_enemies)
				GM.audio_play_sound(A.snd_page_enemies, 0.0, false)
			if GM.instance_find(A.obj_panel_expand, 0).value < 14.0:
				for _obj_write11 in GM.with_list(A.obj_panel_expand):
					_obj_write11.value += 1.0
				for _obj_write12 in GM.with_list(A.obj_header):
					_obj_write12.page += 1.0
				var _with_target14 = A.obj_header
				var _other13: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target14):
					inst.alarm[0] = 1.0
				GM.other = _other13
				var _with_target16 = A.obj_btn_header_parent
				var _other15: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target16):
					inst.alarm[0] = 1.0
				GM.other = _other15
				var _with_target18 = A.obj_panel_circle
				var _other17: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target18):
					inst.instance_destroy()
				GM.other = _other17
				var _with_target20 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 125.0), A.obj_panel_circle)
				var _other19: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target20):
					inst.event_user(int((GM.instance_find(A.obj_panel_expand, 0).value - 1.0)))
					inst.ready_v = 1.0
				GM.other = _other19
	# if (obj_levelmanager.editor == 1)
	# {
	#    if (image_index == 0)
	#    {
	#        if (obj_panel_expand.value == 10 || obj_panel_expand.value == 4 || obj_panel_expand.value == 3)
	#        {
	#            audio_stop_sound(snd_palette_page2)
	#            audio_play_sound(snd_palette_page2, 0, false)
	#        }
	#        else if (obj_panel_expand.value != 1)
	#        {
	#            audio_stop_sound(snd_page_enemies2)
	#            audio_play_sound(snd_page_enemies2, 0, false)
	#        }
	#        if (obj_panel_expand.value > 1)
	#        {
	# 			obj_panel_expand.value--
	# 			obj_header.page--
	#            with (obj_panel_circle)
	#                instance_destroy()
	#            with (instance_create((camera_get_view_x(view_get_camera(0)) + 192), (camera_get_view_y(view_get_camera(0)) + 125), obj_panel_circle))
	#            {
	#                event_user((obj_panel_expand.value - 1))
	#                ready = 1
	#            }
	#        }
	#    }
	#    else if (image_index == 1)
	#    {
	#        if (obj_panel_expand.value == 2 || obj_panel_expand.value == 3 || obj_panel_expand.value == 9)
	#        {
	#            audio_stop_sound(snd_palette_page2)
	#            audio_play_sound(snd_palette_page2, 0, false)
	#        }
	#        else if (obj_panel_expand.value != 14)
	#        {
	#            audio_stop_sound(snd_page_enemies)
	#            audio_play_sound(snd_page_enemies, 0, false)
	#        }
	#        if (obj_panel_expand.value < 14)
	#        {
	#            obj_panel_expand.value++
	# 			obj_header.page++
	#            with (obj_panel_circle)
	#                instance_destroy()
	#            with (instance_create((camera_get_view_x(view_get_camera(0)) + 192), (camera_get_view_y(view_get_camera(0)) + 125), obj_panel_circle))
	#            {
	#                event_user((obj_panel_expand.value - 1))
	#                ready = 1
	#            }
	#        }
	#    }
	# }


# from objects/obj_next_before/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_panel_expand):
		if image_index == 0.0:
			if GM.instance_find(A.obj_panel_expand, 0).value != 1.0:
				GM.draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
		elif GM.instance_find(A.obj_panel_expand, 0).value != 14.0:
			GM.draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)


# from objects/obj_next_before/Mouse_4.gml
func _mouse_4() -> void:
	_user_0()
