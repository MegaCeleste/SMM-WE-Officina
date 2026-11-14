extends GMObject

var xx: float = 0.0
var yy: float = 0.0
var texto: String = ""
var ancho: float = 0.0
var icon: float = 0.0
var borrar: String = ""
var anim: float = 0.0
var ready_v: float = 0.0
var large: float = 0.0
var alpha: float = 0.0


# from objects/obj_toast/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	alarm[0] = 90.0
	xx = 0.0
	yy = 0.0
	texto = ""
	ancho = 130.0
	icon = 0.0
	borrar = ""
	anim = 0.0
	ready_v = 0.0
	large = 0.0
	alpha = 0.1


# from objects/obj_toast/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		instance_destroy()
	x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + xx))
	y = (((GM.camera_get_view_y(GM.view_get_camera(0)) + yy) - anim))
	if ready_v == 0.0:
		if anim < 36.0:
			anim += 4.0
			alpha += 0.1
		else:
			anim = 36.0
			alpha = 1.0
			if large == 1.0:
				alarm[0] = 120.0
			else:
				alarm[0] = 80.0
			ready_v = 1.0
	elif ready_v == 2.0:
		if anim > 18.0:
			anim -= 2.0
			alpha -= 0.1
		else:
			instance_destroy()


# from objects/obj_toast/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 2.0


# from objects/obj_toast/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_stretched(sprite_index, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + xx), ((GM.camera_get_view_y(GM.view_get_camera(0)) + yy) - anim), ancho, 28.0)
	GM.draw_sprite(A.spr_toast_icons, icon, ((GM.camera_get_view_x(GM.view_get_camera(0)) + xx) + 5.0), (((GM.camera_get_view_y(GM.view_get_camera(0)) + yy) + 5.0) - anim))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_black)
	GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0)) + xx) + 30.0), (((GM.camera_get_view_y(GM.view_get_camera(0)) + yy) + 6.0) - anim), GM.string_hash_to_newline((texto)))


# from objects/obj_toast/Mouse_4.gml
func _mouse_4() -> void:
	pass
