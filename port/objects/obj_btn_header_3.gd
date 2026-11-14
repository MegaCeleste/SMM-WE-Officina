extends "res://objects/obj_btn_header_parent.gd"


# from objects/obj_btn_header_3/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 2.0


# from objects/obj_btn_header_3/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_find(A.obj_panel_expand, 0).header == 0.0:
		x = GM.camera_get_view_x(GM.view_get_camera(0)) + 288.0
		visible = true
	elif GM.instance_find(A.obj_panel_expand, 0).header == 1.0:
		x = GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0
		visible = true
	elif GM.instance_find(A.obj_panel_expand, 0).header == 2.0:
		visible = false
	else:
		x = GM.camera_get_view_x(GM.view_get_camera(0)) + 105.0
		visible = true


# from objects/obj_btn_header_3/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)


# from objects/obj_btn_header_3/Mouse_4.gml
func _mouse_4() -> void:
	if visible == true:
		for inst in GM.with_list(A.obj_panel_expand):
			inst.value = 4.0
		for inst in GM.with_list(A.obj_header):
			inst.page = 3.0
		for inst in GM.with_list(A.obj_btn_header_parent):
			inst.alarm[0] = 1.0
		for inst in GM.with_list(A.obj_panel_circle):
			inst.instance_destroy()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 125.0), A.obj_panel_circle)):
			inst.event_user(3)
			inst.ready_v = 1.0
		GM.other = _o
		GM.audio_stop_sound(A.snd_palette_page2)
		GM.audio_play_sound(A.snd_palette_page2, 0.0, false)


# from objects/obj_btn_header_3/Mouse_10.gml
func _mouse_10() -> void:
	if visible == true:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_btn_header_3/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
