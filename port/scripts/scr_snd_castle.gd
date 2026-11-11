# from scripts/scr_snd_castle/scr_snd_castle.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_castle/scr_snd_castle.gml
static func scr_snd_castle(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_castle
			else:
				return A.snd_SMB_music_castle_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_castle
			else:
				return A.snd_SMB3_music_castle_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_castle
			else:
				return A.snd_music_castle_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_castle
			else:
				return A.snd_NSMBU_music_castle_night
	return null
