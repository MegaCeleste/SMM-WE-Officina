# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_spinjump/scr_NSMBU_spinjump.gml
static func scr_NSMBU_spinjump(me: GMObject):
	# gml_Script_scr_NSMBU_spinjump
	# if global.jugador = 0{
	match G.powerup:
		0.0:
			return A.spr_NSMBU_mario_small_spinjump
		1.0:
			return A.spr_NSMBU_mario_big_spinjump
		2.0:
			return A.spr_NSMBU_mario_fire_spinjump
		-30.0:
			return A.spr_NSMBU_mario_helice_spinjump
		-43.0:
			return A.spr_NSMBU_mario_arcon_spinjump
		-38.0:
			return A.spr_NSMBU_mario_penguin_spinjump
	# }
	# 	else{
	#    switch global.powerup
	#    {
	#        case 0:
	#            return spr_NSMBU_toad_small_spinjump;
	#        case 1:
	#            return spr_NSMBU_mario_big_spinjump;
	#        case 2:
	#            return spr_NSMBU_mario_fire_spinjump;
	#        case -30:
	#            return spr_NSMBU_mario_helice_spinjump;
	#        case -43:
	#            return spr_NSMBU_mario_arcon_spinjump;
	#        case -38:
	#            return spr_NSMBU_mario_penguin_spinjump;
	#    }
	# 	}
