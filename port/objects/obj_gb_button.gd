extends GMObject

var anim: float = 0.0
var effect_hover: float = 0.0
var texto: String = ""
var press: float = 0.0
var start_y: float = 0.0
var c_title: float = 0.0


# from objects/obj_gb_button/Create_0.gml
func _create() -> void:
	anim = 0.0
	effect_hover = 0.0
	texto = ""
	press = 0.0
	start_y = y
	c_title = GM.make_colour_rgb(88.0, 86.0, 132.0)


# from objects/obj_gb_button/Step_0.gml
func _step() -> void:
	var b
	if GM.instance_exists(A.obj_guardabot):
		var guardabot = GM.instance_find(A.obj_guardabot, 0)
		b = guardabot.cont_scroll
	else:
		b = 1.0
	y = (start_y - (((b - 2.0) * 50.0) * G.scroll_perc))


# from objects/obj_gb_button/Alarm_0.gml
func _alarm_0() -> void:
	press = 0.0


# from objects/obj_gb_button/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_title)
	var nn_text = Scr.scr_add3points(self, texto, 80.0, 18.0)
	GM.draw_text((x + 6.0), (y + 32.0), GM.string_hash_to_newline((nn_text)))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_gb_button/Mouse_4.gml
func _mouse_4() -> void:
	if texto != "" and press == 0.0:
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		if G.press_load == 1.0:
			G.last_level = texto
			G.press_load = 0.0
			GM.room_goto(A.rm_editor)
		else:
			G.levelguardabot = texto
			for inst in GM.with_list(A.obj_gb_button):
				inst.press = 1.0
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_gb_level)


# from objects/obj_gb_button/Mouse_10.gml
func _mouse_10() -> void:
	if press == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_gb_button/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
