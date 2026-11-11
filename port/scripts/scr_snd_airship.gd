# from scripts/scr_snd_airship/scr_snd_airship.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_airship/scr_snd_airship.gml
static func scr_snd_airship(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_airship
			else:
				return A.snd_SMB_music_airship_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_airship
			else:
				return A.snd_SMB3_music_airship_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_airship
			else:
				return A.snd_music_airship_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_airship
			else:
				return A.snd_NSMBU_music_airship_night
	return null
