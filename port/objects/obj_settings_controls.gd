extends GMObject

var key: float = 0.0
var text = null
var xx: float = 0.0
var yy: float = 0.0
var col: float = 0.0
var anim: float = 0.0
var effect_hover: float = 0.0
var ID = null


# from objects/obj_settings_controls/Create_0.gml
func _create() -> void:
	key = 0.0
	text = ""
	xx = 0.0
	yy = 0.0
	col = GM.make_colour_rgb(0.0, 149.0, 233.0)
	image_speed = 0.0
	anim = 0.0
	effect_hover = 0.0


# from objects/obj_settings_controls/Step_0.gml
func _step() -> void:
	match key:
		0.0:
			text = Scr.key_to_string(self, G.lanzar_agarrar)
			image_index = 5.0
		1.0:
			text = Scr.key_to_string(self, G.saltar)
			image_index = 4.0
		2.0:
			text = Scr.key_to_string(self, G.arriba)
		3.0:
			text = Scr.key_to_string(self, G.abajo)
			image_index = 1.0
		4.0:
			text = Scr.key_to_string(self, G.izquierda)
			image_index = 2.0
		5.0:
			text = Scr.key_to_string(self, G.derecha)
			image_index = 3.0
		6.0:
			text = Scr.key_to_string(self, G.saltar_spin)
			image_index = 6.0


# from objects/obj_settings_controls/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_halign(GM.fa_center)
	GM.draw_sprite(sprite_index, -1.0, x, y)
	GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0)) + 100.0) + xx), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0) + yy), GM.string_hash_to_newline(text))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_settings_controls/Mouse_4.gml
func _mouse_4() -> void:
	match key:
		0.0:
			Scr.set_keys(self, 0.0, "Presiona Una Tecla...", 88.0)
		1.0:
			Scr.set_keys(self, 1.0, "Presiona Una Tecla...", 90.0)
		2.0:
			Scr.set_keys(self, 4.0, "Presiona Una Tecla...", 38.0)
		3.0:
			Scr.set_keys(self, 5.0, "Presiona Una Tecla...", 40.0)
		4.0:
			Scr.set_keys(self, 6.0, "Presiona Una Tecla...", 37.0)
		5.0:
			Scr.set_keys(self, 7.0, "Presiona Una Tecla...", 39.0)
		6.0:
			Scr.set_keys(self, 8.0, "Presiona Una Tecla...", 40.0)


# from objects/obj_settings_controls/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_play_sound(A.snd_settings_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_settings_controls/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
