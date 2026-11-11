# from scripts/scr_snd_switchalert/scr_snd_switchalert.gml
# 第 2 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_switchalert/scr_snd_switchalert.gml
static func scr_snd_switchalert(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_switchalert
		1.0:
			return A.snd_switchalert
		2.0:
			return A.snd_switchalert
		3.0:
			return A.snd_NSMBU_switchalert
	return null  # GML 走到结尾返回 undefined
