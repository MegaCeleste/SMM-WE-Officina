extends GMObject

var anim: float = 0.0


# from objects/obj_paracaidas_go/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	anim = 1.0


# from objects/obj_paracaidas_go/Step_0.gml
func _step() -> void:
	if anim > 0.2:
		anim -= 0.1
	else:
		instance_destroy()
	image_xscale = anim
	image_yscale = anim
