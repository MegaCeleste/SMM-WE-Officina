# from objects/obj_tile_trigger（第 5 批移植，已核对）
extends GMObject


# from objects/obj_tile_trigger/Create_0.gml
func _create() -> void:
	alarm[0] = 2.0


# from objects/obj_tile_trigger/Alarm_0.gml
func _alarm_0() -> void:
	instance_destroy()
