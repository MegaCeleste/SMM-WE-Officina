# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_idle/scr_NSMBU_idle.gml
static func scr_NSMBU_idle(me: GMObject, argument0 = null) -> Variant:
	# gml_Script_scr_NSMBU_idle
	#
	# 	if global.jugador = 0{
	#
	if argument0 == 1.0:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_swim_idle
			1.0:
				return A.spr_NSMBU_mario_big_swim_idle
			2.0:
				return A.spr_NSMBU_mario_fire_swim_idle
			-30.0:
				return A.spr_NSMBU_mario_helice_swim_idle
			-43.0:
				return A.spr_NSMBU_mario_arcon_swim_idle
			-38.0:
				return A.spr_NSMBU_mario_penguin_idle
	else:
		match G.powerup:
			0.0:
				return A.spr_NSMBU_mario_small_idle
			1.0:
				return A.spr_NSMBU_mario_big_idle
			2.0:
				return A.spr_NSMBU_mario_fire_idle
			-30.0:
				return A.spr_NSMBU_mario_helice_idle
			-43.0:
				return A.spr_NSMBU_mario_arcon_idle
			-38.0:
				return A.spr_NSMBU_mario_penguin_idle
	#
	# 	}
	#
	#
	# 	else{
	#    if (argument0 == 1)
	#    {
	#        switch global.powerup
	#        {
	#            case 0:
	#                return spr_NSMBU_mario_small_swim_idle;
	#            case 1:
	#                return spr_NSMBU_mario_big_swim_idle;
	#            case 2:
	#                return spr_NSMBU_mario_fire_swim_idle;
	#            case -30:
	#                return spr_NSMBU_mario_helice_swim_idle;
	#            case -43:
	#                return spr_NSMBU_mario_arcon_swim_idle;
	#            case -38:
	#                return spr_NSMBU_mario_penguin_idle;
	#        }
	#
	#    }
	#    else
	#    {
	#        switch global.powerup
	#        {
	#            case 0:
	#                return spr_NSMBU_toad_small_idle;
	#            case 1:
	#                return spr_NSMBU_mario_big_idle;
	#            case 2:
	#                return spr_NSMBU_mario_fire_idle;
	#            case -30:
	#                return spr_NSMBU_mario_helice_idle;
	#            case -43:
	#                return spr_NSMBU_mario_arcon_idle;
	#            case -38:
	#                return spr_NSMBU_mario_penguin_idle;
	#        }
	#
	#    }
	# 	}
	#
	return null  # GML 走到结尾返回 undefined
