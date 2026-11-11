# from scripts/scr_snd_sprout/scr_snd_sprout.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_sprout/scr_snd_sprout.gml
static func scr_snd_sprout(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_sprout
		1.0:
			return A.snd_SMB3_sprout
		2.0:
			return A.snd_sprout
		3.0:
			return A.snd_NSMBU_sprout
	return null  # GML 走到结尾返回 undefined
