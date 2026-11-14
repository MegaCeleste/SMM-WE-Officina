extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_risas_or/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, y, object)
	for inst in GM.with_list(my_object):
		inst.sprite_index = self.sprite
		inst.image_speed = self.velocidad
		inst.cont_sounds = 4.0
		inst.sonido = self.sonido
		inst.sonido2 = self.sonido2
		inst.sonido3 = self.sonido3
		inst.sonido4 = self.sonido4
	can_active = 1.0
