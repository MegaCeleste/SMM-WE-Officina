# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_powerdown/scr_snd_powerdown.gml
static func scr_snd_powerdown(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_powerdown
		1.0:
			if G.powerup == -29.0:
				return A.snd_helmet_remove
			else:
				return A.snd_SMB3_powerdown
		2.0:
			return A.snd_warp
		3.0:
			return A.snd_NSMBU_powerdown
	return null  # GML 走到结尾返回 undefined
