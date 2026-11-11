# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_restart/scr_restart.gml
static func scr_restart(me: GMObject) -> Variant:
	# Reset the level variables and restart the room
	G.coins = 0.0
	GM.score = 0.0
	G.powerup = 0.0
	G.timer = 0.0
	G.onoffblock = 0.0
	G.liveleves = 0.0
	G.keys = 0.0
	G.ms = 0.0
	GM.room_restart()
	return null  # GML 走到结尾返回 undefined
