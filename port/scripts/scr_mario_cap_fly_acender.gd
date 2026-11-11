# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_cap_fly_acender/scr_mario_cap_fly_acender.gml
static func scr_mario_cap_fly_acender(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_mario_cap_fly_acender
		1.0:
			return A.spr_luigi_cap_fly_acender
		2.0:
			return A.spr_toad_cap_fly_acender
		3.0:
			return A.spr_toadette_cap_fly_acender
	return null  # GML 走到结尾返回 undefined
