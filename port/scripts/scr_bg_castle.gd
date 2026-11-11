# from scripts/scr_bg_castle/scr_bg_castle.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_castle/scr_bg_castle.gml
static func scr_bg_castle(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underground
			else:
				return A.bg_SMB_night_1
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_castle
			else:
				return A.bg_SMB3_night_1
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_castle
			else:
				return A.bg_night_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_castle_1
			else:
				return A.bg_NSMBU_night
		4.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underground
			else:
				return A.bg_SMB_night_1
		_:
			return A.bg_ground
	return null
