# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_stun/scr_NSMBU_stun.gml
static func scr_NSMBU_stun(me: GMObject):
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_stun
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_stun
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_stun
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_stun
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_stun
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_stun
