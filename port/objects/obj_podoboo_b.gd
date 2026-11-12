extends "res://objects/obj_podoboo.gd"


# from objects/obj_podoboo_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_podoboo_b
			image_speed = 0.2
		1.0:
			sprite_index = A.spr_SMB3_podoboo_b
			image_speed = 0.2
		2.0:
			sprite_index = A.spr_podoboo_b
			image_speed = 0.2
		3.0:
			sprite_index = A.spr_NSMBU_podoboo_b
			image_speed = 0.3
	hardness = 100.0
	stomp = 2.0
	edible = 1.0
	modo_lava = 0.0
	direct = 1.0
	ready_v = 0.0
	dead_h = 0.0
	swimming = 0.0
	innave = 0.0
	wings = 0.0
	w_wings = 0.0
	paracaidas = 0.0
	rot = 2.0
	rotacion = 180.0
	apilar = 0.0
	alarm[10] = 1.0
