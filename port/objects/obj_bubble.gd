extends GMObject


# from objects/obj_bubble/Create_0.gml
func _create() -> void:
	image_speed = 0.1
	image_alpha = 0.8
	path_start(A.pth_bubbles, 1.0, GM.path_action_continue, false)


# from objects/obj_bubble/Step_0.gml
func _step() -> void:
	if (GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 8.0) and G.bg_level == "forest" and G.modo_noche == 0.0) or (G.bg_level != "underwater" and G.bg_level != "forest") or place_meeting(x, y, A.obj_solid):
		_user_0()


# from objects/obj_bubble/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_bubble2:
		instance_destroy()


# from objects/obj_bubble/Other_10.gml
func _user_0() -> void:
	sprite_index = A.spr_bubble2
