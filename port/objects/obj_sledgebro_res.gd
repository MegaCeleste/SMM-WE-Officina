extends "res://objects/obj_parent_resource.gd"


# from objects/obj_sledgebro_res/Create_0.gml
func _create() -> void:
	super._create()
	grid_selected = A.spr_grid_selected_32x32_2
	wings_x = 15.0
	wings_y = 28.0
	para_x = 0.0
	para_y = 18.0


# from objects/obj_sledgebro_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		image_index = G.apariencia


# from objects/obj_sledgebro_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.s_contorno_1 = self.wings
		inst.s_hongo_1 = 1.0
		inst.s_paracaidas = self.paracaidas
		inst.number = 3.0


# from objects/obj_sledgebro_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
	G.hammerbro = 0.0
	for inst in GM.with_list(GM.instance_create((x - 16.0), y, A.obj_hammerbro_res)):
		inst.wings = self.wings
		inst.paracaidas = self.paracaidas
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.obj == A.obj_sledgebro_res:
				inst.obj = A.obj_hammerbro_res
				inst.obj_draw = 86.0
	instance_destroy()
