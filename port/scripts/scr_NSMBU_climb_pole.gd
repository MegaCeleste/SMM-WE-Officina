# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_climb_pole/scr_NSMBU_climb_pole.gml
static func scr_NSMBU_climb_pole(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_climb_pole
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_climb_pole
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_climb_pole
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_climb_pole
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_climb_pole
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_climb_pole
