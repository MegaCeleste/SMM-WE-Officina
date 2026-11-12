# from objects/obj_superarcon（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var rotacion: float = 0.0


# from objects/obj_superarcon/Create_0.gml
func _create() -> void:
	super._create()
	image_speed = 0.0
	image_index = 0.0
	rotacion = 0.0
	direct = -1.0


# from objects/obj_superarcon/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		rotacion -= (5.0 * GM.gm_sign(hspeed))


# from objects/obj_superarcon/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	else:
		hspeed = 0.5


# from objects/obj_superarcon/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_NSMBU_superacorn2, 0.0, (x + 8.0), (y + 8.0), 1.0, 1.0, rotacion, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite(int(sprite_wings), wings_anim, x, y)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x + 8.0), y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
