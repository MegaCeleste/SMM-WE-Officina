# from objects/obj_anti_pblock（第 5 批移植，已核对）
# PORT: mysolid 的“没有”占位是 A.obj_lighting（int），判断统一用 is_same()，原因见 obj_pblock.gd 文件头。
extends "res://objects/obj_pblock.gd"


# from objects/obj_anti_pblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pblock
		1.0:
			sprite_index = A.spr_SMB3_pblock
		2.0:
			sprite_index = A.spr_pblock
		3.0:
			sprite_index = A.spr_NSMBU_pblock
	image_speed = 0.0
	image_index = 0.0
	mysolid = A.obj_lighting


# from objects/obj_anti_pblock/Destroy_0.gml
func _destroy() -> void:
	if not is_same(mysolid, A.obj_lighting):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()


# from objects/obj_anti_pblock/Step_0.gml
func _step() -> void:
	if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		if is_same(mysolid, A.obj_lighting):
			mysolid = GM.instance_create(x, y, A.obj_enabledsolid)
		image_index = 0.0
	else:
		if not is_same(mysolid, A.obj_lighting) and GM.instance_exists(mysolid):
			for inst in GM.with_list(mysolid):
				inst.instance_destroy()
			mysolid = A.obj_lighting
		image_index = 1.0
