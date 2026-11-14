extends "res://objects/obj_parent_resource.gd"

var door_x: float = 0.0
var door_y: float = 0.0
var symbol: float = 0.0
var door_exit = null


# from objects/obj_door_res/Create_0.gml
func _create() -> void:
	super._create()
	exception = 1.0
	grid_selected = A.spr_grid_selected_16x32
	door_x = (x + 16.0)
	door_y = y
	if GM.instance_exists(A.obj_editormanager):
		if GM.instance_find(A.obj_editormanager, 0).door_symbol_1 == 0.0:
			symbol = 0.0
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_1 = 1.0
		elif GM.instance_find(A.obj_editormanager, 0).door_symbol_2 == 0.0:
			symbol = 1.0
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_2 = 1.0
		elif GM.instance_find(A.obj_editormanager, 0).door_symbol_3 == 0.0:
			symbol = 2.0
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_3 = 1.0
		elif GM.instance_find(A.obj_editormanager, 0).door_symbol_4 == 0.0:
			symbol = 3.0
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_4 = 1.0
		else:
			symbol = 0.0
	door_exit = 0.0
	alarm[1] = 1.0


# from objects/obj_door_res/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(door_exit, A.obj_lighting) and GM.instance_exists(door_exit):
		for inst in GM.with_list(door_exit):
			inst.instance_destroy()
	if GM.instance_exists(A.obj_editormanager):
		if symbol == 0.0:
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_1 = 0.0
		elif symbol == 1.0:
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_2 = 0.0
		elif symbol == 2.0:
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_3 = 0.0
		elif symbol == 3.0:
			for inst in GM.with_list(A.obj_editormanager):
				inst.door_symbol_4 = 0.0


# from objects/obj_door_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_door
		1.0:
			sprite_index = A.spr_SMB3_door
		2.0:
			sprite_index = A.spr_door
		3.0:
			sprite_index = A.spr_NSMBU_door
	if not GM.veq(door_exit, A.obj_lighting) and GM.instance_exists(door_exit):
		door_x = door_exit.x
		door_y = door_exit.y


# from objects/obj_door_res/Alarm_1.gml
func _alarm_1() -> void:
	door_exit = GM.instance_create(door_x, door_y, A.obj_door_exit_res)
	door_exit.id_return = self
	door_exit.symbol = symbol


# from objects/obj_door_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.sprite_index = A.spr_windows_3
		inst.id_object = self
		inst.index_object1 = 54.0
		inst.index_object2 = 55.0
		inst.index_object3 = 147.0
		inst.selected_1 = 1.0
		inst.selected_2 = 0.0
		inst.selected_3 = 0.0
		inst.number = 7.0


# from objects/obj_door_res/Other_11.gml
func _user_1() -> void:
	if transform != 0.0:
		if transform == 1.0 and GM.instance_number(A.obj_door_switch_res) < 4:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.door = 1.0
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_door_switch_res)):
				inst.door_x = self.door_x
				inst.door_y = self.door_y
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_door_res:
						inst.obj = A.obj_door_switch_res
						inst.obj_draw = 55.0
			instance_destroy()
		elif transform == 2.0 and GM.instance_number(A.obj_door_lock_res) < 4:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_effect_transform
				inst.image_speed = 0.3
			G.door = 2.0
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_door_lock_res)):
				inst.door_x = self.door_x
				inst.door_y = self.door_y
			if GM.instance_exists(A.obj_card_item):
				for inst in GM.with_list(A.obj_card_item):
					if inst.obj == A.obj_door_res:
						inst.obj = A.obj_door_lock_res
						inst.obj_draw = 147.0
			instance_destroy()


# from objects/obj_door_res/Draw_0.gml
func _gm_draw() -> void:
	super._gm_draw()
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		GM.draw_sprite(A.spr_door_symbols, symbol, x_draw, y_draw)
