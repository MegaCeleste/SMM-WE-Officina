# from scripts/scr_pink_coins/scr_pink_coins.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_pink_coins/scr_pink_coins.gml
static func scr_pink_coins(me: GMObject) -> Variant:
	if G.apariencia == 0.0:
		match G.pink_coins_total:
			1.0:
				return A.spr_SMB_pinkcoin_hub1
			2.0:
				return A.spr_SMB_pinkcoin_hub2
			3.0:
				return A.spr_SMB_pinkcoin_hub3
			4.0:
				return A.spr_SMB_pinkcoin_hub4
			5.0:
				return A.spr_SMB_pinkcoin_hub5
			6.0:
				return A.spr_SMB_pinkcoin_hub6
			7.0:
				return A.spr_SMB_pinkcoin_hub7
			8.0:
				return A.spr_SMB_pinkcoin_hub8
			9.0:
				return A.spr_SMB_pinkcoin_hub9
			10.0:
				return A.spr_SMB_pinkcoin_hub10
			_:
				return A.spr_SMB_pinkcoin_hub5
	elif G.apariencia == 1.0:
		match G.pink_coins_total:
			1.0:
				return A.spr_SMB3_pinkcoin_hub1
			2.0:
				return A.spr_SMB3_pinkcoin_hub2
			3.0:
				return A.spr_SMB3_pinkcoin_hub3
			4.0:
				return A.spr_SMB3_pinkcoin_hub4
			5.0:
				return A.spr_SMB3_pinkcoin_hub5
			6.0:
				return A.spr_SMB3_pinkcoin_hub6
			7.0:
				return A.spr_SMB3_pinkcoin_hub7
			8.0:
				return A.spr_SMB3_pinkcoin_hub8
			9.0:
				return A.spr_SMB3_pinkcoin_hub9
			10.0:
				return A.spr_SMB3_pinkcoin_hub10
			_:
				return A.spr_SMB3_pinkcoin_hub5
	elif G.apariencia == 3.0:
		match G.pink_coins_total:
			1.0:
				return A.spr_NSMBU_pinkcoin_hub1
			2.0:
				return A.spr_NSMBU_pinkcoin_hub2
			3.0:
				return A.spr_NSMBU_pinkcoin_hub3
			4.0:
				return A.spr_NSMBU_pinkcoin_hub4
			5.0:
				return A.spr_NSMBU_pinkcoin_hub5
			6.0:
				return A.spr_NSMBU_pinkcoin_hub6
			7.0:
				return A.spr_NSMBU_pinkcoin_hub7
			8.0:
				return A.spr_NSMBU_pinkcoin_hub8
			9.0:
				return A.spr_NSMBU_pinkcoin_hub9
			10.0:
				return A.spr_NSMBU_pinkcoin_hub10
			_:
				return A.spr_NSMBU_pinkcoin_hub5
	else:
		match G.pink_coins_total:
			1.0:
				return A.spr_pinkcoin_hub1
			2.0:
				return A.spr_pinkcoin_hub2
			3.0:
				return A.spr_pinkcoin_hub3
			4.0:
				return A.spr_pinkcoin_hub4
			5.0:
				return A.spr_pinkcoin_hub5
			6.0:
				return A.spr_pinkcoin_hub6
			7.0:
				return A.spr_pinkcoin_hub7
			8.0:
				return A.spr_pinkcoin_hub8
			9.0:
				return A.spr_pinkcoin_hub9
			10.0:
				return A.spr_pinkcoin_hub10
			_:
				return A.spr_pinkcoin_hub5
	return null
