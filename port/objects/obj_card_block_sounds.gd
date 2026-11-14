extends "res://objects/obj_panelsparent.gd"

var active: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var modo_sonidos: float = 0.0


# from objects/obj_card_block_sounds/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	active = 0.0
	effect_hover = 0.0
	anim = 0.0
	modo_sonidos = 0.0
	alarm[0] = 120.0


# from objects/obj_card_block_sounds/Step_0.gml
func _step() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0)
	y = ((GM.camera_get_view_y(GM.view_get_camera(0)) + 5.0) - GM.instance_find(A.obj_cursor, 0).anim_top)


# from objects/obj_card_block_sounds/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			inst.obj_sonidos = inst.obj
			inst.obj_draw_sonidos = inst.obj_draw
			inst.bg_color_sonidos = inst.bg_color
			inst.disabled_sonidos = inst.disabled
		for inst in GM.with_list(A.obj_card_item):
			match float(inst.value):
				0.0:
					if G.ubsi == 0.0:
						inst.obj = A.obj_ubsi_snd_res
						inst.obj_draw = 0.0
					else:
						inst.obj = A.obj_ahh_snd_res
						inst.obj_draw = 1.0
					inst.bg_color = 0.0
				1.0:
					if G.risas == 0.0:
						inst.obj = A.obj_risas_snd_res
						inst.obj_draw = 2.0
					else:
						inst.obj = A.obj_bebe_snd_res
						inst.obj_draw = 3.0
					inst.bg_color = 0.0
				2.0:
					if G.serpentina == 0.0:
						inst.obj = A.obj_serpentina_snd_res
						inst.obj_draw = 4.0
					else:
						inst.obj = A.obj_aplausos_snd_res
						inst.obj_draw = 5.0
					inst.bg_color = 0.0
				3.0:
					if G.uhh == 0.0:
						inst.obj = A.obj_uhh_snd_res
						inst.obj_draw = 6.0
					else:
						inst.obj = A.obj_auh_snd_res
						inst.obj_draw = 7.0
					inst.bg_color = 1.0
				4.0:
					if G.bocina == 0.0:
						inst.obj = A.obj_bocina_snd_res
						inst.obj_draw = 8.0
					else:
						inst.obj = A.obj_cerdito_snd_res
						inst.obj_draw = 9.0
					inst.bg_color = 1.0
				5.0:
					if G.bombilla == 0.0:
						inst.obj = A.obj_bombilla_snd_res
						inst.obj_draw = 10.0
					else:
						inst.obj = A.obj_error_snd_res
						inst.obj_draw = 11.0
					inst.bg_color = 2.0
				6.0:
					if G.nota == 0.0:
						inst.obj = A.obj_nota_musical_snd_res
						inst.obj_draw = 12.0
					else:
						inst.obj = A.obj_remolino_snd_res
						inst.obj_draw = 13.0
					inst.bg_color = 2.0
				7.0:
					if G.fuegos == 0.0:
						inst.obj = A.obj_fuegos_snd_res
						inst.obj_draw = 14.0
					else:
						inst.obj = A.obj_destello_snd_res
						inst.obj_draw = 15.0
					inst.bg_color = 3.0
				8.0:
					if G.nota == 0.0:
						inst.obj = A.obj_golpe_gato_snd_res
						inst.obj_draw = 16.0
					else:
						inst.obj = A.obj_chisporreteo_snd_res
						inst.obj_draw = 17.0
					inst.bg_color = 1.0
				9.0:
					inst.obj = A.obj_n64_snd_res
					inst.obj_draw = 18.0
					inst.bg_color = 4.0
				10.0:
					inst.obj = A.obj_bonus_snd_res
					inst.obj_draw = 20.0
					inst.bg_color = 4.0
				11.0:
					inst.obj = A.obj_boss_snd_res
					inst.obj_draw = 22.0
					inst.bg_color = 4.0


# from objects/obj_card_block_sounds/Other_11.gml
func _user_1() -> void:
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			inst.obj = inst.obj_sonidos
			inst.obj_draw = inst.obj_draw_sonidos
			inst.bg_color = inst.bg_color_sonidos
			inst.disabled = inst.disabled_sonidos


# from objects/obj_card_block_sounds/Other_12.gml
func _user_2() -> void:
	if modo_sonidos == 0.0:
		modo_sonidos = 1.0
		sprite_index = A.spr_card_block_sounds
		image_speed = 0.15
		for inst in GM.with_list(A.obj_levelmanager):
			inst.editor_sonidos = 1.0
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_modo_sonidos_control)
		_user_0()
	else:
		modo_sonidos = 0.0
		sprite_index = A.spr_card_block_blocks
		image_speed = 0.0
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 0.0
		for inst in GM.with_list(A.obj_levelmanager):
			inst.editor_sonidos = 0.0
		if GM.instance_exists(A.obj_modo_sonidos_control):
			for inst in GM.with_list(A.obj_modo_sonidos_control):
				inst.instance_destroy()
		_user_1()


# from objects/obj_card_block_sounds/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 5.0) - GM.instance_find(A.obj_cursor, 0).anim_top), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, (GM.camera_get_view_x(GM.view_get_camera(0)) + 6.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 5.0) - GM.instance_find(A.obj_cursor, 0).anim_top), anim, 2.0)


# from objects/obj_card_block_sounds/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 and (not GM.instance_exists(A.obj_ventana)) and (not GM.instance_exists(A.obj_apariencia)) and (not GM.instance_exists(A.obj_bg_selection)) and GM.instance_find(A.obj_creator_jugar_editar, 0).image_speed == 0.0:
		GM.audio_play_sound(A.snd_select_sounds, 0.0, false)
		for inst in GM.with_list(A.obj_card_item):
			inst.active = 0.0
		G.select_resource = A.obj_resource_empty
		_user_2()


# from objects/obj_card_block_sounds/Mouse_10.gml
func _mouse_10() -> void:
	if (GM.instance_find(A.obj_editormanager, 0).expand_open == 0.0 or GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_pase_bloque_sonido)
			GM.audio_play_sound(A.snd_pase_bloque_sonido, 0.0, false)
		effect_hover = 1.0


# from objects/obj_card_block_sounds/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
