# from scripts/scr_snd_desert/scr_snd_desert.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_desert/scr_snd_desert.gml
static func scr_snd_desert(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_desert
			else:
				return A.snd_SMB_music_desert_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_ground
			else:
				return A.snd_SMB3_music_ground_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_desert
			else:
				return A.snd_music_desert_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_desert
			else:
				return A.snd_NSMBU_music_desert_night
	return null
