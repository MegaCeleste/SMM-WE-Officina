# from scripts/scr_snd_mountain/scr_snd_mountain.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_snd_mountain/scr_snd_mountain.gml
static func scr_snd_mountain(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB_music_mountain
			else:
				return A.snd_SMB_music_volcano
		1.0:
			if G.modo_noche == 0.0:
				return A.snd_SMB3_music_mountain
			else:
				return A.snd_SMB3_music_volcano
		2.0:
			if G.modo_noche == 0.0:
				return A.snd_music_mountain
			else:
				return A.snd_music_volcano
		3.0:
			if G.modo_noche == 0.0:
				return A.snd_NSMBU_music_mountain
			else:
				return A.snd_NSMBU_music_volcano
	return null
