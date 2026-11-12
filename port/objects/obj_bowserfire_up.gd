extends "res://objects/obj_bowser_fire.gd"

var id_boss: float = 0.0
var id_cont: float = 0.0
var last: float = 0.0
var pos: float = 0.0  # 由 boss（空壳，第 8 批）写入
var out_1: float = 0.0
var out_2: float = 0.0
var out_3: float = 0.0
var out_4: float = 0.0
var out_5: float = 0.0


# from objects/obj_bowserfire_up/Create_0.gml
func _create() -> void:
	image_speed = 0.25
	direct = -1.0
	decender = 0.0
	id_boss = 0.0
	id_cont = 0.0
	gravity = 0.0
	vspeed = -1.5
	last = 0.0
	pos = 0.0
	direct = 1.0
	out_1 = 0.0
	out_2 = 0.0
	out_3 = 0.0
	out_4 = 0.0
	out_5 = 0.0


# from objects/obj_bowserfire_up/Step_0.gml
func _step() -> void:
	super._step()
	if (y + 16.0) < GM.camera_get_view_y(GM.view_get_camera(0)):
		if last == 1.0 and visible == true:
			_user_1()
		else:
			instance_destroy()


# from objects/obj_bowserfire_up/Alarm_0.gml
func _alarm_0() -> void:
	if direct == -1.0:
		GM.instance_create(pos, (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 16.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 44.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 72.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 48.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 100.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 64.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0), A.obj_bowser_fire_down)
	else:
		GM.instance_create(pos, (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 16.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 44.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 72.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 48.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 100.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 64.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0), A.obj_bowser_fire_down)
	instance_destroy()


# from objects/obj_bowserfire_up/Other_11.gml
func _user_1() -> void:
	if direct == -1.0:
		GM.instance_create(pos, (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 44.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 64.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 72.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 96.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 100.0), A.obj_bowser_fire_down)
		GM.instance_create((pos + 128.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0), A.obj_bowser_fire_down)
	else:
		GM.instance_create(pos, (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 44.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 64.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 72.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 96.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 100.0), A.obj_bowser_fire_down)
		GM.instance_create((pos - 128.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0), A.obj_bowser_fire_down)
	instance_destroy()


# from objects/obj_bowserfire_up/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, 0.0, GM.c_white, 1.0)
