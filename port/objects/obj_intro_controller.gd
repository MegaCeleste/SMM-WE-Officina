# from objects/obj_intro_controller/（第 2 批移植，已逐事件核对）
extends GMObject

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var omitir: float = 0.0
var date: float = 0.0
var alpha: float = 0.0
var day: String = ""


# from objects/obj_intro_controller/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	ready_v = 0.0
	omitir = 0.0
	alarm[0] = 30.0
	date = 0.0
	alpha = 0.0
	day = "DOMINGO"
	if GM.current_day == 24.0 and GM.current_month == 12.0:
		day = Scr.scr_language(self, 9.0)
	elif GM.current_day == 1.0 and GM.current_month == 1.0:
		day = Scr.scr_language(self, 10.0)
	else:
		match GM.current_weekday:
			0.0:
				day = Scr.scr_language(self, 8.0)
			1.0:
				day = Scr.scr_language(self, 2.0)
			2.0:
				day = Scr.scr_language(self, 3.0)
			3.0:
				day = Scr.scr_language(self, 4.0)
			4.0:
				day = Scr.scr_language(self, 5.0)
			5.0:
				day = Scr.scr_language(self, 6.0)
			6.0:
				day = Scr.scr_language(self, 7.0)


# from objects/obj_intro_controller/Step_2.gml
func _step_end() -> void:
	if ready_v == 1.0:
		if y >= GM.camera_get_view_y(GM.view_get_camera(0)):
			gravity = 0.0
			if vspeed > 0.0:
				if vspeed > 0.5:
					if date == 0.0:
						date = 1.0
					vspeed = ((-vspeed) / 2.0)
				else:
					vspeed = 0.0
					y = GM.camera_get_view_y(GM.view_get_camera(0))
					for inst in GM.with_list(A.obj_persistent):
						inst.alarm[4] = 220.0
					GM.audio_play_sound(A.snd_SMM_intro, 0.0, false)
					ready_v = 2.0
		else:
			gravity = 0.3
			if vspeed > 6.0:
				vspeed = 6.0
	if date == 1.0:
		if alpha >= 1.0:
			alpha = 1.0
		else:
			alpha += 0.25


# from objects/obj_intro_controller/Alarm_0.gml
func _alarm_0() -> void:
	omitir = 1.0


# from objects/obj_intro_controller/Alarm_1.gml
func _alarm_1() -> void:
	GM.audio_stop_sound(A.snd_SMM_intro)
	for inst in GM.with_list(A.obj_mario_intro):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_shell_intro):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_thwomp_intro):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_goomba_intro):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_persistent):
		inst.alarm[4] = 1.0
	instance_destroy()


# from objects/obj_intro_controller/Other_4.gml
func _room_start() -> void:
	match GM.current_weekday:
		0.0:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 128.0), A.obj_shell_intro)
		1.0:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 128.0), A.obj_shell_intro)
		2.0:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 128.0), A.obj_shell_intro)
		3.0:
			# audio_play_sound(snd_goomba_march, 0, false)
			# 		with instance_create((camera_get_view_x(view_get_camera(0)) + 400), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			# 			goomba = 1
			# 		instance_create((camera_get_view_x(view_get_camera(0)) + 434), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			#        instance_create((camera_get_view_x(view_get_camera(0)) + 468), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			#        break
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 194.5), (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0), A.obj_thwomp_intro)
		4.0:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 128.0), A.obj_shell_intro)
		5.0:
			#
			#        audio_play_sound(snd_goomba_march, 0, false)
			# 		with instance_create((camera_get_view_x(view_get_camera(0)) + 400), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			# 			goomba = 1
			# 		instance_create((camera_get_view_x(view_get_camera(0)) + 434), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			#        instance_create((camera_get_view_x(view_get_camera(0)) + 468), (camera_get_view_y(view_get_camera(0)) + 144), obj_goomba_intro)
			#        break
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 194.5), (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0), A.obj_thwomp_intro)
		6.0:
			GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 194.5), (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0), A.obj_thwomp_intro)


# from objects/obj_intro_controller/Draw_0.gml
func _gm_draw() -> void:
	if date == 1.0:
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(GM.c_white)
		GM.draw_set_alpha(alpha)
		GM.draw_sprite_ext(A.spr_calendar, 0.0, 16.0, 16.0, 1.0, 1.0, 0.0, GM.c_white, alpha)
		GM.draw_text(34.0, 13.0, GM.string_hash_to_newline((day)))
		GM.draw_set_alpha(1.0)
	GM.draw_sprite(A.spr_letters_super, 0.0, (x + 96.0), (y + 36.0))
	GM.draw_sprite(A.spr_letters, 0.0, (x + 96.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 1.0, (x + 119.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 2.0, (x + 138.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 3.0, (x + 157.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 4.0, (x + 165.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 0.0, (x + 195.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 1.0, (x + 218.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 5.0, (x + 237.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 6.0, (x + 256.0), (y + 57.0))
	GM.draw_sprite(A.spr_letters, 2.0, (x + 273.0), (y + 57.0))
	GM.draw_sprite(A.spr_we, 0.0, (x + 214.0), (y + 90.0))


# from objects/obj_intro_controller/Mouse_53.gml
func _mouse_53() -> void:
	if GM.os_type == GM.os_android and omitir == 1.0:
		alarm[1] = 1.0


# from objects/obj_intro_controller/KeyPress_13.gml
func _keypress_13() -> void:
	if omitir == 1.0:
		alarm[1] = 1.0
