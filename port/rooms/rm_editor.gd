extends RefCounted
## rm_editor 中的实例创建代码（Create 后、Room Start 前）。


static func install() -> void:
	GM.room_setup["rm_editor"] = _setup
	GM.room_inst_code["inst_186BE"] = _inst_186BE
	GM.room_inst_code["inst_186C2"] = _inst_186C2
	GM.room_inst_code["inst_186C3"] = _inst_186C3
	GM.room_inst_code["inst_186C4"] = _inst_186C4
	GM.room_inst_code["inst_186C5"] = _inst_186C5
	GM.room_inst_code["inst_186C6"] = _inst_186C6
	GM.room_inst_code["inst_186C7"] = _inst_186C7
	GM.room_inst_code["inst_186C8"] = _inst_186C8
	GM.room_inst_code["inst_186C9"] = _inst_186C9
	GM.room_inst_code["inst_186CA"] = _inst_186CA
	GM.room_inst_code["inst_186CB"] = _inst_186CB
	GM.room_inst_code["inst_186CC"] = _inst_186CC
	GM.room_inst_code["inst_186CD"] = _inst_186CD


# from rooms/rm_editor/rm_editor.yy: viewSettings and views[0]
static func _setup() -> void:
	GM.view_enabled = false
	GM.view_set_visible(0, false)
	GM.camera_set_view_target(0, null)
	GM.camera_set_view_pos(0, 0.0, 216.0)
	GM.camera_set_view_size(0, 1024.0, 768.0)
	GM.camera_set_view_border(0, 32.0, 32.0)
	GM.camera_set_view_speed(0, -1.0, -1.0)
	GM.view_set_wport(0, 1024.0)
	GM.view_set_hport(0, 768.0)


# from rooms/rm_editor/InstanceCreationCode_inst_186BE.gml
static func _inst_186BE(inst: GMObject) -> void:
	var me = inst
	me.editor = 1.0
	if G.levelguardabot == "":
		me.leveltime = 300.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C2.gml
static func _inst_186C2(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_pswitch_res
	me.value = 0.0
	me.x_pos = 38.0
	me.obj_draw = 117.0
	me.bg_color = 3.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C3.gml
static func _inst_186C3(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_spring_res
	me.value = 1.0
	me.x_pos = 64.0
	me.obj_draw = 128.0
	me.bg_color = 3.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C4.gml
static func _inst_186C4(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_pplant_res
	me.value = 2.0
	me.x_pos = 90.0
	me.obj_draw = 116.0
	me.bg_color = 2.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C5.gml
static func _inst_186C5(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_koopa_res
	me.value = 3.0
	me.x_pos = 116.0
	me.obj_draw = 94.0
	me.bg_color = 2.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C6.gml
static func _inst_186C6(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_goomba_res
	me.value = 4.0
	me.x_pos = 142.0
	me.obj_draw = 69.0
	me.bg_color = 2.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C7.gml
static func _inst_186C7(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_mushroom_res
	me.value = 5.0
	me.x_pos = 168.0
	me.obj_draw = 96.0
	me.bg_color = 1.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C8.gml
static func _inst_186C8(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_coin_res
	me.value = 6.0
	me.x_pos = 194.0
	me.obj_draw = 46.0
	me.bg_color = 1.0


# from rooms/rm_editor/InstanceCreationCode_inst_186C9.gml
static func _inst_186C9(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_rock_res
	me.value = 7.0
	me.x_pos = 220.0
	me.obj_draw = 17.0
	me.bg_color = 0.0


# from rooms/rm_editor/InstanceCreationCode_inst_186CA.gml
static func _inst_186CA(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_block_res
	me.value = 8.0
	me.x_pos = 246.0
	me.obj_draw = 64.0
	me.bg_color = 0.0


# from rooms/rm_editor/InstanceCreationCode_inst_186CB.gml
static func _inst_186CB(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_qblock_res
	me.value = 9.0
	me.x_pos = 272.0
	me.obj_draw = 93.0
	me.bg_color = 0.0


# from rooms/rm_editor/InstanceCreationCode_inst_186CC.gml
static func _inst_186CC(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_pinchos_res
	me.value = 10.0
	me.x_pos = 298.0
	me.obj_draw = 106.0
	me.bg_color = 0.0


# from rooms/rm_editor/InstanceCreationCode_inst_186CD.gml
static func _inst_186CD(inst: GMObject) -> void:
	var me = inst
	me.obj = A.obj_ground
	me.value = 11.0
	me.x_pos = 324.0
	me.obj_draw = 72.0
	me.bg_color = 0.0
