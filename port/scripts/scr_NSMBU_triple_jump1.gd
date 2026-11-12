# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_triple_jump1/scr_NSMBU_triple_jump1.gml
static func scr_NSMBU_triple_jump1(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_triple_jump1
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_triple_jump1
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_triple_jump1
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_triple_jump1
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_triple_jump1
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_triple_jump1
