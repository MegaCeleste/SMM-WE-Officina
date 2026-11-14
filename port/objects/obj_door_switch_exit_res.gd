extends "res://objects/obj_parent_resource.gd"

var update: float = 0.0
var symbol: float = 0.0
var id_return = null


# from objects/obj_door_switch_exit_res/Create_0.gml
func _create() -> void:
	super._create()
	exception = 1.0
	update = 1.0
	grid_selected = A.spr_grid_selected_16x32
	symbol = 0.0
	id_return = 0.0


# from objects/obj_door_switch_exit_res/Destroy_0.gml
func _destroy() -> void:
	if not GM.veq(id_return, A.obj_lighting) and GM.instance_exists(id_return):
		for inst in GM.with_list(id_return):
			inst.instance_destroy()
	if update == 1.0:
		if GM.instance_exists(A.obj_editormanager):
			if symbol == 0.0:
				for inst in GM.with_list(A.obj_editormanager):
					inst.door_p_symbol_1 = 0.0
			elif symbol == 1.0:
				for inst in GM.with_list(A.obj_editormanager):
					inst.door_p_symbol_2 = 0.0
			elif symbol == 2.0:
				for inst in GM.with_list(A.obj_editormanager):
					inst.door_p_symbol_3 = 0.0
			elif symbol == 3.0:
				for inst in GM.with_list(A.obj_editormanager):
					inst.door_p_symbol_4 = 0.0


# from objects/obj_door_switch_exit_res/Step_2.gml
func _step_end() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_door_switch
		1.0:
			sprite_index = A.spr_SMB3_door_switch
		2.0:
			sprite_index = A.spr_door_switch
		3.0:
			sprite_index = A.spr_NSMBU_door_switch


# from objects/obj_door_switch_exit_res/Draw_0.gml
func _gm_draw() -> void:
	super._gm_draw()
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		GM.draw_sprite(A.spr_door_symbols, symbol, x_draw, y_draw)
