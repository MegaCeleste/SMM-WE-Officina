extends GMObject

var value: float = 0.0
var image_draw: float = 0.0
var active: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_vsync/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if GM.instance_exists(A.obj_persistent):
		image_index = G.vsync
	value = 0.0
	image_draw = 0.0
	active = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_vsync/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, x, y)
	GM.draw_sprite(A.spr_settings_vsync, image_draw, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_vsync/Mouse_4.gml
func _mouse_4() -> void:
	GM.audio_stop_sound(A.snd_aceptar)
	GM.audio_play_sound(A.snd_aceptar, 0.0, false)
	if GM.instance_exists(A.obj_persistent):
		if G.vsync == 0.0:
			G.vsync = 1.0
		else:
			G.vsync = 0.0
		for inst in GM.with_list(A.obj_persistent):
			inst.alarm[11] = 1.0
		image_index = G.vsync


# from objects/obj_vsync/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_stop_sound(A.snd_settings_player_move)
		GM.audio_play_sound(A.snd_settings_player_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_vsync/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
