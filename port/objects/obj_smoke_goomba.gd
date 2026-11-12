extends GMObject

var direct: float = 0.0


# from objects/obj_smoke_goomba/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_smoke_b
	if G.apariencia != 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.9
	direct = 1.0


# from objects/obj_smoke_goomba/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_smoke_goomba/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, image_yscale, image_angle, GM.c_white, 1.0)
