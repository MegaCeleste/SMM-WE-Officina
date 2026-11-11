# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_cap_fly/scr_mario_cap_fly.gml
static func scr_mario_cap_fly(me: GMObject) -> Variant:
	match G.jugador:
		0.0:
			return A.spr_mario_cap_fly
		1.0:
			return A.spr_luigi_cap_fly
		2.0:
			return A.spr_toad_cap_fly
		3.0:
			return A.spr_toadette_cap_fly
	return null  # GML 走到结尾返回 undefined
