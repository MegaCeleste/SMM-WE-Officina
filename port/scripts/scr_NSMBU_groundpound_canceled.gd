# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_groundpound_canceled/scr_NSMBU_groundpound_canceled.gml
static func scr_NSMBU_groundpound_canceled(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_groundpound_canceled
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_groundpound_canceled
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_groundpound_canceled
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_groundpound_canceled
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_groundpound_canceled
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_groundpound_canceled
