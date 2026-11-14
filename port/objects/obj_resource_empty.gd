extends "res://objects/obj_parent_resource.gd"

var resource: float = 0.0

# from objects/obj_resource_empty/Create_0.gml
func _create() -> void:
	var drop: String
	instance_destroy()
	move_snap(16.0, 16.0)
	image_speed = 0.0
	drag = 0.0
	drop = ""
	laller = depth
	resource = 0.0
	x_start = 0.0
	y_start = 0.0
