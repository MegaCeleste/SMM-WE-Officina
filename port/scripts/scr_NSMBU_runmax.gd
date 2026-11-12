# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_runmax/scr_NSMBU_runmax.gml
static func scr_NSMBU_runmax(me: GMObject):
	# global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_runmax
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_runmax
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_runmax
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_runmax
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_runmax
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_runmax
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_runmax;
	# 	        case cs_big: return spr_NSMBU_mario_big_runmax;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_runmax;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_runmax;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_runmax;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_runmax; }
	# 	}
