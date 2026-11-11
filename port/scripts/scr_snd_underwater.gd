# from scripts/scr_snd_underwater/scr_snd_underwater.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_underwater/scr_snd_underwater.gml
static func scr_snd_underwater(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_underwater
			else:
				return A.snd_SMB_music_underwater_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_underwater
			else:
				return A.snd_SMB3_music_underwater_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_underwater
			else:
				return A.snd_music_underwater_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_underwater
			else:
				return A.snd_NSMBU_music_underwater_night
	return null
