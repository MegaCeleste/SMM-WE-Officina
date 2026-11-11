extends GMObject

var dir: float = 0.0
var direct: float = 0.0


# from objects/obj_shard/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	dir = 0.0
	direct = 1.0


# from objects/obj_shard/Step_0.gml
func _step() -> void:
	if Scr.outside_view(self) > 0.5:
		instance_destroy()
		return
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		if dir == 0.0:
			image_angle += 3.0
		else:
			image_angle -= 3.0
		gravity = 0.1
		if vspeed > 1.5:
			vspeed = 1.5
		hspeed = (0.5 * GM.gm_sign(hspeed))
	else:
		if dir == 0.0:
			image_angle += 6.0
		else:
			image_angle -= 6.0
		gravity = 0.2
		if vspeed > 3.0:
			vspeed = 3.0
		hspeed = (1.0 * GM.gm_sign(hspeed))


# from objects/obj_shard/Alarm_0.gml
func _alarm_0() -> void:
	instance_destroy()


# from objects/obj_shard/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
