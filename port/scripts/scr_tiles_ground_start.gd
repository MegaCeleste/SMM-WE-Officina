# from scripts/scr_tiles_ground_start/scr_tiles_ground_start.gml
# 第 3 批移植，已核对。apariencia == 4 分支用到的 spr_SMB2_* 不在工程资源里（原版同样是未定义变量），照字面写成 me.get(...)。
extends RefCounted


# from scripts/scr_tiles_ground_start/scr_tiles_ground_start.gml
static func scr_tiles_ground_start(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.bg_level:
			"ground":
				return A.spr_SMB_ground
			"underground":
				return A.spr_SMB_ground2
			"castle":
				return A.spr_SMB_ground3
			"underwater":
				return A.spr_SMB_ground4
			"ghost":
				return A.spr_SMB_ground5
			"airship":
				return A.spr_SMB_ground8
			"forest":
				return A.spr_SMB_ground7
			"sky":
				return A.spr_SMB_ground8
			"desert":
				return A.spr_SMB_ground9
			"snow":
				if G.modo_noche == 1.0:
					return A.spr_SMB_ground10_night
				else:
					return A.spr_SMB_ground10
			"fall":
				return A.spr_SMB_ground11
			"beach":
				return A.spr_SMB_ground12
			"mountain":
				if G.modo_noche == 1.0:
					return A.spr_SMB_ground14
				else:
					return A.spr_SMB_ground13
			_:
				return A.spr_SMB_ground
	elif G.apariencia == 1.0:
		match G.bg_level:
			"ground":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground_night
				else:
					return A.spr_SMB3_ground
			"underground":
				return A.spr_SMB3_ground2
			"castle":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground3_night
				else:
					return A.spr_SMB3_ground3
			"underwater":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground4_night
				else:
					return A.spr_SMB3_ground4
			"ghost":
				return A.spr_SMB3_ground5
			"airship":
				return A.spr_SMB3_ground8
			"forest":
				return A.spr_SMB3_ground7
			"sky":
				return A.spr_SMB3_ground8
			"desert":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground9_night
				else:
					return A.spr_SMB3_ground9
			"snow":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground10_night
				else:
					return A.spr_SMB3_ground10
			"fall":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground11_night
				else:
					return A.spr_SMB3_ground11
			"beach":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground12_night
				else:
					return A.spr_SMB3_ground12
			"mountain":
				if G.modo_noche == 1.0:
					return A.spr_SMB3_ground14
				else:
					return A.spr_SMB3_ground13
			_:
				return A.spr_ground
	elif G.apariencia == 2.0:
		match G.bg_level:
			"ground":
				return A.spr_ground
			"underground":
				return A.spr_ground2
			"castle":
				return A.spr_ground3
			"underwater":
				if G.modo_noche == 1.0:
					return A.spr_ground4_night
				else:
					return A.spr_ground4
			"ghost":
				return A.spr_ground5
			"airship":
				return A.spr_ground8
			"forest":
				return A.spr_ground7
			"sky":
				return A.spr_ground8
			"desert":
				return A.spr_ground9
			"snow":
				if G.modo_noche == 1.0:
					return A.spr_ground10_night
				else:
					return A.spr_ground10
			"fall":
				return A.spr_ground11
			"beach":
				return A.spr_ground12
			"mountain":
				if G.modo_noche == 1.0:
					return A.spr_ground14
				else:
					return A.spr_ground13
			_:
				return A.spr_ground
	elif G.apariencia == 3.0:
		match G.bg_level:
			"ground":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground_night
				else:
					return A.spr_NSMBU_ground
			"underground":
				return A.spr_NSMBU_ground2
			"castle":
				return A.spr_NSMBU_ground3
			"underwater":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground4_night
				else:
					return A.spr_NSMBU_ground4
			"ghost":
				return A.spr_NSMBU_ground5
			"airship":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground8_night
				else:
					return A.spr_NSMBU_ground8
			"forest":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground7_night
				else:
					return A.spr_NSMBU_ground7
			"sky":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground8_night
				else:
					return A.spr_NSMBU_ground8
			"desert":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground9_night
				else:
					return A.spr_NSMBU_ground9
			"snow":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground10_night
				else:
					return A.spr_NSMBU_ground10
			"fall":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground11_night
				else:
					return A.spr_NSMBU_ground11
			"beach":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground12_night
				else:
					return A.spr_NSMBU_ground12
			"mountain":
				if G.modo_noche == 1.0:
					return A.spr_NSMBU_ground14
				else:
					return A.spr_NSMBU_ground13
	if G.apariencia == 4.0:
		match G.bg_level:
			"ground":
				return me.get("spr_SMB2_ground")
			"underground":
				return me.get("spr_SMB2_ground2")
			"castle":
				return me.get("spr_SMB2_ground3")
			"underwater":
				return me.get("spr_SMB2_ground4")
			"ghost":
				return me.get("spr_SMB2_ground5")
			"airship":
				if G.modo_noche == 1.0:
					return me.get("spr_SMB2_ground_night")
				else:
					return me.get("spr_SMB2_ground6")
			"forest":
				return me.get("spr_SMB2_ground7")
			"sky":
				return me.get("spr_SMB2_ground8")
			"desert":
				return me.get("spr_SMB2_ground9")
			"snow":
				if G.modo_noche == 1.0:
					return me.get("spr_SMB2_ground_night")
				else:
					return me.get("spr_SMB2_ground10")
			"fall":
				return me.get("spr_SMB2_ground")
			"beach":
				return me.get("spr_SMB2_ground")
			_:
				return me.get("spr_SMB2_ground")
	return null
