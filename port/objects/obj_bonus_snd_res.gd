extends "res://objects/obj_parent_sounds.gd"


# from objects/obj_bonus_snd_res/Create_0.gml
func _create() -> void:
	super._create()
	image_index = 20.0


# from objects/obj_bonus_snd_res/Other_13.gml
func _user_3() -> void:
	GM.instance_create(x, y, A.obj_bonus_or)
