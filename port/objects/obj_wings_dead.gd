extends "res://objects/obj_deactivation.gd"

var direct: float = 0.0
var vol: float = 0.0


# from objects/obj_wings_dead/Create_0.gml
func _create() -> void:
	image_index = G.apariencia
	image_speed = 0.0
	gravity = 0.15
	direct = 1.0
	vol = 0.0


# from objects/obj_wings_dead/Step_0.gml
func _step() -> void:
	if sprite_index == A.spr_wings_deads:
		if vol == 0.0:
			image_angle -= 5.0
			if image_angle <= -90.0:
				vol = 1.0
		elif vol == 1.0:
			image_angle += 5.0
			if image_angle >= -50.0:
				vol = 2.0
		elif vol == 2.0:
			image_angle -= 5.0
			if image_angle <= -90.0:
				vol = 1.0
	elif vol == 0.0:
		image_angle += 5.0
		if image_angle >= 90.0:
			vol = 1.0
	elif vol == 1.0:
		image_angle -= 5.0
		if image_angle <= 50.0:
			vol = 2.0
	elif vol == 2.0:
		image_angle += 5.0
		if image_angle >= 90.0:
			vol = 1.0
	if vspeed > 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
			if vspeed > 0.8:
				vspeed = 0.8
		elif vspeed > 1.8:
			vspeed = 1.8
		if (y - 8.0) > GM.room_height:
			instance_destroy()


# from objects/obj_wings_dead/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
