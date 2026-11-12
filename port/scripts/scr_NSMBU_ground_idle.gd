# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_ground_idle/scr_NSMBU_ground_idle.gml
static func scr_NSMBU_ground_idle(me: GMObject):
	# if global.jugador = 0{
	#
	var o = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and o.isswim == 1.0:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_swim_ground
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_swim_ground
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_swim_ground
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_swim_ground
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_swim_ground
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_swim_idle
	else:
		match G.powerup:
			Scr.cs_small:
				return A.spr_NSMBU_mario_small_ground_idle
			Scr.cs_big:
				return A.spr_NSMBU_mario_big_ground_idle
			Scr.cs_fire:
				return A.spr_NSMBU_mario_fire_ground_idle
			Scr.cs_helice:
				return A.spr_NSMBU_mario_helice_ground_idle
			Scr.cs_arcon:
				return A.spr_NSMBU_mario_arcon_ground_idle
			Scr.cs_penguin:
				return A.spr_NSMBU_mario_penguin_ground_idle
	# }
	# 	else {
	# 	if (instance_exists(obj_mario) && obj_mario.isswim == 1) {
	# 	    switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_mario_small_swim_ground;
	# 	        case cs_big: return spr_NSMBU_mario_big_swim_ground;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_swim_ground;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_swim_ground;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_swim_ground;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_swim_idle; }}
	# 	else {
	# 	    switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_ground_idle;
	# 	        case cs_big: return spr_NSMBU_mario_big_ground_idle;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_ground_idle;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_ground_idle;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_ground_idle;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_ground_idle; }}
	# 	}
	#
