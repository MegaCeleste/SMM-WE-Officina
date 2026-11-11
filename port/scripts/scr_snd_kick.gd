# from scripts/scr_snd_kick/scr_snd_kick.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_kick/scr_snd_kick.gml
static func scr_snd_kick(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB_kick
		1.0:
			return A.snd_SMB3_kick
		2.0:
			return A.snd_klock
		3.0:
			return A.snd_NSMBU_kick
	return null  # GML 走到结尾返回 undefined
