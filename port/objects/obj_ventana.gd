extends GMObject

var can_anim: float = 0.0
var can_anim2: float = 0.0
var anim: float = 0.0
var id_object = null
var index_object1: float = 0.0
var index_object2: float = 0.0
var index_object3: float = 0.0
var index_object4: float = 0.0
var selected_1: float = 0.0
var selected_2: float = 0.0
var selected_3: float = 0.0
var selected_4: float = 0.0
var s_contorno_1 = null
var s_paracaidas = null
var s_hongo_1 = null
var number: float = 0.0
var no_enable_move: float = 0.0


# from objects/obj_ventana/Create_0.gml
func _create() -> void:
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			inst.active = 0.0
	G.select_resource = A.obj_resource_empty
	for inst in GM.with_list(A.obj_editormanager):
		inst.expand_open = 2.0
	can_anim = 1.0
	can_anim2 = 0.0
	anim = 0.6
	id_object = A.obj_lighting
	index_object1 = 0.0
	index_object2 = 0.0
	index_object3 = 0.0
	index_object4 = 0.0
	selected_1 = 0.0
	selected_2 = 1.0
	selected_3 = 0.0
	selected_4 = 0.0
	s_contorno_1 = 0.0
	s_paracaidas = 0.0
	s_hongo_1 = 0.0
	number = 5.0
	GM.audio_play_sound(A.snd_open_windows, 0.0, false)
	no_enable_move = 0.0


# from objects/obj_ventana/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_window_button):
		for inst in GM.with_list(A.obj_window_button):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_button_wings):
		for inst in GM.with_list(A.obj_button_wings):
			inst.instance_destroy()
	for inst in GM.with_list(A.obj_editormanager):
		inst.alarm[0] = 10.0


# from objects/obj_ventana/Step_2.gml
func _step_end() -> void:
	if can_anim == 1.0:
		if anim < 1.0:
			anim += 0.08
		else:
			match number:
				1.0:
					_user_9()
				2.0:
					_user_3()
				2.1:
					_user_5()
				3.0:
					_user_1()
				3.1:
					_user_2()
				3.2:
					_user_8()
				4.0:
					_user_4()
				6.0:
					_user_6()
				7.0:
					_user_7()
				9.0:
					_user_9()
				10.0:
					_user_10()
				11.0:
					_user_11()
				12.0:
					_user_12()
				13.0:
					_user_13()
				14.0:
					_user_14()
				_:
					_user_0()
			anim = 1.0
			can_anim = 0.0
		image_xscale = anim
		image_yscale = anim
	if can_anim2 == 1.0:
		if GM.instance_exists(A.obj_window_button):
			for inst in GM.with_list(A.obj_window_button):
				inst.instance_destroy()
		if GM.instance_exists(A.obj_button_wings):
			for inst in GM.with_list(A.obj_button_wings):
				inst.instance_destroy()
		if anim > 0.6:
			anim -= 0.1
		else:
			instance_destroy()
		image_xscale = anim
		image_yscale = anim


# from objects/obj_ventana/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 142.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 0.0
		inst.s_contorno = self.s_hongo_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas


# from objects/obj_ventana/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 0.0
		inst.s_contorno = self.s_hongo_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas


# from objects/obj_ventana/Other_12.gml
func _user_2() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas


# from objects/obj_ventana/Other_13.gml
func _user_3() -> void:
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas


# from objects/obj_ventana/Other_14.gml
func _user_4() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas


# from objects/obj_ventana/Other_15.gml
func _user_5() -> void:
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2


# from objects/obj_ventana/Other_16.gml
func _user_6() -> void:
	for inst in GM.with_list(GM.instance_create((x - 142.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
		inst.transform = 0.0
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
		inst.transform = 1.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object3
		inst.image_index = self.selected_3
		inst.transform = 2.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object4
		inst.image_index = self.selected_4
		inst.transform = 3.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = 183.0
		inst.image_index = 0.0
		inst.transform = 4.0


# from objects/obj_ventana/Other_17.gml
func _user_7() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
		inst.transform = 0.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
		inst.transform = 1.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object3
		inst.image_index = self.selected_3
		inst.transform = 2.0


# from objects/obj_ventana/Other_18.gml
func _user_8() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1


# from objects/obj_ventana/Other_19.gml
func _user_9() -> void:
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1


# from objects/obj_ventana/Other_20.gml
func _user_10() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 3.0
		inst.s_contorno = self.s_contorno_1


# from objects/obj_ventana/Other_21.gml
func _user_11() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
		inst.transform = 0.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
		inst.transform = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object3
		inst.image_index = self.selected_3
		inst.transform = 2.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object4
		inst.image_index = self.selected_4
		inst.transform = 3.0


# from objects/obj_ventana/Other_22.gml
func _user_12() -> void:
	for inst in GM.with_list(GM.instance_create((x - 167.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 0.0
		inst.s_contorno = self.s_hongo_1
	for inst in GM.with_list(GM.instance_create((x - 142.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
		inst.transform = 0.0
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
		inst.transform = 1.0
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object3
		inst.image_index = self.selected_3
		inst.transform = 2.0
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object4
		inst.image_index = self.selected_4
		inst.transform = 3.0


# from objects/obj_ventana/Other_23.gml
func _user_13() -> void:
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 0.0
		inst.s_contorno = self.s_hongo_1
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2


# from objects/obj_ventana/Other_24.gml
func _user_14() -> void:
	for inst in GM.with_list(GM.instance_create((x - 117.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 1.0
		inst.s_contorno = self.s_contorno_1
	for inst in GM.with_list(GM.instance_create((x - 92.0), (y - 39.0), A.obj_button_wings)):
		inst.id_object = self.id_object
		inst.s_index = 2.0
		inst.s_contorno = self.s_paracaidas
	for inst in GM.with_list(GM.instance_create((x - 67.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object1
		inst.image_index = self.selected_1
	for inst in GM.with_list(GM.instance_create((x - 42.0), (y - 39.0), A.obj_window_button)):
		inst.id_object = self.id_object
		inst.index_object = self.index_object2
		inst.image_index = self.selected_2
