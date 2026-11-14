extends "res://objects/obj_panelparent.gd"

var text: float = 0.0


# from objects/obj_bg_selection/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	text = 0.0


# from objects/obj_bg_selection/Step_0.gml
func _step() -> void:
	if not GM.instance_exists(A.obj_bg1):
		text = 0.0
	else:
		text = 1.0


# from objects/obj_bg_selection/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_panel_entorno_anim:
		image_speed = 0.0
		image_index = 4.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 75.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_bg1)):
			inst.bg_s = "ground"
			inst.image_index = 0.0
			inst.subimage = inst.image_index
			inst.x_pos = 75.0
			inst.y_pos = 58.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 75.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 82.0), A.obj_bg1)):
			inst.bg_s = "underground"
			inst.image_index = 1.0
			inst.subimage = inst.image_index
			inst.x_pos = 75.0
			inst.y_pos = 82.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 75.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 106.0), A.obj_bg1)):
			inst.bg_s = "underwater"
			inst.image_index = 2.0
			inst.subimage = inst.image_index
			inst.x_pos = 75.0
			inst.y_pos = 106.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 75.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_bg1)):
			inst.bg_s = "desert"
			inst.image_index = 3.0
			inst.subimage = inst.image_index
			inst.x_pos = 75.0
			inst.y_pos = 130.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 75.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 154.0), A.obj_bg1)):
			inst.bg_s = "snow"
			inst.image_index = 4.0
			inst.subimage = inst.image_index
			inst.x_pos = 75.0
			inst.y_pos = 154.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 124.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_bg1)):
			inst.bg_s = "sky"
			inst.image_index = 5.0
			inst.subimage = inst.image_index
			inst.x_pos = 124.0
			inst.y_pos = 58.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 124.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 82.0), A.obj_bg1)):
			inst.bg_s = "forest"
			inst.image_index = 6.0
			inst.subimage = inst.image_index
			inst.x_pos = 124.0
			inst.y_pos = 82.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 124.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 106.0), A.obj_bg1)):
			inst.bg_s = "ghost"
			inst.image_index = 7.0
			inst.subimage = inst.image_index
			inst.x_pos = 124.0
			inst.y_pos = 106.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 124.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_bg1)):
			inst.bg_s = "airship"
			inst.image_index = 8.0
			inst.subimage = inst.image_index
			inst.x_pos = 124.0
			inst.y_pos = 130.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 124.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 154.0), A.obj_bg1)):
			inst.bg_s = "castle"
			inst.image_index = 9.0
			inst.subimage = inst.image_index
			inst.x_pos = 124.0
			inst.y_pos = 154.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 170.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 106.0), A.obj_bg1)):
			inst.bg_s = "fall"
			inst.image_index = 10.0
			inst.subimage = inst.image_index
			inst.x_pos = 170.0
			inst.y_pos = 106.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 170.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 130.0), A.obj_bg1)):
			inst.bg_s = "beach"
			inst.image_index = 11.0
			inst.subimage = inst.image_index
			inst.x_pos = 170.0
			inst.y_pos = 130.0
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 170.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 154.0), A.obj_bg1)):
			inst.bg_s = "mountain"
			inst.image_index = 12.0 + G.modo_noche
			inst.subimage = inst.image_index
			inst.x_pos = 170.0
			inst.y_pos = 154.0
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 178.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 76.0), A.obj_night_change)


# from objects/obj_bg_selection/Other_10.gml
func _user_0() -> void:
	image_index = 4.0
	image_speed = -0.5
	for inst in GM.with_list(A.obj_bg1):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_night_change):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_card_bg):
		inst.active = 0.0


# from objects/obj_bg_selection/Draw_0.gml
func _gm_draw() -> void:
	var posx
	if G.idioma == 1.0:
		posx = 7.0
	elif G.idioma == 3.0:
		posx = -4.0
	else:
		posx = 0.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_font(G.font_google)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	if text == 1.0:
		GM.draw_text((x + (sprite_width / 2.0) + 45.0 + posx - GM.string_width(Scr.scr_language(self, 81.0))), y + 37.0, Scr.scr_language(self, 81.0))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_bg_selection/Mouse_4.gml
func _mouse_4() -> void:
	if image_speed == 0.0 and image_index == 4.0 and GM.mouse_x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 201.0) and GM.mouse_x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 212.0) and GM.mouse_y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and GM.mouse_y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0):
		GM.audio_play_sound(A.snd_panel_close, 0.0, false)
		_user_0()
