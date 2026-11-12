# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_run/scr_NSMBU_run.gml
static func scr_NSMBU_run(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_run
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_run
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_run
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_run
		Scr.cs_arcon:
			return A.spr_NSMBU_mario_arcon_run
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_run
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_run;
	# 	        case cs_big: return spr_NSMBU_mario_big_run;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_run;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_run;
	# 	        case cs_arcon: return spr_NSMBU_mario_arcon_run;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_run; }
	# 	}
