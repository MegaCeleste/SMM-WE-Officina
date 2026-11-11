# from scripts/scr_snd_underground/scr_snd_underground.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_underground/scr_snd_underground.gml
static func scr_snd_underground(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_underground
			else:
				return A.snd_SMB_music_underground_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_underground
			else:
				return A.snd_SMB3_music_underground_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_underground
			else:
				return A.snd_music_underground_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_underground
			else:
				return A.snd_NSMBU_music_underground_night
	return null
