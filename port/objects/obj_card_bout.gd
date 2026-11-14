extends GMObject

var pos_y = null
var pos_y_limit = null
var effect_hover: float = 0.0
var speed_water: float = 0.0
var anim: float = 0.0


# from objects/obj_card_bout/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 3.0
	pos_y = (GM.room_height - 16.0)
	pos_y_limit = (GM.room_height - 16.0)
	effect_hover = 0.0
	speed_water = 0.0
	anim = 0.0


# from objects/obj_card_bout/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_editormanager):
		visible = GM.instance_find(A.obj_editormanager, 0).visible
	else:
		visible = false
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0)
	if effect_hover == 1.0:
		match G.bg_level:
			"forest":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_card_bout_purple_anim
					image_speed = 0.15
				else:
					sprite_index = A.spr_card_bout_water_anim
					image_speed = 0.15
			"beach":
				sprite_index = A.spr_card_bout_water_anim
				image_speed = 0.15
			"castle":
				sprite_index = A.spr_card_bout_lava_anim
				image_speed = 0.15
			"mountain":
				if G.modo_noche == 1.0:
					sprite_index = A.spr_card_bout_lava_anim
					image_speed = 0.15
				else:
					sprite_index = A.spr_card_bout
					image_speed = 0.0
					image_index = 3.0
			_:
				sprite_index = A.spr_card_bout
				image_speed = 0.0
				image_index = 3.0
	else:
		sprite_index = A.spr_card_bout
		image_speed = 0.0
		match G.bg_level:
			"forest":
				if G.modo_noche == 1.0:
					image_index = 1.0
				else:
					image_index = 0.0
			"beach":
				image_index = 0.0
			"castle":
				image_index = 2.0
			"mountain":
				if G.modo_noche == 1.0:
					image_index = 2.0
				else:
					image_index = 3.0
			_:
				image_index = 3.0


# from objects/obj_card_bout/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0) - GM.instance_find(A.obj_cursor, 0).anim_left), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0), anim, 1.0)


# from objects/obj_card_bout/Mouse_4.gml
func _mouse_4() -> void:
	if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0) and (((G.bg_level == "forest") or ((G.bg_level == "beach") or ((G.bg_level == "castle") or ((G.bg_level == "mountain") and (G.modo_noche == 1.0))))) and ((GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0) and ((GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0) and ((GM.instance_find(A.obj_editormanager, 0).zoom == 0.0) and ((not GM.instance_exists(A.obj_ventana)) and ((not GM.instance_exists(A.obj_apariencia)) and ((not GM.instance_exists(A.obj_bg_selection)) and (GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0)))))))):
		GM.audio_play_sound(A.snd_panel_open, 0.0, false)
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 2.0
		for inst in GM.with_list(A.obj_levelmanager):
			inst.editor_water = 1.0
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_water_level_control)
		for inst in GM.with_list(A.obj_cursor):
			inst.item_add = 0.0
			if inst.cont_panel_right == 0.0:
				inst.cont_panel_right = 1.0
			if inst.cont_panel_left == 0.0:
				inst.cont_panel_left = 1.0
			if inst.cont_panel_top == 0.0:
				inst.cont_panel_top = 1.0
			inst.cont_panel_creator = 1.0


# from objects/obj_card_bout/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_izquierdo_move)
			GM.audio_play_sound(A.snd_panel_izquierdo_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_card_bout/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
