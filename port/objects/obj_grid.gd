extends GMObject

var color: float = 0.0
var num_tile_ancho = null
var num_ancho = null
var i = null


# from objects/obj_grid/Create_0.gml
func _create() -> void:
	color = 0.0


# from objects/obj_grid/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		var _switch_value1 = G.bg_level
		var _switch_case2: int = -1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underground"):
			_switch_case2 = 0
		if _switch_case2 < 0 and GM.veq(_switch_value1, "castle"):
			_switch_case2 = 1
		if _switch_case2 < 0 and GM.veq(_switch_value1, "underwater"):
			_switch_case2 = 2
		if _switch_case2 < 0 and GM.veq(_switch_value1, "ghost"):
			_switch_case2 = 3
		if _switch_case2 < 0:
			_switch_case2 = 4
		while true:
			if _switch_case2 >= 0 and _switch_case2 <= 0:
				color = GM.c_white
				break
			if _switch_case2 >= 0 and _switch_case2 <= 1:
				color = GM.c_white
				break
			if _switch_case2 >= 0 and _switch_case2 <= 2:
				color = GM.c_white
				break
			if _switch_case2 >= 0 and _switch_case2 <= 3:
				color = GM.c_white
				break
			if _switch_case2 >= 0 and _switch_case2 <= 4:
				if G.modo_noche == 1.0:
					color = GM.c_white
					break
				else:
					color = GM.c_black
			break
		num_tile_ancho = 384.0
		num_ancho = ceilf((GM.room_width / num_tile_ancho))
		i = 0.0
		while i < num_ancho:
			GM.draw_sprite_ext(A.spr_tile_grid, 0.0, (i * num_tile_ancho), 0.0, 1.0, 1.0, 0.0, color, image_alpha)
			i += 1.0
