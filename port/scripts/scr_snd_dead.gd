# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_dead/scr_snd_dead.gml
static func scr_snd_dead(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.powerup == -85.0:
				return A.snd_SMB_link_dead
			elif G.powerup == -50.0:
				return A.snd_SMB_superball_dead
			else:
				return A.snd_SMB_dead
		1.0:
			return A.snd_SMB3_dead
		2.0:
			return A.snd_dead
		3.0:
			return A.snd_NSMBU_dead
	return null  # GML 走到结尾返回 undefined
