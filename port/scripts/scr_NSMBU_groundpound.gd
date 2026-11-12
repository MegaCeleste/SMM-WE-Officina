# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_groundpound/scr_NSMBU_groundpound.gml
static func scr_NSMBU_groundpound(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_groundpound
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_groundpound
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_groundpound
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_groundpound
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_groundpount
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_groundpount
