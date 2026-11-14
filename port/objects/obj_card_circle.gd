extends GMObject

var obj = null
var value: float = 0.0
var disabled: float = 0.0
var active: float = 0.0
var draw_hover: float = 0.0
var id_card_0 = null
var id_card_1 = null
var id_card_2 = null
var id_card_3 = null
var id_card_4 = null
var id_card_5 = null
var id_card_6 = null
var id_card_7 = null
var id_card_8 = null
var id_card_9 = null
var id_card_10 = null
var id_card_11 = null


# from objects/obj_card_circle/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_cards_SMB
		1.0:
			sprite_index = A.spr_cards_SMB3
		2.0:
			sprite_index = A.spr_cards_SMW
		3.0:
			sprite_index = A.spr_cards_NSMBU
		4.0:
			sprite_index = A.spr_cards_SMB2
	image_speed = 0.0
	image_index = 0.0
	obj = A.obj_ground
	value = 0.0
	disabled = 0.0
	active = 0.0
	if GM.instance_find(A.obj_panel_circle, 0).type == 0.0:
		draw_hover = A.spr_panel_circle_superfiies
	elif GM.instance_find(A.obj_panel_circle, 0).type == 1.0:
		draw_hover = A.spr_panel_circle_objetos
	elif GM.instance_find(A.obj_panel_circle, 0).type == 2.0:
		if GM.instance_find(A.obj_panel_circle, 0).sprite_index == A.spr_panel_circle_7:
			draw_hover = A.spr_panel_circle_enemigos2
		else:
			draw_hover = A.spr_panel_circle_enemigos
	elif GM.instance_find(A.obj_panel_circle, 0).type == 3.0:
		if GM.instance_find(A.obj_panel_circle, 0).sprite_index == A.spr_panel_circle_7:
			draw_hover = A.spr_panel_circle_artilugios2
		else:
			draw_hover = A.spr_panel_circle_artilugios


# from objects/obj_card_circle/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(A.snd_circle_1)
	GM.audio_stop_sound(A.snd_circle_2)
	GM.audio_stop_sound(A.snd_circle_3)
	GM.audio_stop_sound(A.snd_circle_4)
	GM.audio_stop_sound(A.snd_circle_5)
	GM.audio_stop_sound(A.snd_circle_6)
	GM.audio_stop_sound(A.snd_circle_7)
	GM.audio_stop_sound(A.snd_circle_8)
	if value == 0.0:
		GM.audio_play_sound(A.snd_circle_1, 0.0, false)
	elif value == 1.0:
		GM.audio_play_sound(A.snd_circle_2, 0.0, false)
	elif value == 2.0:
		GM.audio_play_sound(A.snd_circle_3, 0.0, false)
	elif value == 3.0:
		GM.audio_play_sound(A.snd_circle_4, 0.0, false)
	elif value == 4.0:
		GM.audio_play_sound(A.snd_circle_5, 0.0, false)
	elif value == 5.0:
		GM.audio_play_sound(A.snd_circle_6, 0.0, false)
	elif value == 6.0:
		GM.audio_play_sound(A.snd_circle_7, 0.0, false)
	elif value == 7.0 or value == 8.0 or value == 9.0:
		GM.audio_play_sound(A.snd_circle_8, 0.0, false)


# from objects/obj_card_circle/Draw_0.gml
func _gm_draw() -> void:
	if active == 1.0 and disabled == 0.0:
		GM.draw_sprite(draw_hover, value, GM.instance_find(A.obj_panel_circle, 0).x, GM.instance_find(A.obj_panel_circle, 0).y)
	draw_self()
	if disabled == 1.0:
		GM.draw_sprite(A.spr_card_circle_disabled, 0.0, x, (y + 6.0))


