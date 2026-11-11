# from scripts/scr_bg_snow/scr_bg_snow.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_snow/scr_bg_snow.gml
static func scr_bg_snow(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_snow
			else:
				return A.bg_SMB_snow_night_1
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_snow
			else:
				return A.bg_SMB3_snow_night_1
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_snow
			else:
				return A.bg_night_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_snow_0
			else:
				return A.bg_NSMBU_snow_night_1
		4.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_snow
			else:
				return A.bg_SMB_night
		_:
			return A.bg_ground
	return null
