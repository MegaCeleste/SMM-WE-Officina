# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_NSMBU_wall_slide/scr_NSMBU_wall_slide.gml
static func scr_NSMBU_wall_slide(me: GMObject):
	# if global.jugador = 0{
	match G.powerup:
		Scr.cs_small:
			return A.spr_NSMBU_mario_small_wall_slide
		Scr.cs_big:
			return A.spr_NSMBU_mario_big_wall_slide
		Scr.cs_fire:
			return A.spr_NSMBU_mario_fire_wall_slide
		Scr.cs_helice:
			return A.spr_NSMBU_mario_helice_wall_slide
		Scr.cs_penguin:
			return A.spr_NSMBU_mario_penguin_wall_slide
	# }
	# 	else{
	# 	switch global.powerup {
	# 	        case cs_small: return spr_NSMBU_toad_small_wallslide;
	# 	        case cs_big: return spr_NSMBU_mario_big_wall_slide;
	# 	        case cs_fire: return spr_NSMBU_mario_fire_wall_slide;
	# 	        case cs_helice: return spr_NSMBU_mario_helice_wall_slide;
	# 	        case cs_penguin: return spr_NSMBU_mario_penguin_wall_slide; }
	# 	}
