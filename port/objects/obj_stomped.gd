extends GMObject

var direct = null
var direct2: float = 0.0


# from objects/obj_stomped/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	direct = 1.0
	direct2 = 1.0
	alarm[0] = 30.0


# from objects/obj_stomped/Alarm_0.gml
func _alarm_0() -> void:
	instance_destroy()


# from objects/obj_stomped/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, direct2, image_angle, GM.c_white, 1.0)
