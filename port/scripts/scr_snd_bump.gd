extends RefCounted


# from scripts/scr_snd_bump/scr_snd_bump.gml
static func scr_snd_bump(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_bump
		1.0:
			return A.snd_SMB3_bump
		2.0:
			return A.snd_bump
		3.0:
			return A.snd_NSMBU_bump
	return null  # GML 走到结尾返回 undefined
