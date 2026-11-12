# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_hold_spinjump/scr_NSMBU_hold_spinjump.gml
static func scr_NSMBU_hold_spinjump(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_hold_spinjump
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_hold_spinjump
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_hold_spinjump
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_hold_spinjump
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_hold_spinjump
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_hold_spinjump
