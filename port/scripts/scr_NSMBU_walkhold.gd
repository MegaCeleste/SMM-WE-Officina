# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_walkhold/scr_NSMBU_walkhold.gml
static func scr_NSMBU_walkhold(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_walkhold
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_walkhold
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_walkhold
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_walkhold
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_walkhold
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_walkhold
