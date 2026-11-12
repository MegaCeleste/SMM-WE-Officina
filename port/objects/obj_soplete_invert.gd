extends "res://objects/obj_soplete.gd"


# from objects/obj_soplete_invert/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			GM.aset(soplete, 0, A.spr_SMB_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB_soplete)
		1.0:
			GM.aset(soplete, 0, A.spr_SMB3_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB3_soplete)
		2.0:
			GM.aset(soplete, 0, A.spr_soplete_start)
			GM.aset(soplete, 1, A.spr_soplete)
		3.0:
			GM.aset(soplete, 0, A.spr_NSMBU_soplete_start)
			GM.aset(soplete, 1, A.spr_NSMBU_soplete)
	direct_t = 0.0
	rotacion = 0.0
	invisible = 1.0
	mysolid = GM.instance_create((x - 8.0), (y - 8.0), A.obj_solid)
	if not GM.instance_exists(A.obj_soplete_invert_global):
		GM.instance_create(0.0, 0.0, A.obj_soplete_invert_global)
	alarm[0] = 2.0


# from objects/obj_soplete_invert/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_soplete_invert_global):
		var g = GM.instance_find(A.obj_soplete_invert_global, 0)
		sprite_index = soplete[int(g.soplete_num)]
		image_index = g.image_index
		invisible = g.invisible
