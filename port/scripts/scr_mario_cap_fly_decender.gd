# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_cap_fly_decender/scr_mario_cap_fly_decender.gml
static func scr_mario_cap_fly_decender(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_mario_cap_fly_decender
		1.0:
			return A.spr_luigi_cap_fly_decender
		2.0:
			return A.spr_toad_cap_fly_decender
		3.0:
			return A.spr_toadette_cap_fly_decender
	return null  # GML 走到结尾返回 undefined
