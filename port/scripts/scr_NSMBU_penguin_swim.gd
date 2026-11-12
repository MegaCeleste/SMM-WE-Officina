# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_penguin_swim/scr_NSMBU_penguin_swim.gml
static func scr_NSMBU_penguin_swim(me: GMObject, argument0 = null):
	match argument0:
		0.0:
			return A.spr_NSMBU_mario_penguin_swim
