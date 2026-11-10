extends "res://tests/objs/t_base.gd"


func _collision_t_coll_a(other: GMObject) -> void:
	rec("hit " + String(other.get("tag")))
