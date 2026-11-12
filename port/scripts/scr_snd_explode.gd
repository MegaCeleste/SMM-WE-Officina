# from scripts/scr_snd_explode/scr_snd_explode.gml
# 第 5 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_explode/scr_snd_explode.gml
static func scr_snd_explode(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_explode
		1.0:
			return A.snd_SMB3_explode
		2.0:
			return A.snd_explode
		3.0:
			return A.snd_NSMBU_explosion
	return null  # GML 走到结尾返回 undefined
