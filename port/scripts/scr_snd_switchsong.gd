# from scripts/scr_snd_switchsong/scr_snd_switchsong.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_switchsong/scr_snd_switchsong.gml
static func scr_snd_switchsong(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_switchsong
		1.0:
			return A.snd_SMB3_switchsong
		2.0:
			return A.snd_switchsong
		3.0:
			return A.snd_NSMBU_switchsong
	return null  # GML 走到结尾返回 undefined
