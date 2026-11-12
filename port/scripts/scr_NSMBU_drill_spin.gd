# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_drill_spin/scr_NSMBU_drill_spin.gml
static func scr_NSMBU_drill_spin(me: GMObject):
	match G.powerup:
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_drill_spin
		Scr.cs_fire:
			return A.spr_NSMBU_mario_big_drill_spin
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_drill_spin
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_big_drill_spin
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_big_drill_spin
