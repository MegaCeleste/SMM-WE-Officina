extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_golpe_gato_or/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_es_golpe_gato
	sonido = A.snd_es_golpe_gato
	velocidad = 0.5
	object = A.obj_efecto_sonido


# from objects/obj_golpe_gato_or/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, y, object)
	for inst in GM.with_list(my_object):
		inst.sprite_index = A.spr_es_golpe_gato
		inst.image_speed = self.velocidad
		inst.sonido = self.sonido
		inst.depth = -13.0
	can_active = 1.0
