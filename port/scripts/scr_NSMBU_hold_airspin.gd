# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_hold_airspin/scr_NSMBU_hold_airspin.gml
static func scr_NSMBU_hold_airspin(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_hold_airspin
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_hold_airspin
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_hold_airspin
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_hold_airspin
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_hold_airspin
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_hold_airspin
