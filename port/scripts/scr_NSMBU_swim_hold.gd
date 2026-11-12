# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_swim_hold/scr_NSMBU_swim_hold.gml
static func scr_NSMBU_swim_hold(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_swim_hold
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_swim_hold
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_swim_hold
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_swim_hold
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_swim_hold
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_swim_hold
