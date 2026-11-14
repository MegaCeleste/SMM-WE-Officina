extends "res://objects/obj_parent_layout.gd"

var sprite_card: float = 0.0
var s_card_top: float = 0.0
var disabled = null
var active: float = 0.0
var obj = null
var value: float = 0.0
var x_pos: float = 0.0
var pos: float = 0.0
var obj_draw = null
var bg_color = null
var sun_disabled: float = 0.0
var obj_creation: float = 0.0
var effect_hover: float = 0.0
var etop: float = 0.0
var anim: float = 0.0
var obj_sonidos = null
var obj_draw_sonidos = null
var bg_color_sonidos = null
var disabled_sonidos = null
var cont = null


# from objects/obj_card_item/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_card = A.spr_cards_SMB
		1.0:
			sprite_card = A.spr_cards_SMB3
		2.0:
			sprite_card = A.spr_cards_SMW
		3.0:
			sprite_card = A.spr_cards_NSMBU
	s_card_top = A.spr_card_top
	disabled = 0.0
	image_speed = 0.0
	image_index = 0.0
	gravity = 0.0
	speed = 0.0
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 38.0)
	y = GM.camera_get_view_y(GM.view_get_camera(0))
	active = 0.0
	obj = 0.0
	value = 0.0
	x_pos = 38.0
	pos = 0.0
	obj_draw = 0.0
	bg_color = 0.0
	sun_disabled = 0.0
	obj_creation = 0.0
	effect_hover = 0.0
	etop = 0.0
	anim = 0.0
	obj_sonidos = 0.0
	obj_draw_sonidos = 0.0
	bg_color_sonidos = 0.0
	disabled_sonidos = 0.0


# from objects/obj_card_item/Step_0.gml
func _step() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_top)
	if GM.instance_exists(A.obj_card_block_sounds) and GM.instance_find(A.obj_card_block_sounds, 0).modo_sonidos == 1.0:
		sprite_card = A.spr_cards_sounds
		s_card_top = A.spr_cardtop_sounds
	else:
		match G.apariencia:
			0.0:
				sprite_card = A.spr_cards_SMB
			1.0:
				sprite_card = A.spr_cards_SMB3
			2.0:
				sprite_card = A.spr_cards_SMW
			3.0:
				sprite_card = A.spr_cards_NSMBU
		s_card_top = A.spr_card_top
	if GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0:
		var b = GM.instance_number(A.obj_bowser_res)
		var bjr = GM.instance_number(A.obj_bowserjr_res)
		var boss = (b + bjr)
		# ORIG-BUG: tuberia limit checks the door-lock card rather than the tuberia card.
		if (obj == A.obj_pink_coin_res and GM.instance_number(A.obj_pink_coin_res) > 4) or (obj == A.obj_angrysun_res and GM.instance_number(A.obj_angrysun_res) > 0) or (obj == A.obj_checkpoint_res and GM.instance_number(A.obj_checkpoint_res) > 0) or ((obj == A.obj_bowser_res or obj == A.obj_bowserjr_res) and boss > 2.0) or (obj == A.obj_boomboom_res and GM.instance_number(A.obj_boomboom_res) > 4) or (obj == A.obj_boomboom_b_res and GM.instance_number(A.obj_boomboom_b_res) > 4) or (obj == A.obj_door_res and GM.instance_number(A.obj_door_res) > 3) or (obj == A.obj_door_switch_res and GM.instance_number(A.obj_door_switch_res) > 3) or (obj == A.obj_door_lock_res and GM.instance_number(A.obj_door_lock_res) > 3) or (obj == A.obj_door_lock_res and GM.instance_number(A.obj_tuberia_res) > 10):
			if disabled == 0.0:
				disabled = 1.0
				G.select_resource = A.obj_resource_empty
			active = 0.0
		else:
			disabled = 0.0
	if active == 0.0:
		sprite_index = A.spr_card_item
	else:
		sprite_index = A.spr_card_item_selected


# from objects/obj_card_item/Draw_0.gml
func _gm_draw() -> void:
	if Scr.outside_view(self) > 0.5:
		return
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), ((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite(sprite_card, obj_draw, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), ((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top))
	GM.draw_sprite(s_card_top, bg_color, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), ((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top))
	if disabled == 1.0:
		GM.draw_sprite(A.spr_card_disabled, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), (GM.camera_get_view_y(GM.view_get_camera(0)) - GM.instance_find(A.obj_cursor, 0).anim_top))
	if effect_hover == 1.0 and disabled == 0.0:
		anim += 0.3
		GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), (((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top) + 6.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, ((GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos) + sprite_width), (((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top) + 6.0), 1.0, 1.0, 270.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), (((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top) + 27.0), 1.0, 1.0, 90.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, ((GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos) + sprite_width), (((GM.camera_get_view_y(GM.view_get_camera(0)) - etop) - GM.instance_find(A.obj_cursor, 0).anim_top) + 27.0), 1.0, 1.0, 180.0, GM.c_white, 1.0)


# from objects/obj_card_item/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_exists(A.obj_erase) and GM.instance_find(A.obj_erase, 0).active == 0.0 and disabled == 0.0:
		if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0) and obj_draw == A.obj_soplete_invert_global and GM.instance_number(A.obj_pink_coin) == 5:
			GM.audio_stop_sound(A.snd_wrong)
			GM.audio_play_sound(A.snd_wrong, 0.0, false)
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or (GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0 and (not GM.instance_exists(A.obj_edit_menu)))):
			if active == 0.0:
				GM.audio_play_sound(A.snd_select_tile, 0.0, false)

				for inst in GM.with_list(A.obj_erase):
					inst.active = 0.0
				image_index = 0.0
				if GM.instance_exists(A.obj_bg_selection):
					for inst in GM.with_list(A.obj_bg_selection):
						inst.instance_destroy()
				for inst in GM.with_list(A.obj_card_item):
					inst.active = 0.0
				active = 1.0
				G.select_resource = obj
				if obj != A.obj_angrysun:
					cont = 1.0
			elif active == 1.0:
				GM.audio_stop_sound(A.snd_select_tile)
				GM.audio_play_sound(A.snd_item_deselect, 0.0, false)
				for inst in GM.with_list(A.obj_card_item):
					inst.active = 0.0
				G.select_resource = A.obj_resource_empty
				active = 0.0
	else:
		GM.audio_play_sound(A.snd_wrong, 0.0, false)


# from objects/obj_card_item/Mouse_10.gml
func _mouse_10() -> void:
	if (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0) and disabled == 0.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (not GM.instance_exists(A.obj_edit_menu)):
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_pass_carditems)
			GM.audio_play_sound(A.snd_pass_carditems, 0.0, false)
		effect_hover = 1.0
		etop = 2.0


# from objects/obj_card_item/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
	etop = 0.0
