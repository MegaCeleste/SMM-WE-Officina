# from scripts/scr_snd_hurryup/scr_snd_hurryup.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_hurryup/scr_snd_hurryup.gml
static func scr_snd_hurryup(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB_hurryup
		1.0:
			return A.snd_SMB3_hurryup
		2.0:
			return A.snd_hurryup
		3.0:
			return A.snd_NSMBU_hurryup
	return null
