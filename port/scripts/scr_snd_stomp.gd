extends RefCounted


# from scripts/scr_snd_stomp/scr_snd_stomp.gml
static func scr_snd_stomp(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_step_enemy
		1.0:
			return A.snd_step_enemy
		2.0:
			return A.snd_stomp
		3.0:
			return A.snd_NSMBU_stomp
	return null  # GML 走到结尾返回 undefined
