# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_swim/scr_swim.gml
static func scr_swim(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_step_enemy
		1.0:
			return A.snd_step_enemy
		2.0:
			return A.snd_swim
		3.0:
			return A.snd_NSMBU_swim
	return null  # GML 走到结尾返回 undefined
