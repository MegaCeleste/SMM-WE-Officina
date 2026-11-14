extends "res://objects/obj_parent_layout.gd"

var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_dog/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_dog/Step_0.gml
func _step() -> void:
	x = (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0)


# from objects/obj_dog/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, (((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 26.0) + GM.instance_find(A.obj_cursor, 0).anim_right), (GM.camera_get_view_y(GM.view_get_camera(0)) + 160.0), anim, 2.0)


# from objects/obj_dog/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_exists(A.obj_editormanager) and GM.instance_find(A.obj_editormanager, 0).zoom == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor_water == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not GM.instance_exists(A.obj_panelparent)) and (not GM.instance_exists(A.obj_ventana)) and GM.room_width >= 768.0 and (not place_meeting(GM.mouse_x, GM.mouse_y, A.obj_creator_jugar_editar)):
		G.play_lock = 1.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.zoom = 1.0
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_cursor):
			inst.anim_right = 0.0
			inst.anim_left = 0.0
			inst.anim_top = 0.0
			inst.cont_panel_right = 0.0
			inst.cont_panel_left = 0.0
			inst.cont_panel_top = 0.0
			inst.event_user(3)
		GM.other = _o1


# from objects/obj_dog/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		image_index = 1.0
		effect_hover = 1.0


# from objects/obj_dog/Mouse_11.gml
func _mouse_11() -> void:
	image_index = 0.0
	effect_hover = 0.0
