# from scripts/scr_snd_thwomp/scr_snd_thwomp.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_thwomp/scr_snd_thwomp.gml
static func scr_snd_thwomp(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_thwomp_original
		1.0:
			return A.snd_SMB3_thwomp_original
		2.0:
			return A.snd_thwomp_original
		3.0:
			return A.snd_NSMBU_thwomp_original
	return null
