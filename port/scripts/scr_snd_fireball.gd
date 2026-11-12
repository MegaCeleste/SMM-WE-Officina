# from scripts/scr_snd_fireball/scr_snd_fireball.gml
# 第 5 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_fireball/scr_snd_fireball.gml
static func scr_snd_fireball(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.powerup == -50.0:
				return A.snd_SMB_superball
			else:
				return A.snd_SMB_fireball
		1.0:
			return A.snd_SMB3_fireball
		2.0:
			return A.snd_fireball
		3.0:
			return A.snd_NSMBU_fireball
	return null  # GML 走到结尾返回 undefined
