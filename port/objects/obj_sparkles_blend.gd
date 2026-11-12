extends GMObject

var scale: float = 0.0
var shrink_rate: float = 0.0


# from objects/obj_sparkles_blend/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB3_sparkles_coin
		1.0:
			sprite_index = A.spr_SMB3_sparkles_coin
		3.0:
			sprite_index = A.spr_NSMBU_sparkles_coin
	if G.apariencia == 3.0:
		# No animar
		image_speed = 0.0
		image_index = 0.0
		# Scale
		scale = 1.0
		# Tasa de encogimiento
		shrink_rate = 0.025
	else:
		# No animar
		image_speed = 0.0
		image_index = 0.0
		# Scale
		scale = 1.0
		# Tasa de encogimiento
		shrink_rate = 0.025


# from objects/obj_sparkles_blend/Step_0.gml
func _step() -> void:
	# / @description Encogerse y destruirse
	scale -= shrink_rate
	if scale < 0.0:
		instance_destroy()
	if vspeed > 2.0:
		vspeed = 2.0


# from objects/obj_sparkles_blend/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_sparkles_blend/Draw_0.gml
func _gm_draw() -> void:
	# / @description Dibujar sparkle
	GM.draw_sprite_ext(sprite_index, -1.0, x, y, scale, scale, 0.0, GM.c_white, 1.0)
