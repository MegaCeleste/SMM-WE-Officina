extends GMObject

var s_down = null
var s_idle = null
var posyy: float = 0.0
var draw_lives: float = 0.0
var ready_v: float = 0.0


# from objects/obj_mariostart_m/Create_0.gml
func _create() -> void:
	s_down = A.spr_NSMBU_mariojump_start
	s_idle = A.spr_NSMBU_mariojump_start
	_user_0()
	if G.apariencia == 3.0:
		image_speed = 0.5
		posyy = 109.0
	else:
		image_speed = 0.0
		image_index = 0.0
		posyy = 83.0
	_user_1()
	vspeed = -5.1
	draw_lives = 0.0
	ready_v = 0.0


# from objects/obj_mariostart_m/Step_2.gml
func _step_end() -> void:
	if y >= (GM.camera_get_view_y(GM.view_get_camera(0)) + 115.0) and vspeed >= 0.0:
		gravity = 0.0
		vspeed = 0.0
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 115.0)
		image_index = 0.0
		if ready_v == 0.0:
			ready_v = 1.0
			alarm[0] = 100.0
			alarm[1] = 25.0
	else:
		gravity = 0.3
	if vspeed >= 0.0:
		if y >= (GM.camera_get_view_y(GM.view_get_camera(0))) + posyy:
			gravity = 0.0
			vspeed = 0.0
			y = ((GM.camera_get_view_y(GM.view_get_camera(0))) + posyy)
			if G.apariencia < 3.0:
				sprite_index = s_idle
			if ready_v == 0.0:
				ready_v = 1.0
				alarm[0] = 100.0
				alarm[1] = 25.0
		else:
			sprite_index = s_down
	else:
		gravity = 0.3


# from objects/obj_mariostart_m/Alarm_0.gml
func _alarm_0() -> void:
	var _with_target2 = A.obj_mariostart
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.alarm[1] = 1.0
	GM.other = _other1


# from objects/obj_mariostart_m/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_letsgo, 0.0, false)
	else:
		match float(G.jugador):
			0.0:
				GM.audio_play_sound(A.snd_letsgo, 0.0, false)
			1.0:
				GM.audio_play_sound(A.snd_letsgo_luigi, 0.0, false)
			2.0:
				GM.audio_play_sound(A.snd_letsgo_toad, 0.0, false)
			3.0:
				GM.audio_play_sound(A.snd_letsgo_toadette, 0.0, false)
	ready_v = 2.0


# from objects/obj_mariostart_m/Other_7.gml
func _animation_end() -> void:
	if G.apariencia == 3.0:
		image_speed = 0.0
		image_index = 31.0


# from objects/obj_mariostart_m/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_mariojump_start
	else:
		sprite_index = Scr.scr_mariojump(self)
		s_down = Scr.scr_mariodrop(self)
		s_idle = Scr.scr_marioidle(self)


# from objects/obj_mariostart_m/Other_11.gml
func _user_1() -> void:
	match float(G.apariencia):
		0.0:
			GM.audio_play_sound(A.snd_SMB_smalljump, 0.0, false)
		1.0:
			GM.audio_play_sound(A.snd_SMB3_jump, 0.0, false)
		2.0:
			GM.audio_play_sound(A.snd_jump, 0.0, false)
		3.0:
			GM.audio_play_sound(A.snd_NSMBU_jump, 0.0, false)


# from objects/obj_mariostart_m/Draw_0.gml
func _gm_draw() -> void:
	var posy  # 局部变量提升（GML 的 var 是函数作用域）
	var scale  # 局部变量提升（GML 的 var 是函数作用域）
	if G.apariencia == 3.0:
		scale = 1.0
	else:
		scale = 2.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, scale, scale, 0.0, GM.c_white, 1.0)
	if G.dsm == 1.0:
		if G.apariencia == 3.0:
			posy = 5.0
		else:
			posy = 0.0
		GM.draw_set_font(G.numbers_lives)
		GM.draw_set_color(GM.c_white)
		GM.draw_sprite(A.spr_lives_x, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 135.0 - posy))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0))) + 205.0, (GM.camera_get_view_y(GM.view_get_camera(0)) + 119.0 - posy), GM.string_hash_to_newline((Scr.string_add_zeros(self, G.lives, 2.0))))


# from objects/obj_mariostart_m/KeyPress_32.gml
func _keypress_32() -> void:
	var _with_target4 = A.obj_mariostart
	var _other3: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target4):
		inst.alarm[1] = 1.0
	GM.other = _other3
