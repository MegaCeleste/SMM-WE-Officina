# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_oneway/scr_snd_oneway.gml
static func scr_snd_oneway(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_oneway
		1.0:
			return A.snd_SMB3_oneway
		2.0:
			return A.snd_oneway
		3.0:
			return A.snd_NSMBU_oneway
	return null
