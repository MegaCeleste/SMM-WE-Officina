# from scripts/scr_snd_spring/scr_snd_spring.gml
# 第 5 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_spring/scr_snd_spring.gml
static func scr_snd_spring(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_spring
		1.0:
			return A.snd_SMB3_spring
		2.0:
			return A.snd_spring
		3.0:
			return A.snd_NSMBU_spring
	return null  # GML 走到结尾返回 undefined
