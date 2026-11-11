# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_link_arrow_swim/scr_link_arrow_swim.gml
static func scr_link_arrow_swim(me: GMObject, argument0 = null) -> Variant:
	match argument0:
		1.0:
			return A.spr_SMB_link_arrowup_swim
		2.0:
			return A.spr_SMB_link_arrow_swim
		3.0:
			return A.spr_SMB_link_arrowdown_swim
	return null
