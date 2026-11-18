extends GMObject

var c_letters: float = 0.0
var idioma: float = 0.0
var settings = null
var controls = null
var language = null
var character = null
var sonidos = null
var ventana = null
var sombras = null
var active1: float = 0.0
var active2: float = 0.0
var active3: float = 0.0
var active4: float = 0.0
var act1: float = 0.0
var act2: float = 0.0
var act3: float = 0.0
var act4: float = 0.0


# from objects/obj_settings_panel/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	c_letters = GM.make_colour_rgb(89.0, 15.0, 16.0)
	idioma = G.idioma
	settings = Scr.scr_language(self, 19.0)
	controls = Scr.scr_language(self, 20.0)
	language = Scr.scr_language(self, 21.0)
	character = Scr.scr_language(self, 22.0)
	sonidos = Scr.scr_language(self, 23.0)
	var persistent = GM.instance_find(A.obj_persistent, 0)
	if (persistent.modo_android == 0.0) and (G.keymod == 0.0):
		ventana = Scr.scr_language(self, 24.0)
		sombras = Scr.scr_language(self, 25.0)
	elif G.keymod == 0.0:
		ventana = Scr.scr_language(self, 26.0)
		sombras = Scr.scr_language(self, 27.0)
	if GM.instance_exists(A.obj_editormanager):
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 2.0
	if GM.instance_exists(A.obj_button_home):
		for inst in GM.with_list(A.obj_button_home):
			inst.alarm[0] = -1.0
			inst.press = 0.0
	if GM.instance_exists(A.obj_pausa_button):
		for inst in GM.with_list(A.obj_pausa_button):
			inst.alarm[0] = -1.0
			inst.canpress = 1.0
	match G.jugador:
		1.0:
			active1 = 0.0
			active2 = 1.0
			active3 = 0.0
			active4 = 0.0
		2.0:
			active1 = 0.0
			active2 = 0.0
			active3 = 1.0
			active4 = 0.0
		3.0:
			active1 = 0.0
			active2 = 0.0
			active3 = 0.0
			active4 = 1.0
		_:
			active1 = 1.0
			active2 = 0.0
			active3 = 0.0
			active4 = 0.0
	match G.w_scale:
		2.0:
			act1 = 0.0
			act2 = 1.0
			act3 = 0.0
			act4 = 0.0
		3.0:
			act1 = 0.0
			act2 = 0.0
			act3 = 1.0
			act4 = 0.0
		4.0:
			act1 = 0.0
			act2 = 0.0
			act3 = 0.0
			act4 = 1.0
		_:
			act1 = 1.0
			act2 = 0.0
			act3 = 0.0
			act4 = 0.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 232.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_st_slider)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_settings_custom)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_button_settings_idioma)
	if persistent.modo_android == 0.0:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_button_settings_estrella)
		GM.instance_create(GM.camera_get_view_x(0) + 146.0, GM.camera_get_view_y(0) + 142.0, A.obj_button_sombras)
	else:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_button_settings_sm4j)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), A.obj_selecting_fps)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 39.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), A.obj_button_creditos)
	GM.instance_create_depth((GM.camera_get_view_x(GM.view_get_camera(0)) + 102.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), -19.0, A.obj_vsync)
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 0.0
		inst.image_draw = 0.0
		inst.active = self.active1
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 1.0
		inst.image_draw = 1.0
		inst.active = self.active2
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 289.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 2.0
		inst.image_draw = 2.0
		inst.active = self.active3
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 318.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 3.0
		inst.image_draw = 3.0
		inst.active = self.active4
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 347.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 4.0
		inst.image_draw = 4.0
		inst.active = 2.0
	if persistent.modo_android == 0.0:
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 0.0
			inst.image_draw = 0.0
			inst.active = self.act1
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 1.0
			inst.image_draw = 1.0
			inst.active = self.act2
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 289.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 2.0
			inst.image_draw = 2.0
			inst.active = self.act3
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 318.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 3.0
			inst.image_draw = 3.0
			inst.active = self.act4
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 347.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 4.0
			inst.image_draw = 4.0
			inst.active = 2.0
	else:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_button_settings_controls)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 263.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), A.obj_button_settings_close)


# from objects/obj_settings_panel/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_settings_custom):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_settings_idioma):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_sombras):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_selecting_player):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_selecting_fps):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_creditos):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_vsync):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_settings_close):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_settings_estrella):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_settings_controls):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_button_settings_sm4j):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_window_select):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_st_slider):
		inst.instance_destroy()
	if GM.instance_exists(A.obj_button_home):
		for inst in GM.with_list(A.obj_button_home):
			inst.alarm[0] = 15.0
	if GM.instance_exists(A.obj_pausa_button):
		for inst in GM.with_list(A.obj_pausa_button):
			inst.alarm[0] = 20.0
	if GM.instance_exists(A.obj_editormanager):
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 0.0


# from objects/obj_settings_panel/Other_10.gml
func _user_0() -> void:
	var persistent = GM.instance_find(A.obj_persistent, 0)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 232.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_st_slider)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_settings_custom)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_button_settings_idioma)
	if persistent.modo_android == 0.0:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_button_settings_estrella)
		GM.instance_create(GM.camera_get_view_x(0) + 146.0, GM.camera_get_view_y(0) + 142.0, A.obj_button_sombras)
	else:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_button_settings_sm4j)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), A.obj_selecting_fps)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 39.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), A.obj_button_creditos)
	GM.instance_create_depth((GM.camera_get_view_x(GM.view_get_camera(0)) + 102.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 191.0), -19.0, A.obj_vsync)
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 0.0
		inst.image_draw = 0.0
		inst.active = self.active1
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 1.0
		inst.image_draw = 1.0
		inst.active = self.active2
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 289.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 2.0
		inst.image_draw = 2.0
		inst.active = self.active3
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 318.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 3.0
		inst.image_draw = 3.0
		inst.active = self.active4
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 347.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), A.obj_selecting_player)):
		inst.value = 4.0
		inst.image_draw = 4.0
		inst.active = 2.0
	if persistent.modo_android == 0.0:
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 0.0
			inst.image_draw = 0.0
			inst.active = self.act1
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 1.0
			inst.image_draw = 1.0
			inst.active = self.act2
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 289.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 2.0
			inst.image_draw = 2.0
			inst.active = self.act3
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 318.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 3.0
			inst.image_draw = 3.0
			inst.active = self.act4
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 347.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_window_select)):
			inst.value = 4.0
			inst.image_draw = 4.0
			inst.active = 2.0
	else:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 101.0), A.obj_button_settings_controls)
	GM.instance_destroy(A.obj_button_settings_close2)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 263.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), A.obj_button_settings_close)


# from objects/obj_settings_panel/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_sprite_stretched(sprite_index, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	GM.draw_sprite(A.spr_sett_icon, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 7.0))
	GM.draw_set_color(c_letters)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 24.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 7.0), GM.string_hash_to_newline(settings))
	if G.keymod == 0.0:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 84.0), GM.string_hash_to_newline(ventana))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 126.0), GM.string_hash_to_newline(sombras))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 34.0), GM.string_hash_to_newline(controls))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 84.0), GM.string_hash_to_newline(language))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 34.0), GM.string_hash_to_newline(character))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 126.0), GM.string_hash_to_newline(sonidos))
		GM.draw_set_color(GM.c_grey)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 175.0), GM.string_hash_to_newline(G.descver))
		GM.draw_set_color(c_letters)
	elif G.keymod == 1.0:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 7.0), GM.string_hash_to_newline(Scr.scr_language(self, 187.0)))