# from objects/obj_card_circle/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and disabled == 0.0:
		for inst in GM.with_list(A.obj_card_item):
			if inst.value == 0.0:
				self.id_card_0 = inst
			if inst.value == 1.0:
				self.id_card_1 = inst
			if inst.value == 2.0:
				self.id_card_2 = inst
			if inst.value == 3.0:
				self.id_card_3 = inst
			if inst.value == 4.0:
				self.id_card_4 = inst
			if inst.value == 5.0:
				self.id_card_5 = inst
			if inst.value == 6.0:
				self.id_card_6 = inst
			if inst.value == 7.0:
				self.id_card_7 = inst
			if inst.value == 8.0:
				self.id_card_8 = inst
			if inst.value == 9.0:
				self.id_card_9 = inst
			if inst.value == 10.0:
				self.id_card_10 = inst
			if inst.value == 11.0:
				self.id_card_11 = inst
		if obj != id_card_0.obj and obj != id_card_1.obj and obj != id_card_2.obj and obj != id_card_3.obj and obj != id_card_4.obj and obj != id_card_5.obj and obj != id_card_6.obj and obj != id_card_7.obj and obj != id_card_8.obj and obj != id_card_9.obj and obj != id_card_10.obj and obj != id_card_11.obj:
			for inst in GM.with_list(id_card_0):
				inst.obj = self.id_card_1.obj
				inst.obj_draw = self.id_card_1.obj_draw
				inst.bg_color = self.id_card_1.bg_color
			for inst in GM.with_list(id_card_1):
				inst.obj = self.id_card_2.obj
				inst.obj_draw = self.id_card_2.obj_draw
				inst.bg_color = self.id_card_2.bg_color
			for inst in GM.with_list(id_card_2):
				inst.obj = self.id_card_3.obj
				inst.obj_draw = self.id_card_3.obj_draw
				inst.bg_color = self.id_card_3.bg_color
			for inst in GM.with_list(id_card_3):
				inst.obj = self.id_card_4.obj
				inst.obj_draw = self.id_card_4.obj_draw
				inst.bg_color = self.id_card_4.bg_color
			for inst in GM.with_list(id_card_4):
				inst.obj = self.id_card_5.obj
				inst.obj_draw = self.id_card_5.obj_draw
				inst.bg_color = self.id_card_5.bg_color
			for inst in GM.with_list(id_card_5):
				inst.obj = self.id_card_6.obj
				inst.obj_draw = self.id_card_6.obj_draw
				inst.bg_color = self.id_card_6.bg_color
			for inst in GM.with_list(id_card_6):
				inst.obj = self.id_card_7.obj
				inst.obj_draw = self.id_card_7.obj_draw
				inst.bg_color = self.id_card_7.bg_color
			for inst in GM.with_list(id_card_7):
				inst.obj = self.id_card_8.obj
				inst.obj_draw = self.id_card_8.obj_draw
				inst.bg_color = self.id_card_8.bg_color
			for inst in GM.with_list(id_card_8):
				inst.obj = self.id_card_9.obj
				inst.obj_draw = self.id_card_9.obj_draw
				inst.bg_color = self.id_card_9.bg_color
			for inst in GM.with_list(id_card_9):
				inst.obj = self.id_card_10.obj
				inst.obj_draw = self.id_card_10.obj_draw
				inst.bg_color = self.id_card_10.bg_color
			for inst in GM.with_list(id_card_10):
				inst.obj = self.id_card_11.obj
				inst.obj_draw = self.id_card_11.obj_draw
				inst.bg_color = self.id_card_11.bg_color
			for inst in GM.with_list(A.obj_card_item):
				inst.active = 0.0
			for inst in GM.with_list(id_card_11):
				inst.obj = self.obj
				inst.obj_draw = self.image_index
				if GM.instance_find(A.obj_panel_circle, 0).type == 0.0:
					inst.bg_color = 0.0
				elif GM.instance_find(A.obj_panel_circle, 0).type == 1.0:
					inst.bg_color = 1.0
				elif GM.instance_find(A.obj_panel_circle, 0).type == 2.0:
					inst.bg_color = 2.0
				elif GM.instance_find(A.obj_panel_circle, 0).type == 3.0:
					inst.bg_color = 3.0
				if self.obj == A.obj_pink_coin and GM.instance_number(A.obj_pink_coin) == 5:
					pass
				elif self.obj != A.obj_angrysun:
					inst.active = 1.0
			for inst in GM.with_list(A.obj_cursor):
				inst.item_add_temp = self.obj
				inst.alarm[0] = 15.0
			GM.audio_play_sound(A.snd_select_tile, 0.0, false)
			for inst in GM.with_list(A.obj_cursor):
				if inst.cont_panel_right == 3.0:
					inst.cont_panel_right = 2.0
				if inst.cont_panel_left == 3.0:
					inst.cont_panel_left = 2.0
				if inst.cont_panel_top == 3.0:
					inst.cont_panel_top = 2.0
				inst.cont_panel_creator = 2.0
			for inst in GM.with_list(A.obj_expand):
				inst.visible = true
			for inst in GM.with_list(A.obj_panel_expand):
				inst.instance_destroy()
		else:
			GM.audio_play_sound(A.snd_wrong, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_wrong, 0.0, false)


# from objects/obj_card_circle/Mouse_10.gml
func _mouse_10() -> void:
	if active == 0.0 and disabled == 0.0:
		_user_0()
		active = 1.0
		for inst in GM.with_list(A.obj_panel_circle):
			inst.image_selected = self.image_index


# from objects/obj_card_circle/Mouse_11.gml
func _mouse_11() -> void:
	active = 0.0
