extends GMObject


# from objects/obj_gotas/Create_0.gml
func _create() -> void:
	gravity = 0.2


# from objects/obj_gotas/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	instance_destroy()


# from objects/obj_gotas/Collision_obj_pinchos.gml
func _collision_obj_pinchos(other: GMObject) -> void:
	instance_destroy()


# from objects/obj_gotas/Collision_obj_solidtop.gml
func _collision_obj_solidtop(other: GMObject) -> void:
	instance_destroy()
