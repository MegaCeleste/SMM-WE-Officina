# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_skid_right/scr_NSMBU_skid_right.gml
static func scr_NSMBU_skid_right(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_skid_right
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_skid_right
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_skid_right
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_skid_right
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_skid_right
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_skid_right
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_skid_right;
	# 	        case cs_big: return spr_NSMBU_mario_big_skid_right;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_skid_right;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_skid_right;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_skid_right;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_skid_right; }
	# 	}
