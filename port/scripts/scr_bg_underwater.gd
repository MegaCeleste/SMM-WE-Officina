# from scripts/scr_bg_underwater/scr_bg_underwater.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_underwater/scr_bg_underwater.gml
static func scr_bg_underwater(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underwater
			else:
				return A.bg_SMB_underwater_night_1
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_underwater
			else:
				return A.bg_SMB3_underwater_night
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_underwater_1
			else:
				return A.bg_underwater_night_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_underwater_0
			else:
				return A.bg_NSMBU_underwater_night
		4.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underwater
			else:
				return A.bg_SMB_night_1
		_:
			return A.bg_ground
	return null
