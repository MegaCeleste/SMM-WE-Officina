extends "res://objects/obj_parent_resource.gd"


# from objects/obj_hammerbro_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 19.0
	wings_y = 22.0
	para_x = 3.0
	para_y = 16.0


# from objects/obj_hammerbro_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_hammerbro_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_5
		inst.id_object = self
		inst.index_object1 = 86.0
		inst.index_object2 = 222.0
		inst.index_object3 = 223.0
		inst.index_object4 = 224.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.selected_3 = 0.0
		inst.selected_4 = 0.0
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 0.0
		inst.number = 12.0


# from objects/obj_hammerbro_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.brothers = transform
	match transform:
		1.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_firebro_res)):
				inst.wings = self.wings
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_hammerbro_res:
						inst.obj = A.obj_firebro_res
						inst.obj_draw = 222.0
		2.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_icebro_res)):
				inst.wings = self.wings
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_hammerbro_res:
						inst.obj = A.obj_icebro_res
						inst.obj_draw = 223.0
		3.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_boomerangbro_res)):
				inst.wings = self.wings
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_hammerbro_res:
						inst.obj = A.obj_boomerangbro_res
						inst.obj_draw = 224.0
	instance_destroy()


# from objects/obj_hammerbro_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	G.hammerbro = 1.0
	for inst in GM.with_list(GM.instance_create((x + 16.0), y, A.obj_sledgebro_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_hammerbro_res:
				inst.obj = A.obj_sledgebro_res
				inst.obj_draw = 124.0
	instance_destroy()
