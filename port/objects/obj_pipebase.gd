# from objects/obj_pipebase（第 5 批移植，已核对）
extends "res://objects/obj_solid.gd"


# from objects/obj_pipebase/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	match G.apariencia:
		0.0:
			image_index = 0.0
		1.0:
			match G.bg_level:
				"underground":
					image_index = 2.0
				"ghost":
					image_index = 2.0
				"castle":
					image_index = 3.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 3.0
					else:
						image_index = 1.0
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 1.0
				_:
					# 原版 default 分支里 if 内的 break 只是跳出 switch，等价于 if/else
					if G.modo_noche == 1.0:
						image_index = 2.0
					else:
						image_index = 1.0
		2.0:
			image_index = 5.0
		3.0:
			image_index = 6.0
