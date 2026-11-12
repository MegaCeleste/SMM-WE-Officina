# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_kick/scr_NSMBU_kick.gml
static func scr_NSMBU_kick(me: GMObject, argument0 = null):
	if argument0 == 1.0:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_swim_kick
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_swim_kick
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_swim_kick
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_swim_kick
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_kick
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_swim_kick
	else:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_kick
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_kick
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_kick
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_kick
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_kick
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_kick
