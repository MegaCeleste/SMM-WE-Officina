extends GMObject

var anim: float = 0.0
var effect_hover: float = 0.0
var text = null
var disabled: float = 0.0


# from objects/obj_settings_custom/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	anim = 0.0
	effect_hover = 0.0
	text = Scr.scr_language(self, 29.0)
	var persistent = GM.instance_find(A.obj_persistent, 0)
	if (persistent.modo_android == 0.0) and (GM.room != A.rm_guardabot_play):
		disabled = 0.0
	else:
		disabled = 1.0
	GM.instance_create(x + 128.0, y, A.obj_configurar_controles_reset)


# from objects/obj_settings_custom/Destroy_0.gml
func _destroy() -> void:
	GM.instance_destroy(A.obj_configurar_controles_reset)


# from objects/obj_settings_custom/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 60.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 41.0), A.obj_settings_controls)):
		inst.xx = 60.0
		inst.yy = 41.0
		inst.key = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 200.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 41.0), A.obj_settings_controls)):
		inst.xx = 200.0
		inst.yy = 41.0
		inst.key = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 60.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 85.0), A.obj_settings_controls)):
		inst.xx = 60.0
		inst.yy = 85.0
		inst.key = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 200.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 85.0), A.obj_settings_controls)):
		inst.xx = 200.0
		inst.yy = 85.0
		inst.key = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 160.0), A.obj_settings_controls)):
		inst.xx = 136.0
		inst.yy = 160.0
		inst.key = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 60.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 124.0), A.obj_settings_controls)):
		inst.xx = 60.0
		inst.yy = 124.0
		inst.key = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 200.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 124.0), A.obj_settings_controls)):
		inst.xx = 200.0
		inst.yy = 124.0
		inst.key = 0.0
	G.keymod = 1.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 263.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 186.0), A.obj_button_settings_close2)
	GM.instance_destroy(A.obj_settings_custom)
	GM.instance_destroy(A.obj_button_settings_idioma)
	GM.instance_destroy(A.obj_button_sombras)
	GM.instance_destroy(A.obj_selecting_player)
	GM.instance_destroy(A.obj_selecting_fps)
	GM.instance_destroy(A.obj_button_creditos)
	GM.instance_destroy(A.obj_vsync)
	GM.instance_destroy(A.obj_button_settings_estrella)
	GM.instance_destroy(A.obj_button_settings_controls)
	GM.instance_destroy(A.obj_button_settings_sm4j)
	GM.instance_destroy(A.obj_window_select)
	GM.instance_destroy(A.obj_st_slider)
	GM.instance_destroy(A.obj_button_settings_close)


# from objects/obj_settings_custom/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_text((x + 33.0), (y + 6.0), GM.string_hash_to_newline(text))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, (y + 1.0), anim, 2.0)


# from objects/obj_settings_custom/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0:
		GM.audio_stop_sound(A.snd_aceptar)
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		_user_0()


# from objects/obj_settings_custom/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_settings_move)
		GM.audio_play_sound(A.snd_settings_move, 0.0, false)
	effect_hover = 1.0


# from objects/obj_settings_custom/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
