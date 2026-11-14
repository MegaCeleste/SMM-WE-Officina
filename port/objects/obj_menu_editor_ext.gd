extends "res://objects/obj_parent_layout.gd"

var can_press: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_menu_editor_ext/Create_0.gml
func _create() -> void:
	can_press = 0.0
	alarm[0] = 30.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_menu_editor_ext/Alarm_0.gml
func _alarm_0() -> void:
	can_press = 1.0


# from objects/obj_menu_editor_ext/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_menu_editor_ext/Mouse_4.gml
func _mouse_4() -> void:
	if G.cursor == 0.0 and can_press == 1.0 and G.press_load == 0.0 and (not GM.instance_exists(A.obj_gb_level)) and ((not GM.instance_exists(A.obj_guardabot)) or (GM.instance_exists(A.obj_guardabot) and GM.instance_find(A.obj_guardabot, 0).active == 1.0)):
		GM.audio_play_sound(A.snd_abrir_menu, 0.0, false)
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_edit_menu)
		for _obj_write1 in GM.with_list(A.obj_cursor):
			_obj_write1.image_index = 0.0
		if GM.instance_exists(A.obj_gb_button):
			var _with_target3 = A.obj_gb_button
			var _other2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target3):
				inst.press = 0.0
			GM.other = _other2
		GM.instance_deactivate_object(A.obj_menu_editor)
		GM.instance_deactivate_object(A.obj_menu_editor_ext)
		if GM.instance_exists(A.obj_guardabot):
			var _with_target5 = A.obj_guardabot
			var _other4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target5):
				inst.can_anim = 0.0
			GM.other = _other4


# from objects/obj_menu_editor_ext/Mouse_10.gml
func _mouse_10() -> void:
	if (not GM.instance_exists(A.obj_edit_menu)) and ((not GM.instance_exists(A.obj_settings_panel))):
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_menu_editor_ext/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
