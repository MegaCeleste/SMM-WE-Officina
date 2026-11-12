# 第 4 批移植，已核对。
extends RefCounted


# from scripts/scr_powerup_editor/scr_powerup_editor.gml
static func scr_powerup_editor(me: GMObject, argument0 = null):
	match argument0:
		0.0:
			return 0.0
		1.0:
			return 1.0
		2.0:
			return 2.0
		3.0:
			match G.apariencia:
				0.0:
					return -77.0
				1.0:
					return -39.0
				2.0:
					return 3.0
				3.0:
					return -30.0
		4.0:
			match G.apariencia:
				0.0:
					return -78.0
				1.0:
					return -29.0
				2.0:
					return -82.0
				3.0:
					return -43.0
		5.0:
			match G.apariencia:
				0.0:
					return -78.0
				1.0:
					return -46.0
				2.0:
					return -82.0
				3.0:
					return -38.0
		6.0:
			match G.apariencia:
				0.0:
					return -50.0
				1.0:
					return -29.0
				2.0:
					return -82.0
				3.0:
					return -43.0
		7.0:
			match G.apariencia:
				0.0:
					return -85.0
				1.0:
					return -29.0
				2.0:
					return -82.0
				3.0:
					return -43.0
		8.0:
			match G.apariencia:
				0.0:
					return -80.0
				1.0:
					return -29.0
				2.0:
					return -82.0
				3.0:
					return -43.0
