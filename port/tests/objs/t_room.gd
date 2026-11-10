extends "res://tests/objs/t_base.gd"
var goto_room: int = -1


func _create() -> void:
	tag = "r%d" % GM.room
	rec("create")


func _room_start() -> void:
	rec("roomstart")


func _room_end() -> void:
	rec("roomend")


func _game_start() -> void:
	rec("gamestart")


func _step() -> void:
	rec("step")
	if goto_room >= 0:
		var r: int = goto_room
		goto_room = -1
		GM.room_goto(r)


func _step_end() -> void:
	rec("end")


func _cleanup() -> void:
	rec("cleanup")


func _destroy() -> void:
	rec("destroy")
