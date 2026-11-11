# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_link_arrow_jump/scr_link_arrow_jump.gml
static func scr_link_arrow_jump(me: GMObject, argument0 = null) -> Variant:
	match argument0:
		1.0:
			return A.spr_SMB_link_arrowup_jump
		2.0:
			return A.spr_SMB_link_arrow_jump
		3.0:
			return A.spr_SMB_link_arrowdown_jump
	return null
