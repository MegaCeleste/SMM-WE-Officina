# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_link_arrow_walk/scr_link_arrow_walk.gml
static func scr_link_arrow_walk(me: GMObject, argument0 = null) -> Variant:
	match argument0:
		1.0:
			return A.spr_SMB_link_arrowup_walk
		2.0:
			return A.spr_SMB_link_arrow_walk
		3.0:
			return A.spr_SMB_link_arrowdown_walk
	return null
