# from scripts/scr_bg_sky/scr_bg_sky.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_sky/scr_bg_sky.gml
static func scr_bg_sky(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_airship
			else:
				return A.bg_SMB_night_1
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_airship
			else:
				return A.bg_SMB3_sky_night_1
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_airship
			else:
				return A.bg_sky_night_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_sky_0
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
