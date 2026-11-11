# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_jump/scr_jump.gml
static func scr_jump(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.powerup:
			1.0:
				return A.snd_SMB_bigjump
			2.0:
				return A.snd_SMB_bigjump
			-50.0:
				return A.snd_SMB_jump_superflower
			-77.0:
				return A.snd_SMB_jump_supermushroom
			-78.0:
				return A.snd_SMB_hen_jump
			-85.0:
				return A.snd_SMB_link_jump
			_:
				return A.snd_SMB_smalljump
	elif G.apariencia == 1.0:
		return A.snd_SMB3_jump
	elif G.apariencia == 2.0:
		return A.snd_jump
	elif G.apariencia == 3.0:
		return A.snd_NSMBU_jump
	return null  # GML 走到结尾返回 undefined
