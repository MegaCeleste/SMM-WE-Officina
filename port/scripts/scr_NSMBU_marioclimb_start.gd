# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_marioclimb_start/scr_NSMBU_marioclimb_start.gml
static func scr_NSMBU_marioclimb_start(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_climb_start
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_climb_start
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_climb_start
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_climb_start
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_climb_start
