extends GMObject

var anibg: Array = []
var numb: int = 0
var type: float = 0.0
var cont: int = 0
var down: float = 0.0
var index: float = 0.0

# from objects/obj_bganimator/Create_0.gml
func _create() -> void:
	GM.aset(anibg, 0, -1.0)
	numb = 0
	type = 0.0
	cont = 0
	down = 0.0
	index = 0.0
	alarm[0] = 1.0

# from objects/obj_bganimator/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_levelmanager):
		var manager = GM.instance_find(A.obj_levelmanager, 0)
		if manager.editor == 0.0:
			if G.bg_level == "airship" and G.apariencia != 0.0:
				if type == 0.0:
					match cont:
						0:
							cont += 1
							numb += 1
							alarm[0] = 10.0
						1:
							cont += 1
							numb += 1
							alarm[0] = 50.0
						2:
							cont += 1
							numb += 1
							alarm[0] = 10.0
						3:
							cont = 0
							type = 1.0
							numb = 0
							alarm[0] = 60.0
				else:
					match cont:
						0:
							cont += 1
							numb += 1
							alarm[0] = 10.0
						1:
							cont += 1
							numb += 1
							alarm[0] = 100.0
						2:
							cont += 1
							numb += 1
							alarm[0] = 10.0
						3:
							cont = 0
							type = 0.0
							numb = 0
							alarm[0] = 180.0
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, anibg[numb])
			else:
				Scr.__background_set(self, Scr.e__BG.Index, index, anibg[numb])
				numb += 1
				if numb == anibg.size():
					numb = 0
				alarm[0] = 10.0
		else:
			Scr.__background_set(self, Scr.e__BG.Index, index, anibg[0])
			alarm[0] = 10.0
	motion_set(0.0, 0.0)
