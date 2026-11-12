# 第 7 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_getcheckpoint/scr_snd_getcheckpoint.gml
static func scr_snd_getcheckpoint(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_whistle
		1.0:
			return A.snd_SMB3_whistle
		2.0:
			return A.snd_whistle
		3.0:
			return A.snd_NSMBU_whistle
	return null
