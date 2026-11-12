# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_walkhome/scr_NSMBU_walkhome.gml
static func scr_NSMBU_walkhome(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_walkhome
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_walkhome
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_walkhome
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_walkhome
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_walkhome
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_walkhome
	# }
	# 	else{
	# 	 switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_walkhome;
	# 	        case cs_big: return spr_NSMBU_mario_big_walkhome;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_walkhome;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_walkhome;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_walkhome;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_walkhome; }
	# 	}
	#
