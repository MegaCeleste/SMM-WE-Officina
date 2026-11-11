# from scripts/scr_snd_coin/scr_snd_coin.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_coin/scr_snd_coin.gml
static func scr_snd_coin(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			return A.snd_SMB3_coin
		1.0:
			return A.snd_SMB3_coin
		2.0:
			return A.snd_coin
		3.0:
			return A.snd_NSMBU_coin
	return null  # GML 走到结尾返回 undefined
