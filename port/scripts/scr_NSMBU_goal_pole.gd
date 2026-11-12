# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_goal_pole/scr_NSMBU_goal_pole.gml
static func scr_NSMBU_goal_pole(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_goalpole
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_goalpole
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_goalpole
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_goalpole
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_goalpole
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_goalpole
