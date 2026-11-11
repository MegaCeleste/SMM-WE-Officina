# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_skid/scr_snd_skid.gml
static func scr_snd_skid(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_skid
		1.0:
			return A.snd_SMB3_skid
		2.0:
			return A.snd_skid
		3.0:
			return A.snd_NSMBU_skid
	return null  # GML 走到结尾返回 undefined
