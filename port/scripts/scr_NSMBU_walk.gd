# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_walk/scr_NSMBU_walk.gml
static func scr_NSMBU_walk(me: GMObject, argument0 = null) -> Variant:
	# if global.jugador = 0{
	if argument0 == 1.0:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_swim_walk
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_swim_walk
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_swim_walk
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_swim_walk
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_swim_walk
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_swim
	else:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_walk
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_walk
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_walk
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_walk
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_walk
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_walk
	# }
	# 	else{
	# 	if (argument0 == 1) {
	# 	    switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_mario_small_swim_walk;
	# 	        case cs_big: return spr_NSMBU_mario_big_swim_walk;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_swim_walk;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_swim_walk;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_swim_walk;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_swim;}}
	# 	else {
	# 	    switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_walk;
	# 	        case cs_big: return spr_NSMBU_mario_big_walk;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_walk;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_walk;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_walk;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_walk; }}
	# 	}
	return null  # GML 走到结尾返回 undefined
