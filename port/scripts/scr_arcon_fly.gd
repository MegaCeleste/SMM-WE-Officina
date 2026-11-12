# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_arcon_fly/scr_arcon_fly.gml
static func scr_arcon_fly(me: GMObject):
	if me.get("holding") == 2.0:
		return A.spr_NSMBU_mario_arcon_flyhold
	else:
		return A.spr_NSMBU_mario_arcon_fly
