extends GMObject

var beam: bool = false
var alpha: float = 0.0
var alpha2: float = 0.0
var angle: float = 0.0
var scale: float = 0.0
var i: float = 0.0
var scale2: Array = []


# from objects/obj_blend_ring/Create_0.gml
func _create() -> void:
	# / @description Efecto de anillo
	# Default variable
	beam = false
	# Alpha
	alpha = 1.0
	alpha2 = 1.0
	# Angle
	angle = GM.random(360.0)
	# Scale
	scale = 0.1
	i = 0.0
	while i < 6.0:
		GM.aset(scale2, i, GM.random_range(0.1, 1.0))
		i += 1.0


# from objects/obj_blend_ring/Step_0.gml
func _step() -> void:
	# / @description Desaparece cuando la escala termina en 0.5
	scale += 0.03245
	if scale > 0.5:
		alpha -= 0.09
		if (alpha < 0.09) and (alpha2 < 0.025):
			instance_destroy()
	alpha2 -= 0.025


# from objects/obj_blend_ring/Draw_0.gml
func _gm_draw() -> void:
	# / @description Dibujar efecto
	# Set blend mode
	GM.gpu_set_blendmode(GM.bm_add)
	# Dibujar el sprite
	GM.draw_sprite_ext(sprite_index, 0.0, x, y, scale, scale, 0.0, image_blend, alpha)
	GM.gpu_set_blendmode(GM.bm_normal)
