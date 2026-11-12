# from objects/obj_slopesa（第 5 批移植，已核对）
# 原版所有事件文件都是空的：空事件在 GML 里仍然覆盖父类事件（不继承），所以每个方法体是 pass。
# obj_parent_resource 的 Outside Room 事件在移植版里就叫 _outside_room()（GMObject 内部变量已改名为 _was_outside），无撞名。
extends "res://objects/obj_parent_resource.gd"


# from objects/obj_slopesa/Create_0.gml
func _create() -> void:
	pass


# from objects/obj_slopesa/Step_2.gml
func _step_end() -> void:
	pass


# from objects/obj_slopesa/Alarm_0.gml
func _alarm_0() -> void:
	pass


# from objects/obj_slopesa/Alarm_5.gml
func _alarm_5() -> void:
	pass


# from objects/obj_slopesa/Alarm_6.gml
func _alarm_6() -> void:
	pass


# from objects/obj_slopesa/Collision_obj_tile_trigger.gml
func _collision_obj_tile_trigger(other: GMObject) -> void:
	pass


# from objects/obj_slopesa/Other_0.gml
func _outside_room() -> void:
	pass


# from objects/obj_slopesa/Other_10.gml
func _user_0() -> void:
	pass


# from objects/obj_slopesa/Other_12.gml
func _user_2() -> void:
	pass


# from objects/obj_slopesa/Other_13.gml
func _user_3() -> void:
	pass


# from objects/obj_slopesa/Other_15.gml
func _user_5() -> void:
	pass


# from objects/obj_slopesa/Other_18.gml
func _user_8() -> void:
	pass


# from objects/obj_slopesa/Draw_0.gml
func _gm_draw() -> void:
	pass


# from objects/obj_slopesa/Mouse_0.gml
func _mouse_0() -> void:
	pass


# from objects/obj_slopesa/Mouse_1.gml
func _mouse_1() -> void:
	pass


# from objects/obj_slopesa/Mouse_4.gml
func _mouse_4() -> void:
	pass


# from objects/obj_slopesa/Mouse_7.gml
func _mouse_7() -> void:
	pass
