extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_bombilla_or/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_es_bombilla
	if G.powerup == -85.0 and G.apariencia == 0.0:
		sonido = A.snd_es_bombilla_link
	else:
		sonido = A.snd_es_bombilla
	object = A.obj_efecto_sonido


# from objects/obj_bombilla_or/Step_0.gml
func _step() -> void:
	if G.powerup == -85.0 and G.apariencia == 0.0:
		sonido = A.snd_es_bombilla_link
	else:
		sonido = A.snd_es_bombilla


# from objects/obj_bombilla_or/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, (y - 16.0), object)
	for inst in GM.with_list(my_object):
		inst.sprite_index = self.sprite
		inst.image_speed = self.velocidad
		inst.sonido = self.sonido
	can_active = 1.0
