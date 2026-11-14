extends GMObject

# from objects/obj_timeup/Create_0.gml
func _create() -> void:
	# Android touch controls are outside the port's scope.
	image_speed = 0.5
	if G.idioma == 0.0:
		sprite_index = A.spr_timeup
	elif G.idioma == 2.0:
		sprite_index = A.spr_timeup_it
	else:
		sprite_index = A.spr_timeup_en

# from objects/obj_timeup/Alarm_0.gml
func _alarm_0() -> void:
	gravity = 1.0

# from objects/obj_timeup/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	if G.idioma == 0.0:
		image_index = 31.0
	else:
		image_index = 29.0
	alarm[0] = 60.0

# from objects/obj_timeup/Other_40.gml
func _outside_view_0() -> void:
	instance_destroy()

# from objects/obj_timeup/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0, y)
