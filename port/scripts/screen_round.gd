# 第 4 批移植，已核对。
extends RefCounted


# from scripts/screen_round/screen_round.gml
static func screen_round(me: GMObject, value = null):
	return GM.gm_round(value * 4.0 / 4.0)
