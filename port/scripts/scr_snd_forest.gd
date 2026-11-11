# from scripts/scr_snd_forest/scr_snd_forest.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_forest/scr_snd_forest.gml
static func scr_snd_forest(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_forest
			else:
				return A.snd_SMB_music_forest_night
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_ground
			else:
				return A.snd_SMB3_music_ground_night
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_forest
			else:
				return A.snd_music_forest_night
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_forest
			else:
				return A.snd_NSMBU_music_forest_night
	return null
