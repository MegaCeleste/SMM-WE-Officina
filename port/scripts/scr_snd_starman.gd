# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_starman/scr_snd_starman.gml
static func scr_snd_starman(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB_starman
		1.0:
			return A.snd_SMB3_starman
		2.0:
			return A.snd_starman
		3.0:
			return A.snd_NSMBU_starman
	return null  # GML 走到结尾返回 undefined
