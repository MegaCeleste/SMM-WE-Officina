extends GMObject

var move: float = 0.0
var rotate: float = 0.0
var alpha: float = 0.0


# from objects/obj_efecto_musica_bonus/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	move = 0.0
	rotate = 0.0
	alpha = 0.6
	hspeed = 3.0
	alarm[0] = 2.0


# from objects/obj_efecto_musica_bonus/Step_2.gml
func _step_end() -> void:
	move += 3.0
	rotate -= 6.0
	if move > 300.0:
		if alpha <= 0.0:
			alpha = 0.0
			instance_destroy()
		else:
			alpha -= 0.01


# from objects/obj_efecto_musica_bonus/Alarm_0.gml
func _alarm_0() -> void:
	GM.instance_create_depth(x, y, 0.0, A.obj_bonus_trail)
	alarm[0] = 2.0


# from objects/obj_efecto_musica_bonus/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(A.spr_bonus, 0.0, x, (y - 88.0), 1.0, 1.0, rotate, GM.c_white, alpha)
	GM.draw_sprite_ext(A.spr_bonus, 1.0, x, y, 1.0, 1.0, rotate, GM.c_white, alpha)
	GM.draw_sprite_ext(A.spr_bonus, 2.0, x, (y + 88.0), 1.0, 1.0, rotate, GM.c_white, alpha)
