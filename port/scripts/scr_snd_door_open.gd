# 第 7 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_door_open/scr_snd_door_open.gml
static func scr_snd_door_open(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_door_open
		1.0:
			return A.snd_SMB3_door_open
		2.0:
			return A.snd_door
		3.0:
			return A.snd_NSMBU_door_open
	return null
