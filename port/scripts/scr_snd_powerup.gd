# from scripts/scr_snd_powerup/scr_snd_powerup.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_powerup/scr_snd_powerup.gml
static func scr_snd_powerup(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_powerup
		1.0:
			return A.snd_SMB3_powerup
		2.0:
			return A.snd_powerup
		3.0:
			if me.object_index == A.obj_propellershroom:
				return A.snd_NSMBU_powerup_helice
			elif me.object_index == A.obj_penguin_suit:
				return A.snd_NSMBU_powerup_penguinsuit
			else:
				return A.snd_NSMBU_powerup
	return null  # GML 走到结尾返回 undefined
