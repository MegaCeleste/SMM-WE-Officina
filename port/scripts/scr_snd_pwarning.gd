# from scripts/scr_snd_pwarning/scr_snd_pwarning.gml
# 第 5 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_pwarning/scr_snd_pwarning.gml
static func scr_snd_pwarning(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_explode
		1.0:
			return A.snd_SMB3_explode
		3.0:
			return A.snd_NSMBU_switch
		_:
			return A.snd_door_close
