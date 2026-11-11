# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_music_link/scr_music_link.gml
static func scr_music_link(me: GMObject) -> Variant:
	match G.bg_level:
		"underground":
			return A.snd_SMB_master_sword_underground
		"ghost":
			return A.snd_SMB_master_sword_underground
		"castle":
			return A.snd_SMB_master_sword_castle
		"airship":
			return A.snd_SMB_master_sword_castle
		_:
			return A.snd_SMB_master_sword
	return null  # GML 走到结尾返回 undefined
