extends GMObject

var direct: float = 0.0


# from objects/obj_smoke_steps/Create_0.gml
func _create() -> void:
	if G.bg_level == "snow":
		sprite_index = A.spr_NSMBU_smoke_snow
	image_speed = 0.8
	direct = 1.0


# from objects/obj_smoke_steps/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_smoke_steps/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, 1.0, image_angle, GM.c_white, 1.0)
