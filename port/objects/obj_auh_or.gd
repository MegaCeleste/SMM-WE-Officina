extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_auh_or/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_es_auh
	sonido = A.snd_es_auh
	object = A.obj_efecto_sonido
