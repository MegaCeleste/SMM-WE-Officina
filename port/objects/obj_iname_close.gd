extends GMObject

# from objects/obj_iname_close/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0

# from objects/obj_iname_close/Mouse_4.gml
func _mouse_4() -> void:
	for inst in GM.with_list(A.obj_iname_control):
		inst.instance_destroy()
