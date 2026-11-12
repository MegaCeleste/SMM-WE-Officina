# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_arcon_fly_start/scr_arcon_fly_start.gml
static func scr_arcon_fly_start(me: GMObject):
	if me.get("holding") == 2.0:
		return A.spr_NSMBU_mario_arcon_flyhold_start
	else:
		return A.spr_NSMBU_mario_arcon_fly_start
