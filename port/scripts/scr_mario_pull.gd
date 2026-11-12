# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_mario_pull/scr_mario_pull.gml
static func scr_mario_pull(me: GMObject):
	if G.jugador == 0.0:
		match G.powerup:
			-80.0:
				return A.spr_SMB2_mario_big_pull
	elif G.jugador == 1.0:
		match G.powerup:
			-80.0:
				return A.spr_SMB2_luigi_big_pull
	elif G.jugador == 2.0:
		match G.powerup:
			-80.0:
				return A.spr_SMB2_toad_big_pull
	elif G.jugador == 3.0:
		match G.powerup:
			-80.0:
				return A.spr_SMB2_toadette_big_pull
