# 第 7 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_clown_damage/scr_snd_clown_damage.gml
static func scr_snd_clown_damage(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_clown_damage
		1.0:
			return A.snd_SMB3_clown_damage
		2.0:
			return A.snd_clown_damage
		3.0:
			return A.snd_clown_damage
	return null
