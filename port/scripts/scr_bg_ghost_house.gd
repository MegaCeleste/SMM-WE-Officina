# from scripts/scr_bg_ghost_house/scr_bg_ghost_house.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_bg_ghost_house/scr_bg_ghost_house.gml
static func scr_bg_ghost_house(me: GMObject) -> Variant:
	match G.apariencia:
		0.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underground
			else:
				return A.bg_SMB_ghost_house_night
		1.0:
			if G.modo_noche == 0.0:
				return A.bg_SMB_underground
			else:
				return A.bg_SMB_ghost_house_night
		2.0:
			if G.modo_noche == 0.0:
				return A.bg_ghost_house_1
			else:
				return A.bg_ghost_house_night
		3.0:
			if G.modo_noche == 0.0:
				return A.bg_NSMBU_ghost_house_1
			else:
				return A.bg_NSMBU_ghost_night
		_:
			return A.bg_ground
	return null
