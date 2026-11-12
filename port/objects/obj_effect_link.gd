# 第 4 批移植，已核对。
extends "res://objects/obj_smoke.gd"

var type: float = 0.0
var arrow: float = 0.0
var posx: float = 0.0
var posy: float = 0.0


# from objects/obj_effect_link/Create_0.gml
func _create() -> void:
	image_speed = 0.3
	direct = 1.0
	type = 2.0
	arrow = 1.0
	scale = 1.0
	posx = 16.0
	posy = 26.0


# from objects/obj_effect_link/Step_0.gml
func _step() -> void:
	var m = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and (m.arrow > 0.0 or m.dash_atack > 0.0):
		type = m.arrow
		if arrow == 1.0:
			match type:
				1.0:
					posy = 16.0
				2.0:
					posy = 22.0
				3.0:
					posy = 27.0
			posx = 10.0
		else:
			posx = 16.0
			posy = 26.0
		x = (m.x + (posx * m.direct))
		y = (m.y + posy)
	else:
		instance_destroy()


# from objects/obj_effect_link/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		GM.draw_sprite_ext(sprite_index, image_index, (m.x + (posx * m.direct)), (m.y + posy), 1.0, 1.0, image_angle, GM.c_white, 1.0)
