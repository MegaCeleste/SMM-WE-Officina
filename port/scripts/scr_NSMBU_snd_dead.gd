# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_snd_dead/scr_NSMBU_snd_dead.gml
static func scr_NSMBU_snd_dead(me: GMObject, argument0 = null) -> Variant:
	match argument0:
		0.0:
			return A.snd_NSMBU_dead
		1.0:
			return A.snd_NSMBU_dead_veneno
		2.0:
			return A.snd_NSMBU_dead_lava
	return null  # GML 走到结尾返回 undefined
