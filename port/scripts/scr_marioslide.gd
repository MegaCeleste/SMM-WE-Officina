# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_marioslide/scr_marioslide.gml
static func scr_marioslide(me: GMObject):
	if G.apariencia == 1.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_mario_small_slide
				1.0:
					return A.spr_SMB3_mario_big_slide
				2.0:
					return A.spr_SMB3_mario_fire_slide
				-39.0:
					return A.spr_SMB3_mario_raccoon_slide
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_luigi_small_slide
				1.0:
					return A.spr_SMB3_luigi_big_slide
				2.0:
					return A.spr_SMB3_luigi_fire_slide
				-39.0:
					return A.spr_SMB3_luigi_raccoon_slide
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toad_small_slide
				1.0:
					return A.spr_SMB3_toad_big_slide
				2.0:
					return A.spr_SMB3_toad_fire_slide
				-39.0:
					return A.spr_SMB3_toad_raccoon_slide
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_SMB3_toadette_small_slide
				1.0:
					return A.spr_SMB3_toadette_big_slide
				2.0:
					return A.spr_SMB3_toadette_fire_slide
				-39.0:
					return A.spr_SMB3_toadette_raccoon_slide
	elif G.apariencia == 2.0:
		if G.jugador == 0.0:
			match G.powerup:
				0.0:
					return A.spr_mario_small_slide
				1.0:
					return A.spr_mario_big_slide
				2.0:
					return A.spr_mario_fire_slide
				3.0:
					return A.spr_mario_big_slide
		elif G.jugador == 1.0:
			match G.powerup:
				0.0:
					return A.spr_luigi_small_slide
				1.0:
					return A.spr_luigi_big_slide
				2.0:
					return A.spr_luigi_fire_slide
				3.0:
					return A.spr_luigi_big_slide
		elif G.jugador == 2.0:
			match G.powerup:
				0.0:
					return A.spr_toad_small_slide
				1.0:
					return A.spr_toad_big_slide
				2.0:
					return A.spr_toad_fire_slide
				3.0:
					return A.spr_toad_big_slide
		elif G.jugador == 3.0:
			match G.powerup:
				0.0:
					return A.spr_toadette_small_slide
				1.0:
					return A.spr_toadette_big_slide
				2.0:
					return A.spr_toadette_fire_slide
				3.0:
					return A.spr_toadette_big_slide
