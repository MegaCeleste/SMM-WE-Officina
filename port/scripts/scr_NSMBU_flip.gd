# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_flip/scr_NSMBU_flip.gml
static func scr_NSMBU_flip(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_flip
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_flip
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_flip
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_flip
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_flip
		Scr.cs_penguin:
			return 3229.0
