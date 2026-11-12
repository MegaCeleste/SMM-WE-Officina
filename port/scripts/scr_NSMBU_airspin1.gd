# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_airspin1/scr_NSMBU_airspin1.gml
static func scr_NSMBU_airspin1(me: GMObject):
	# gml_Script_scr_NSMBU_airspin1
	# if global.jugador = 0{
	match G.powerup:
		0.0:
			return A.spr_NSMBU_mario_small_airspin1
		1.0:
			return A.spr_NSMBU_mario_big_airspin1
		2.0:
			return A.spr_NSMBU_mario_fire_airspin1
		-30.0:
			return A.spr_NSMBU_mario_helice_airspin1
		-43.0:
			return A.spr_NSMBU_mario_arcon_airspin
		-38.0:
			return A.spr_NSMBU_mario_penguin_airspin
	# }
	# 	else{
	#    switch global.powerup
	#    {
	#        case 0:
	#            return spr_NSMBU_toad_small_airspin;
	#        case 1:
	#            return spr_NSMBU_mario_big_airspin1;
	#        case 2:
	#            return spr_NSMBU_mario_fire_airspin1;
	#        case -30:
	#            return spr_NSMBU_mario_helice_airspin1;
	#        case -43:
	#            return spr_NSMBU_mario_arcon_airspin;
	#        case -38:
	#            return spr_NSMBU_mario_penguin_airspin;
	#    }
	# 	}
