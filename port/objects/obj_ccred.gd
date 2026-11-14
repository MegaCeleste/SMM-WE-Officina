extends GMObject

# from objects/obj_ccred/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0

# from objects/obj_ccred/Mouse_4.gml
func _mouse_4() -> void:
	GM.room_goto(A.rm_title)
