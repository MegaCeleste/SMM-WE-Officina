extends GMObject

var value: float = 0.0
var image_draw: float = 0.0
var active: float = 0.0
var disabled: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_window_select/Create_0.gml
func _create() -> void:
	value = 0.0
	image_draw = 0.0
	active = 0.0
	disabled = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_window_select/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, active, x, y)
	GM.draw_sprite(A.spr_settings_display, image_draw, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_window_select/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0 and (GM.os_type != GM.os_android) and active != 2.0:
		GM.audio_stop_sound(A.snd_aceptar)
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		for inst in GM.with_list(A.obj_window_select):
			if inst.active == 1.0:
				inst.active = 0.0
		active = 1.0
		var previous_other: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			G.w_scale = (self.value + 1.0)
			inst.filter = (self.value + 1.0)
			inst.event_user(1)
		GM.other = previous_other


# from objects/obj_window_select/Mouse_10.gml
func _mouse_10() -> void:
	if active != 2.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_settings_move)
			GM.audio_stop_sound(A.snd_settings_player_move)
			GM.audio_play_sound(A.snd_settings_player_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_window_select/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
