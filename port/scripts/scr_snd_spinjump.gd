# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_spinjump/scr_snd_spinjump.gml
static func scr_snd_spinjump(me: GMObject) -> Variant:
	match G.apariencia:
		2.0:
			return A.snd_spin
		3.0:
			return A.snd_NSMBU_spinjump
	return null  # GML 走到结尾返回 undefined
