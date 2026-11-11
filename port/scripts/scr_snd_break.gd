# from scripts/scr_snd_break/scr_snd_break.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_break/scr_snd_break.gml
static func scr_snd_break(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_break
		1.0:
			return A.snd_SMB3_break
		2.0:
			return A.snd_break
		3.0:
			return A.snd_NSMBU_break
	return null  # GML 走到结尾返回 undefined
