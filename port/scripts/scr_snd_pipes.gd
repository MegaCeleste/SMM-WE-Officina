# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_pipes/scr_snd_pipes.gml
static func scr_snd_pipes(me: GMObject):
	match G.apariencia:
		0.0:
			return A.snd_SMB3_powerdown
		1.0:
			return A.snd_SMB3_powerdown
		2.0:
			return A.snd_warp
		3.0:
			return A.snd_SMB3_powerdown
