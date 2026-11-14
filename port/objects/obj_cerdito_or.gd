extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_cerdito_or/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_es_cerdito
	sonido = A.snd_es_cerdito
	velocidad = 0.3
	object = A.obj_efecto_sonido
