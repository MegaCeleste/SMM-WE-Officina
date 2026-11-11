# from scripts/scr_bg_mountain/scr_bg_mountain.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_mountain/scr_bg_mountain.gml
static func scr_bg_mountain(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_mountain
			else:
				return A.bg_SMB_volcano
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB3_mountain
			else:
				return A.bg_SMB3_volcano
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_mountain
			else:
				return A.bg_volcano_1
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_mountain_0
			else:
				return A.bg_NSMBU_volcano_0
		4.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_ground
			else:
				return A.bg_SMB_night
		_:
			return A.bg_ground
	return null
