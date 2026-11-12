extends GMObject

var fade: float = 0.0


# from objects/obj_rotten_signal/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_rotten_signal
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_rotten_signal
	fade = 0.0
	vspeed = -1.0
	friction = 0.0175


# from objects/obj_rotten_signal/Step_0.gml
func _step() -> void:
	if vspeed == 0.0:
		fade += 0.02
		if fade > 1.0:
			instance_destroy()
	if y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0):
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0)
