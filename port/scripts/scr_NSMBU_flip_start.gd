# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_flip_start/scr_NSMBU_flip_start.gml
static func scr_NSMBU_flip_start(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_flip_start
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_flip_start
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_flip_start
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_flip_start
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_flip_start
		Scr.cs_penguin:
			return 3080.0
