extends GMObject
var hits: int = 0


func _step() -> void:
	for i: int in 6:
		if collision_rectangle(bbox_left, bbox_bottom - 1.0, bbox_right, bbox_bottom + 1.0 + i, TLog.ids["t_box"], false, false) != null:
			hits += 1
	if x > 3000.0 or x < 0.0:
		hspeed = -hspeed


func _step_end() -> void:
	image_alpha = 1.0
