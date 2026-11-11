# from scripts/scr_snd_ground/scr_snd_ground.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_ground/scr_snd_ground.gml
static func scr_snd_ground(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_ground
			else:
				return A.snd_SMB_music_ground_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_ground
			else:
				return A.snd_SMB3_music_ground_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_ground
			else:
				return A.snd_music_ground_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_overworld
			else:
				return A.snd_NSMBU_music_overworld_night
	return null
