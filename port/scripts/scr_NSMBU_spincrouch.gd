# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_spincrouch/scr_NSMBU_spincrouch.gml
static func scr_NSMBU_spincrouch(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_spincrouch
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_spincrouch
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_spincrouch
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_spinjump
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_spinjump
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_spincrouch
