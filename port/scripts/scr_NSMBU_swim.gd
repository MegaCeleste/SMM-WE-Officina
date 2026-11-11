# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_swim/scr_NSMBU_swim.gml
static func scr_NSMBU_swim(me: GMObject) -> Variant:
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_swim
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_swim
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_swim
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_swim
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_swim
	return null  # GML 走到结尾返回 undefined
