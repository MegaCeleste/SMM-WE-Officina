extends "res://tests/objs/t_base.gd"
var spawned: bool = false
var child: GMObject = null


func _step() -> void:
	rec("step")
	if not spawned:
		spawned = true
		child = GM.instance_create(x, y, TLog.ids["t_order"])
		child.set("tag", "child")
		child.hspeed = 2.0


func _step_end() -> void:
	rec("end")
