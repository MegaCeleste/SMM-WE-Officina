# from scripts/scr_bg_desert/scr_bg_desert.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_desert/scr_bg_desert.gml
static func scr_bg_desert(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_desert
			else:
				return A.bg_SMB_night_1
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_desert
			else:
				return A.bg_SMB3_night_1
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_desert
			else:
				return A.bg_night_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_desert_1
			else:
				return A.bg_NSMBU_night
		4.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_desert
			else:
				return A.bg_SMB_night
		_:
			return A.bg_ground
	return null
