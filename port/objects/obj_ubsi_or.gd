extends "res://objects/obj_parent_sound_o.gd"


# from objects/obj_ubsi_or/Create_0.gml
func _create() -> void:
	super._create()
	sprite = A.spr_es_error
	sonido = A.snd_es_ubsi
	object = A.obj_efecto_sonido


# from objects/obj_ubsi_or/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, y, object)
	for inst in GM.with_list(my_object):
		inst.sprite_index = self.sprite
		inst.image_speed = self.velocidad
		inst.visible = false
		inst.sonido = self.sonido
	Scr.init_shake(self, 1.0)
	can_active = 1.0
