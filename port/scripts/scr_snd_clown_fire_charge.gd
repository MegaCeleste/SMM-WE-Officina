# 第 7 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_clown_fire_charge/scr_snd_clown_fire_charge.gml
static func scr_snd_clown_fire_charge(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_clown_fire_charge
		1.0:
			return A.snd_SMB3_clown_fire_charge
		2.0:
			return A.snd_clown_fire_charge
		3.0:
			return A.snd_NSMBU_clown_charge_start
	return null
