extends GMObject

var scale_x: float = 0.0
var scale_y: float = 0.0
var alpha: float = 0.0
var sonido: float = 0.0
var active: float = 0.0
var ready_v: float = 0.0


# from objects/obj_efecto_musica/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	scale_x = 1.0
	scale_y = 1.0
	alpha = 0.5
	sonido = A.snd_n64
	active = 0.0
	ready_v = 0.0


# from objects/obj_efecto_musica/Step_2.gml
func _step_end() -> void:
	x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0)
	y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0)
	if scale_x > 0.2 and scale_y > 0.2:
		scale_x -= 0.012
		scale_y -= 0.012
	else:
		instance_destroy()
	if ready_v == 0.0:
		if alpha >= 1.0:
			alpha = 1.0
			ready_v = 1.0
		else:
			alpha += 0.02
	elif alpha <= 0.0:
		alpha = 0.0
	else:
		alpha -= 0.02


# from objects/obj_efecto_musica/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), scale_x, scale_y, 0.0, GM.c_white, alpha)
