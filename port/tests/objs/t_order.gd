extends "res://tests/objs/t_base.gd"


func _create() -> void:
	rec("create")


func _step_begin() -> void:
	rec("begin")


func _alarm_0() -> void:
	rec("alarm0")


func _step() -> void:
	rec("step x=%s xprev=%s" % [GM.string(x), GM.string(xprevious)])


func _step_end() -> void:
	rec("end x=%s" % GM.string(x))


func _animation_end() -> void:
	rec("animend")


func _destroy() -> void:
	rec("destroy")
