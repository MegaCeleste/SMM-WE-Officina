# 第 7 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_door_close/scr_snd_door_close.gml
static func scr_snd_door_close(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_door_close
		1.0:
			return A.snd_SMB3_door_close
		2.0:
			return A.snd_door_close
		3.0:
			return A.snd_NSMBU_door_close
	return null
