extends GMObject

var c_title: float = 0.0


# from objects/obj_window_alert/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	c_title = GM.make_colour_rgb(89.0, 15.0, 16.0)
	if GM.instance_exists(A.obj_creator_jugar_editar):
		GM.audio_pause_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 21.0), A.obj_input)
	GM.instance_create_depth((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), -16.0, A.obj_input_desc)
	var _with_target2 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 91.0), A.obj_etiquetas)
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.idd = 0.0
	GM.other = _other1
	var _with_target4 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 91.0), A.obj_etiquetas)
	var _other3: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target4):
		inst.idd = 1.0
	GM.other = _other3
	var _with_target6 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 252.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 91.0), A.obj_etiquetas)
	var _other5: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target6):
		inst.idd = 2.0
	GM.other = _other5
	var _with_target8 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_etiquetas)
	var _other7: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target8):
		inst.idd = 3.0
	GM.other = _other7
	var _with_target10 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_etiquetas)
	var _other9: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target10):
		inst.idd = 4.0
	GM.other = _other9
	var _with_target12 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 252.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_etiquetas)
	var _other11: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target12):
		inst.idd = 5.0
	GM.other = _other11
	var _with_target14 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 131.0), A.obj_etiquetas)
	var _other13: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target14):
		inst.idd = 6.0
	GM.other = _other13
	var _with_target16 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 131.0), A.obj_etiquetas)
	var _other15: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target16):
		inst.idd = 7.0
	GM.other = _other15
	var _with_target18 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 252.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 131.0), A.obj_etiquetas)
	var _other17: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target18):
		inst.idd = 8.0
	GM.other = _other17
	var _with_target20 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_etiquetas)
	var _other19: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target20):
		inst.idd = 9.0
	GM.other = _other19
	var _with_target22 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_etiquetas)
	var _other21: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target22):
		inst.idd = 10.0
	GM.other = _other21
	var _with_target24 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 252.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_etiquetas)
	var _other23: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target24):
		inst.idd = 11.0
	GM.other = _other23
	var _with_target26 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 171.0), A.obj_etiquetas)
	var _other25: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target26):
		inst.idd = 12.0
	GM.other = _other25
	var _with_target28 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 136.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 171.0), A.obj_etiquetas)
	var _other27: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target28):
		inst.idd = 13.0
	GM.other = _other27
	var _with_target30 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 252.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 171.0), A.obj_etiquetas)
	var _other29: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target30):
		inst.idd = 14.0
	GM.other = _other29
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 135.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 190.0), A.obj_button_notification_aceptar)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 364.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 4.0), A.obj_button_notification_cancelar)


# from objects/obj_window_alert/Destroy_0.gml
func _destroy() -> void:
	var _with_target32 = A.obj_input
	var _other31: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target32):
		inst.instance_destroy()
	GM.other = _other31
	var _with_target34 = A.obj_input_desc
	var _other33: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target34):
		inst.instance_destroy()
	GM.other = _other33
	var _with_target36 = A.obj_etiquetas
	var _other35: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target36):
		inst.instance_destroy()
	GM.other = _other35
	var _with_target38 = A.obj_button_notification_aceptar
	var _other37: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target38):
		inst.instance_destroy()
	GM.other = _other37
	var _with_target40 = A.obj_button_notification_cancelar
	var _other39: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target40):
		inst.instance_destroy()
	GM.other = _other39
	G.etiqueta1 = -1.0
	G.etiqueta2 = -1.0
	if GM.instance_exists(A.obj_creator_jugar_editar):
		GM.audio_resume_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)


# from objects/obj_window_alert/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_title)
	GM.draw_sprite_stretched(sprite_index, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	GM.draw_text_color((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0), GM.string_hash_to_newline(Scr.scr_language(self, 88.0)), c_title, c_title, c_title, c_title, 1.0)
	GM.draw_text_color((GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 38.0), GM.string_hash_to_newline(Scr.scr_language(self, 189.0)), c_title, c_title, c_title, c_title, 1.0)
