extends "res://tests/objs/t_base.gd"
var kill_other: bool = false


func _collision_t_coll_b(other: GMObject) -> void:
	rec("hit " + String(other.get("tag")))
	if kill_other:
		GM.instance_destroy(other)


func _step_end() -> void:
	rec("end")
