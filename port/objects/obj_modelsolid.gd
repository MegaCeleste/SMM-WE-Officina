extends "res://objects/obj_solid.gd"

var mysolid = null


# from objects/obj_modelsolid/Create_0.gml
func _create() -> void:
	mysolid = A.obj_lighting
	alarm[0] = 15.0


# from objects/obj_modelsolid/Destroy_0.gml
func _destroy() -> void:
	if not (mysolid is int and mysolid == A.obj_lighting):
		if GM.instance_exists(mysolid):
			for inst in GM.with_list(mysolid):
				inst.instance_destroy()


# from objects/obj_modelsolid/Alarm_0.gml
func _alarm_0() -> void:
	if y == 0.0:
		if image_index == 0.0 or image_index == 45.0 or image_index == 8.0 or image_index == 11.0 or image_index == 18.0 or image_index == 24.0 or image_index == 52.0 or image_index == 53.0 or image_index == 54.0 or image_index == 55.0:
			mysolid = GM.instance_create(x, (y - 192.0), A.obj_solid)
			mysolid.image_yscale = 12.0
	elif y == (GM.room_height - 16.0):
		if image_index == 2.0 or image_index == 9.0 or image_index == 10.0 or image_index == 18.0 or image_index == 24.0 or image_index == 45.0 or image_index == 50.0 or image_index == 51.0 or image_index == 52.0 or image_index == 53.0:
			mysolid = GM.instance_create(x, (y + 16.0), A.obj_solid)
			mysolid.image_yscale = 6.0


# from objects/obj_modelsolid/Draw_0.gml
func _gm_draw() -> void:
	if y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0) and y < ((GM.camera_get_view_y(GM.view_get_camera(0)) + 216.0) + 32.0):
		draw_self()
