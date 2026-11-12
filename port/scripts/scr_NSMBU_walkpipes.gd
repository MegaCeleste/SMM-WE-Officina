# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_walkpipes/scr_NSMBU_walkpipes.gml
static func scr_NSMBU_walkpipes(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_walkpipes
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_walkpipes
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_walkpipes
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_walkpipes
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_walkpipes
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_walkpipes
