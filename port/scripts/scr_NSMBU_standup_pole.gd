# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_standup_pole/scr_NSMBU_standup_pole.gml
static func scr_NSMBU_standup_pole(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_standup_pole
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_standup_pole
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_standup_pole
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_standup_pole
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_standup_pole
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_standup_pole
