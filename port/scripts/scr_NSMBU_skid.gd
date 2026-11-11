# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_skid/scr_NSMBU_skid.gml
static func scr_NSMBU_skid(me: GMObject) -> Variant:
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_skid
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_skid
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_skid
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_skid
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_skid
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_skid
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_skid;
	# 	        case cs_big: return spr_NSMBU_mario_big_skid;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_skid;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_skid;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_skid;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_skid; }
	# 	}
	#
	return null  # GML 走到结尾返回 undefined
