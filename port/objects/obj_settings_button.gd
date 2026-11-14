extends GMObject

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_settings_button/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_settings_button/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_settings_button/Mouse_4.gml
func _mouse_4() -> void:
	var cursor = GM.instance_find(A.obj_cursor, 0)
	if cursor != null and cursor.active_menu == 0.0 and not GM.instance_exists(A.obj_settings_panel):
		if image_index == 2.0:
			GM.audio_stop_sound(A.snd_niveles_mundiales)
			GM.audio_play_sound(A.snd_niveles_mundiales, 0.0, false)
			GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_settings_panel)
			if GM.instance_exists(A.obj_edit_menu):
				for inst in GM.with_list(A.obj_edit_menu):
					inst.instance_destroy()
		elif image_index == 3.0:
			GM.audio_play_sound(A.snd_inventory, 0.0, false)
			Scr.scr_init_globals(self)
			if GM.instance_exists(A.obj_creator_jugar_editar):
				var creator = GM.instance_find(A.obj_creator_jugar_editar, 0)
				GM.audio_stop_sound(creator.music_editor)
			GM.room_goto(A.rm_title)
		elif image_index == 1.0:
			if GM.veq(G.my1, 0.0) or GM.veq(G.my2, 0.0) or GM.veq(G.my3, -1.0) or GM.veq(G.my4, -1.0) or GM.veq(G.my5, 0.0) or GM.veq(G.my6, -1.0):
				return
			else:
				G.my2 = 0.0
				G.my3 = -1.0
				G.my4 = -1.0
				G.my5 = 0.0
				G.my6 = -1.0
				GM.room_goto(A.rm_title)


# from objects/obj_settings_button/Mouse_10.gml
func _mouse_10() -> void:
	var cursor = GM.instance_find(A.obj_cursor, 0)
	if cursor != null and cursor.active_menu == 0.0 and not GM.instance_exists(A.obj_settings_panel):
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_menu_settings_button_move)
			GM.audio_play_sound(A.snd_menu_settings_button_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_settings_button/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
