# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_swim_fall/scr_NSMBU_swim_fall.gml
static func scr_NSMBU_swim_fall(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_swim_fall
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_swim_fall
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_swim_fall
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_swim_fall
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_swim_fall
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_swim_idle
