# from objects/obj_chain_chomp_free_b（第 6e 批移植，已核对）
extends "res://objects/obj_chain_chomp_free.gd"


# from objects/obj_chain_chomp_free_b/Create_0.gml
func _create() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_chainchomp_night_b
			else:
				sprite_index = A.spr_SMB_chainchomp_b
			s_chain = A.spr_SMB_chain_b
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_chainchomp_night_b
			else:
				sprite_index = A.spr_SMB3_chainchomp_b
			s_chain = A.spr_SMB3_chain_b
		2.0:
			sprite_index = A.spr_chainchomp_b
			s_chain = A.spr_chain_b
		3.0:
			sprite_index = A.spr_NSMBU_chainchomp_b
			s_chain = A.spr_NSMBU_chain_b
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	modo_lava = 0.0
	wings = 0.0
	swimming = 0.0
	paracaidas = 0.0
	fallow_chomp = 1.0
	apilar = 0.0
	sound = 0.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.15
	followers = 5.0
	closeness = 14.0
	amount_previous = 80.0
	i = 0.0
	while i < amount_previous:
		GM.aset(oldx, int(i), x)
		GM.aset(oldy, int(i), y)
		i += 1.0
