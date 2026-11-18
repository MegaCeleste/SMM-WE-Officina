extends GMObject

var direct: float = 0.0
var press: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var disabled: float = 0.0


# from objects/obj_button_home/Create_0.gml
func _create() -> void:
	direct = 0.0
	press = 1.0
	alarm[0] = 15.0
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	anim = 0.0
	disabled = 0.0


# from objects/obj_button_home/Step_2.gml
func _step_end() -> void:
	if GM.room == A.rm_title:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0)
		match image_index:
			1.0:
				y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0)
			2.0:
				y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0)
			3.0:
				y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0)


# from objects/obj_button_home/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_button_home/Alarm_1.gml
func _alarm_1() -> void:
	match image_index:
		0.0:
			GM.room_goto(A.rm_editor)
		1.0:
			pass
		2.0:
			pass
		3.0:
			GM.room_goto(A.rm_guardabot)


# from objects/obj_button_home/Draw_0.gml
func _gm_draw() -> void:
	var posy
	var text
	var c_color
	match image_index:
		0.0:
			posy = 108.0
			text = 12.0
		1.0:
			posy = 108.0
			text = 13.0
		2.0:
			posy = 141.0
			text = 14.0
		3.0:
			posy = 174.0
			text = 15.0
	if sprite_index == A.spr_buttons_plays:
		c_color = GM.make_color_rgb(89.0, 15.0, 16.0)
	else:
		c_color = GM.make_color_rgb(253.0, 203.0, 0.0)
	if GM.room == A.rm_title:
		GM.draw_sprite(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0, GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0)
		if effect_hover == 1.0:
			anim += 0.3
			Scr.scr_anim_hover(self, GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0, GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0, anim, 2.0)
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(c_color)
		GM.draw_set_halign(GM.fa_center)
		GM.draw_text(GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0 + 81.0 + GM.string_width(text), GM.camera_get_view_y(GM.view_get_camera(0)) + 141.0 + 7.75, Scr.scr_language(self, text))
	else:
		draw_self()
		if effect_hover == 1.0:
			anim += 0.3
			Scr.scr_anim_hover(self, x, y, anim, 2.0)
		GM.draw_set_font(G.font_google)
		GM.draw_set_color(c_color)
		GM.draw_set_halign(GM.fa_center)
		GM.draw_text((x + (sprite_width / 2.0) + GM.string_width(text)), y + 7.75, Scr.scr_language(self, text))
	GM.draw_set_halign(GM.fa_left)


# from objects/obj_button_home/Mouse_4.gml
func _mouse_4() -> void:
	# Online course entries remain inert in the offline port.
	if image_index == 1.0 or image_index == 2.0:
		return
	if disabled == 0.0 and press == 1.0 and (not GM.instance_exists(A.obj_settings_panel)) and sprite_index == A.spr_buttons_plays:
		if GM.instance_exists(A.obj_creator_jugar_editar):
			var creator = GM.instance_find(A.obj_creator_jugar_editar, 0)
			GM.audio_stop_sound(creator.music_editor)
		GM.audio_stop_sound(A.snd_titlemusic)
		GM.audio_stop_sound(A.snd_titlemusic_modern)
		GM.audio_stop_sound(A.snd_titlemusic_night)
		GM.audio_stop_sound(A.snd_titlemusic_smw)
		GM.audio_stop_sound(A.snd_super_experto)
		GM.audio_stop_sound(A.snd_guardabot)
		GM.audio_stop_sound(A.snd_music_mario_land)
		GM.audio_stop_sound(A.snd_SMB_master_sword)
		GM.audio_stop_sound(A.snd_SMB_master_sword_underground)
		GM.audio_stop_sound(A.snd_SMB_master_sword_castle)
		Scr.scr_stop_effect_sounds(self)
		press = 0.0
		if GM.instance_exists(A.obj_cursor):
			for inst in GM.with_list(A.obj_cursor):
				inst.active_menu = 1.0
		G.type_consult = -4.0
		G.map_consult = -4.0
		match image_index:
			0.0, 3.0:
				GM.audio_play_sound(A.snd_modo_historia, 0.0, false)
				sprite_index = A.spr_buttons_plays_press
				alarm[1] = 15.0


# from objects/obj_button_home/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_button_home_move)
		GM.audio_play_sound(A.snd_button_home_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_home/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
