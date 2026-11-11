# from scripts/scr_snd_soplete/scr_snd_soplete.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_soplete/scr_snd_soplete.gml
static func scr_snd_soplete(me: GMObject) -> Variant:
	if G.apariencia == 3.0:
		return A.snd_NSMBU_soplete
	else:
		return A.snd_soplete
	return null
