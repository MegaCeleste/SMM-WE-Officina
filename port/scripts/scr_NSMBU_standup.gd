# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_standup/scr_NSMBU_standup.gml
static func scr_NSMBU_standup(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_standup
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_standup
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_standup
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_standup
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_standup
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_standup
