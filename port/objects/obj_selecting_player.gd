extends GMObject

var value: float = 0.0
var image_draw: float = 0.0
var active: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_selecting_player/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	value = 0.0
	image_draw = 0.0
	active = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_selecting_player/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, active, x, y)
	GM.draw_sprite(A.spr_settings_players, image_draw, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_selecting_player/Mouse_4.gml
func _mouse_4() -> void:
	if active != 2.0:
		for inst in GM.with_list(A.obj_selecting_player):
			if inst.active == 1.0:
				inst.active = 0.0
		active = 1.0
		GM.audio_stop_sound(A.snd_mario_voice)
		GM.audio_stop_sound(A.snd_luigi_voice)
		GM.audio_stop_sound(A.snd_toad_voice)
		GM.audio_stop_sound(A.snd_letsgo_toadette)
		GM.audio_stop_sound(A.snd_toadette_voice)
		match value:
			0.0:
				for inst in GM.with_list(A.obj_cursor):
					inst.cursor = A.spr_cursor_mario
				GM.audio_play_sound(A.snd_mario_voice, 0.0, false)
			1.0:
				for inst in GM.with_list(A.obj_cursor):
					inst.cursor = A.spr_cursor_luigi
				GM.audio_play_sound(A.snd_luigi_voice, 0.0, false)
			2.0:
				for inst in GM.with_list(A.obj_cursor):
					inst.cursor = A.spr_cursor_toad
				GM.audio_play_sound(A.snd_toad_voice, 0.0, false)
			3.0:
				for inst in GM.with_list(A.obj_cursor):
					inst.cursor = A.spr_cursor_toadette
				GM.audio_play_sound(GM.choose(A.snd_letsgo_toadette, A.snd_toadette_voice), 0.0, false)
		G.jugador = value


# from objects/obj_selecting_player/Mouse_10.gml
func _mouse_10() -> void:
	if active != 2.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_settings_move)
			GM.audio_stop_sound(A.snd_settings_player_move)
			GM.audio_play_sound(A.snd_settings_player_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_selecting_player/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
