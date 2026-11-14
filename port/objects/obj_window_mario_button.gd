extends GMObject

var s_sprite: float = 0.0
var s_index: float = 0.0
var s_contorno: float = 0.0
var powerup: float = 0.0
var type_powerup: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var disabled: float = 0.0


# from objects/obj_window_mario_button/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_sprite = A.spr_cards_SMB
		1.0:
			s_sprite = A.spr_cards_SMB3
		2.0:
			s_sprite = A.spr_cards_SMW
		3.0:
			s_sprite = A.spr_cards_NSMBU
	image_speed = 0.0
	s_index = 0.0
	s_contorno = 0.0
	powerup = 1.0
	type_powerup = 0.0
	effect_hover = 0.0
	anim = 0.0
	disabled = 0.0


# from objects/obj_window_mario_button/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_sprite(s_sprite, s_index, (x + 1.0), (y - 5.0))
	GM.draw_sprite(A.spr_window_button_add, s_contorno, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_window_mario_button/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0:
		if s_contorno == 0.0:
			GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
			if powerup == -21.0:
				G.star_flash = 1.0
			else:
				for inst in GM.with_list(A.obj_mario_editor):
					inst.type_powerup = self.type_powerup
		elif powerup == -21.0:
			GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
			G.star_flash = 0.0
		else:
			GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
			for inst in GM.with_list(A.obj_mario_editor):
				inst.type_powerup = 0.0
		for inst in GM.with_list(A.obj_ventana):
			inst.can_anim2 = 1.0
	else:
		GM.audio_stop_sound(A.snd_wrong)
		GM.audio_play_sound(A.snd_wrong, 0.0, false)


# from objects/obj_window_mario_button/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_miniwindow_desplazarse)
		GM.audio_play_sound(A.snd_miniwindow_desplazarse, 0.0, false)
	effect_hover = 1.0


# from objects/obj_window_mario_button/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
